Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVJQCez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVJQCez (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 22:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVJQCez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 22:34:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932133AbVJQCey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 22:34:54 -0400
Date: Sun, 16 Oct 2005 19:34:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Serge Belyshev <belyshev@depni.sinp.msu.ru>, linux-kernel@vger.kernel.org,
       khali@linux-fr.org, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <20051016162306.GA10410@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0510161919450.23590@g5.osdl.org>
References: <87fyr2ape5.fsf@foo.vault.bofh.ru> <87slv23bw5.fsf@foo.vault.bofh.ru>
 <20051016162306.GA10410@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Oct 2005, Dipankar Sarma wrote:
> 
> Linus, I don't think this has anything to do with RCU grace periods
> like we discussed previously. I measured on my 3.6GHz x86_64 and
> found that open()/close() pair on /dev/null takes about 45500
> cycles or 12 microseconds. [Does that sound resonable?].

That sounds very slow. I can do a million open/close pairs in 4 seconds on 
a 2.5GHz G5. Maybe you tested a cold-cache case?

Of course, a P4 is just about the worst architecture to test system call 
performance on, so ...

Still, that's 4us. I'm pretty sure some machines will do it in 3 or less 
(in fact, lmbench says 3.17us on another machine of mine for open/close). 
Still, that's only four times faster, so 2 timer ticks should be less than 
5000 file structs to free.

I suspect this patch is worth it for the 2.6.14 timeframe, but I'll wait 
for confirmation.

In fact, for 2.6.14, I'd almost do an even more minimal one. I agree with 
your changing the file counter to an atomic, but I'd rather keep that 
change for later.

Serge, does this alternate patch work for you?

[ cache constructors and destructors are _stupid_. They act exactly the 
  wrong way from a cache standpoint. ]

		Linus

---
diff --git a/fs/dcache.c b/fs/dcache.c
index fb10386..40aaa90 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1731,7 +1731,7 @@ void __init vfs_caches_init(unsigned lon
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, filp_ctor, filp_dtor);
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
 	dcache_init(mempages);
 	inode_init(mempages);
diff --git a/fs/file_table.c b/fs/file_table.c
index 86ec8ae..fbda480 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -39,21 +39,9 @@ void filp_ctor(void * objp, struct kmem_
 {
 	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		unsigned long flags;
-		spin_lock_irqsave(&filp_count_lock, flags);
-		files_stat.nr_files++;
-		spin_unlock_irqrestore(&filp_count_lock, flags);
 	}
 }
 
-void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&filp_count_lock, flags);
-	files_stat.nr_files--;
-	spin_unlock_irqrestore(&filp_count_lock, flags);
-}
-
 static inline void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f =  container_of(head, struct file, f_rcuhead);
@@ -62,6 +50,13 @@ static inline void file_free_rcu(struct 
 
 static inline void file_free(struct file *f)
 {
+	unsigned long flags;
+
+	/* Stupid. Use atomics */
+	spin_lock_irqsave(&filp_count_lock, flags);
+	files_stat.nr_files--;
+	spin_unlock_irqrestore(&filp_count_lock, flags);
+
 	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
 
@@ -73,6 +68,7 @@ struct file *get_empty_filp(void)
 {
 	static int old_max;
 	struct file * f;
+	unsigned long flags;
 
 	/*
 	 * Privileged users can go above max_files
@@ -85,6 +81,11 @@ struct file *get_empty_filp(void)
 	if (f == NULL)
 		goto fail;
 
+	/* Stupid. Use atomics */
+	spin_lock_irqsave(&filp_count_lock, flags);
+	files_stat.nr_files++;
+	spin_unlock_irqrestore(&filp_count_lock, flags);
+
 	memset(f, 0, sizeof(*f));
 	if (security_file_alloc(f))
 		goto fail_sec;
diff --git a/include/linux/file.h b/include/linux/file.h
index f5bbd4c..55f0572 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -60,8 +60,6 @@ extern void put_filp(struct file *);
 extern int get_unused_fd(void);
 extern void FASTCALL(put_unused_fd(unsigned int fd));
 struct kmem_cache_s;
-extern void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags);
-extern void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags);
 
 extern struct file ** alloc_fd_array(int);
 extern void free_fd_array(struct file **, int);
