Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRAJHbO>; Wed, 10 Jan 2001 02:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRAJHbF>; Wed, 10 Jan 2001 02:31:05 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:36234 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131565AbRAJHax>; Wed, 10 Jan 2001 02:30:53 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.10.10101091447540.2633-100000@penguin.transmeta.com>
From: Christoph Rohland <cr@sap.com>
Date: 10 Jan 2001 08:33:47 +0100
Message-ID: <m3itnneu90.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds <torvalds@transmeta.com> writes:

> I'd really like an opinion on whether this is truly legal or not? After
> all, it does change the behaviour to mean "pages are locked only if they
> have been mapped into virtual memory". Which is not what it used to mean.
> 
> Arguably the new semantics are perfectly valid semantics on their
> own, but I'm not sure they are acceptable.

I just checked SuS and they do not list SHM_LOCK as command at all.

> In contrast, the PG_realdirty approach would give the old behaviour of
> truly locked-down shm segments, with not significantly different
> complexity behaviour.
>
> What do other UNIXes do for shm_lock()?
> 
> The Linux man-page explicitly states for SHM_LOCK that
> 
> 	The user must fault in any pages that are required to be present
> 	after locking is enabled.
> 
> which kind of implies to me that the VM_LOCKED implementation is ok.

Yes.

> HOWEVER, looking at the HP-UX man-page, for example, certainly implies
> that the PG_realdirty approach is the correct one. 

Yes.

> The IRIX man-pages in contrast say
> 
> 				Locking occurs per address space;
>         multiple processes or sprocs mapping the area at different
>         addresses each need to issue the lock (this is primarily an
>         issue with the per-process page tables).
> 
> which again implies that they've done something akin to a VM_LOCKED
> implementation.

So Irix does something quite different. For Irix SHM_LOCK is a special
version of mlock...

> Does anybody have any better pointers, ideas, or opinions?

I think the VM_LOCKED approach is the best: 

- SuS does not specify anything, the different vendors do different
  things. So people using SHM_LOCK have to be aware that the details
  differ.
- Technically this is the fastest approach for attached segments: We
  do not scan the relevent vmas at all and by doing so we keep the
  overhead lowest. And I do not see a reason to use SHM_LOCK besides
  performance.

BTW I also have a patch appended which bumps the page count. Works
also, is also small, but we will have a higher soft fault rate with
that.

Greetings 
                Christoph

diff -uNr 2.4.0/ipc/shm.c c/ipc/shm.c
--- 2.4.0/ipc/shm.c	Mon Jan  8 11:24:39 2001
+++ c/ipc/shm.c	Tue Jan  9 17:48:55 2001
@@ -121,6 +121,7 @@
 {
 	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	shm_rmid (shp->id);
+	shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
 	kfree (shp);
 }
@@ -467,10 +468,10 @@
 		if(err)
 			goto out_unlock;
 		if(cmd==SHM_LOCK) {
-			shp->shm_file->f_dentry->d_inode->u.shmem_i.locked = 1;
+			shmem_lock(shp->shm_file, 1);
 			shp->shm_flags |= SHM_LOCKED;
 		} else {
-			shp->shm_file->f_dentry->d_inode->u.shmem_i.locked = 0;
+			shmem_lock(shp->shm_file, 0);
 			shp->shm_flags &= ~SHM_LOCKED;
 		}
 		shm_unlock(shmid);
diff -uNr 2.4.0/mm/shmem.c c/mm/shmem.c
--- 2.4.0/mm/shmem.c	Mon Jan  8 11:24:39 2001
+++ c/mm/shmem.c	Tue Jan  9 18:04:16 2001
@@ -310,6 +310,8 @@
 	}
 	/* We have the page */
 	SetPageUptodate (page);
+	if (info->locked)
+		page_cache_get(page);
 
 cached_page:
 	UnlockPage (page);
@@ -399,6 +401,32 @@
 	spin_unlock (&sb->u.shmem_sb.stat_lock);
 	buf->f_namelen = 255;
 	return 0;
+}
+
+void shmem_lock(struct file * file, int lock)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	struct shmem_inode_info * info = &inode->u.shmem_i;
+	struct page * page;
+	unsigned long idx, size;
+
+	if (info->locked == lock)
+		return;
+	down(&inode->i_sem);
+	info->locked = lock;
+	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	for (idx = 0; idx < size; idx++) {
+		page = find_lock_page(inode->i_mapping, idx);
+		if (!page)
+			continue;
+		if (!lock) {
+			/* release the extra count and our reference */
+			page_cache_release(page);
+			page_cache_release(page);
+		}
+		UnlockPage(page);
+	}
+	up(&inode->i_sem);
 }
 
 /*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
