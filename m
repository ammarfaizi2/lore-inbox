Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRJJFOM>; Wed, 10 Oct 2001 01:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274766AbRJJFOF>; Wed, 10 Oct 2001 01:14:05 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:29706 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274757AbRJJFNy>; Wed, 10 Oct 2001 01:13:54 -0400
Message-ID: <3BC3D916.B0284E00@zip.com.au>
Date: Tue, 09 Oct 2001 22:13:58 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Andrea Arcangeli <andrea@suse.de>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
In-Reply-To: <200110100358.NAA17519@isis.its.uow.edu.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> Andrew have you a current version of your lowlatency patches handy?
> 

mm..  Nice people keep sending me updates.  It's at 
http://www.uow.edu.au/~andrewm/linux/schedlat.html and applies
to 2.4.11 with one little reject.  I don't know how it's
performing at present - it's time for another round of tuning
and testing.

wrt this discussion: I would assume that xmms is simply stalling
on disk access.  All it takes is for one of its text pages to be
dropped and it could have to wait a very long time indeed to
come back to life.  The disk read latency could easily exceed
any sane buffering in the sound card or its driver.

The application should be using mlockall(MCL_FUTURE) and it should
run `nice -19'  (SCHED_FIFO and SCHED_RR are rather risky - if the
app gets stuck in a loop, it's time to hit the big button).  If the
app isn't doing both these things then it just doesn't have a chance.

I don't understand why Andrea is pointing at write throttling?  xmms
doesn't do any disk writes, does it??

Andrea's VM has a rescheduling point in shrink_cache(), which is the
analogue of the other VM's page_launder().  This rescheduling point
is *absolutely critial*, because it opens up what is probably the
longest-held spinlock in the kernel (under common use).  If there
were a similar reschedulig point in page_launder(), comparisons
would be more valid...


I would imagine that for a (very) soft requirement such as audio
playback, the below patch, combined with mlockall and renicing
should fix the problems.  I would expect that this patch will
give effects which are similar to the preempt patch.  This is because
most of the other latency problems are under locks - icache/dcache
shrinking and zap_page_range(), etc.

This patch should go into the stock 2.4 kernel.

Oh.  And always remember to `renice -19' your X server.  



--- linux-2.4.11/mm/filemap.c	Tue Oct  9 21:31:40 2001
+++ linux-akpm/mm/filemap.c	Tue Oct  9 21:47:51 2001
@@ -1230,6 +1230,9 @@ found_page:
 		page_cache_get(page);
 		spin_unlock(&pagecache_lock);
 
+		if (current->need_resched)
+			schedule();
+
 		if (!Page_Uptodate(page))
 			goto page_not_up_to_date;
 		generic_file_readahead(reada_ok, filp, inode, page);
@@ -2725,6 +2728,9 @@ generic_file_write(struct file *file,con
 		if (!PageLocked(page)) {
 			PAGE_BUG(page);
 		}
+
+		if (current->need_resched)
+			schedule();
 
 		kaddr = kmap(page);
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
--- linux-2.4.11/fs/buffer.c	Tue Oct  9 21:31:40 2001
+++ linux-akpm/fs/buffer.c	Tue Oct  9 22:08:51 2001
@@ -29,6 +29,7 @@
 /* async buffer flushing, 1999 Andrea Arcangeli <andrea@suse.de> */
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
@@ -231,6 +232,10 @@ static int write_some_buffers(kdev_t dev
 static void write_unlocked_buffers(kdev_t dev)
 {
 	do {
+		if (unlikely(current->need_resched)) {
+			__set_current_state(TASK_RUNNING);
+			schedule();
+		}
 		spin_lock(&lru_list_lock);
 	} while (write_some_buffers(dev));
 	run_task_queue(&tq_disk);
--- linux-2.4.11/fs/proc/array.c	Sun Sep 23 12:48:44 2001
+++ linux-akpm/fs/proc/array.c	Tue Oct  9 21:47:51 2001
@@ -414,6 +414,9 @@ static inline void statm_pte_range(pmd_t
 		pte_t page = *pte;
 		struct page *ptpage;
 
+		if (current->need_resched)
+			schedule();	/* For `top' and `ps' */
+
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
--- linux-2.4.11/fs/proc/generic.c	Sun Sep 23 12:48:44 2001
+++ linux-akpm/fs/proc/generic.c	Tue Oct  9 21:47:51 2001
@@ -98,6 +98,9 @@ proc_file_read(struct file * file, char 
 				retval = n;
 			break;
 		}
+
+		if (current->need_resched)
+			schedule();	/* Some proc files are large */
 		
 		/* This is a hack to allow mangling of file pos independent
  		 * of actual bytes read.  Simply place the data at page,
