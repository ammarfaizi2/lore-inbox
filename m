Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315548AbSEHXMY>; Wed, 8 May 2002 19:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315549AbSEHXMW>; Wed, 8 May 2002 19:12:22 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:40225 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S315548AbSEHXMJ>; Wed, 8 May 2002 19:12:09 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A783A7602@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        "'David S. Miller'" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'ak@muc.de'" <ak@muc.de>
Subject: RE: PATCH mm/slab.c against 2.5.15 (was: slab cache broken on spa
	rc64)
Date: Wed, 8 May 2002 18:11:54 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't bother, I'm a dummy.  I botched the second part....

B.

-----Original Message-----
From: Holzrichter, Bruce 
Sent: Wednesday, May 08, 2002 4:04 PM
To: 'David S. Miller'
Cc: linux-kernel@vger.kernel.org; ak@muc.de
Subject: PATCH mm/slab.c against 2.5.15 (was: slab cache broken on
sparc64)


> 
> Do it like this instead.
> 
> 	int fault;
> 	mm_segment_t old_fs;
> 
> 	...
> 
> 	old_fs = get_fs();
> 	set_fs(KERNEL_DS);
> 	fault = __get_user(tmp, pc->name);
> 	set_fs(old_fs);
> 
> 	if (fault) {
> 	...
> 

Dave/Andi 

I've redone my patch against mm/slab.c for 2.5.15, although I can't test on
my Sparc ad I don't have a working kernel 2.5.15 yet for other reasons, but
it does compile.  I have tested against 2.5.13 with this, and it works fine,
with your changes, mentioned above, so there's no reason it shouldn't.

This will make sure the __get_user is called correctly.

Thanks,
Bruce H.


--- linus-2.5/mm/slab.c	Wed May  8 15:51:33 2002
+++ sparctest/mm/slab.c	Wed May  8 15:43:04 2002
@@ -843,10 +843,19 @@
 		list_for_each(p, &cache_chain) {
 			kmem_cache_t *pc = list_entry(p, kmem_cache_t,
next);
 			char tmp;
+			int fault;
+			mm_segment_t old_fs;
+
 			/* This happens when the module gets unloaded and
doesn't
 			   destroy its slab cache and noone else reuses the
vmalloc
 			   area of the module. Print a warning. */
-			if (__get_user(tmp,pc->name)) { 
+
+			old_fs = get_fs();
+			set_fs(KERNEL_DS);
+			fault = __get_user(tmp, pc->name);
+			set_fs(old_fs);
+
+			if (fault) { 
 				printk("SLAB: cache with size %d has lost
its name\n", 
 					pc->objsize); 
 				continue; 
@@ -1912,13 +1921,16 @@
 static int s_show(struct seq_file *m, void *p)
 {
 	kmem_cache_t *cachep = p;
+	mm_segment_t old_fs;
 	struct list_head *q;
 	slab_t		*slabp;
 	unsigned long	active_objs;
 	unsigned long	num_objs;
 	unsigned long	active_slabs = 0;
 	unsigned long	num_slabs;
-	const char *name; 
+	const char *name;
+	char tmp;
+	int fault; 
 
 	if (p == (void*)1) {
 		/*
@@ -1963,11 +1975,13 @@
 	num_objs = num_slabs*cachep->num;
 
 	name = cachep->name; 
-	{
-	char tmp; 
-	if (__get_user(tmp, name)) 
-		name = "broken"; 
-	} 	
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	fault = __get_user(tmp, name);
+	set_fs(old_fs);
+
+	if (fault) name = "broken";
 
 	seq_printf(m, "%-17s %6lu %6lu %6u %4lu %4lu %4u",
 		name, active_objs, num_objs, cachep->objsize,
