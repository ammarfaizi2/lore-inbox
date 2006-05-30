Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWE3OeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWE3OeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWE3OeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:34:17 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:47563 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751180AbWE3OeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:34:16 -0400
Message-ID: <348999644.00549@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 30 May 2006 22:34:18 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 00/32] Adaptive readahead V14
Message-ID: <20060530143417.GA9126@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Jens Axboe <axboe@suse.de>, Michael Tokarev <mjt@tls.msk.ru>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <348745084.15239@ustc.edu.cn> <44788C8A.2070900@tls.msk.ru> <348818092.32485@ustc.edu.cn> <4479F8B5.90906@tls.msk.ru> <20060529030152.GA5994@mail.ustc.edu.cn> <20060530092309.GH4199@suse.de> <20060530113221.GA8665@mail.ustc.edu.cn> <20060530122934.GT4199@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530122934.GT4199@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 02:29:34PM +0200, Jens Axboe wrote:
> On Tue, May 30 2006, Wu Fengguang wrote:
> > On Tue, May 30, 2006 at 11:23:10AM +0200, Jens Axboe wrote:
> > > On Mon, May 29 2006, Wu Fengguang wrote:
> > > > On Sun, May 28, 2006 at 11:23:33PM +0400, Michael Tokarev wrote:
> > > > > Wu Fengguang wrote:
> > > > > > 
> > > > > > It's not quite reasonable for readahead to worry about media errors.
> > > > > > If the media fails, fix it. Or it will hurt read sooner or later.
> > > > > 
> > > > > Well... In reality, it is just the opposite.
> > > > > 
> > > > > Suppose there's a CD-rom with a scratch/etc, one sector is unreadable.
> > > > > In order to "fix" it, one have to read it and write to another CD-rom,
> > > > > or something.. or just ignore the error (if it's just a skip in a video
> > > > > stream).  Let's assume the unreadable block is number U.
> > > > > 
> > > > > But current behavior is just insane.  An application requests block
> > > > > number N, which is before U. Kernel tries to read-ahead blocks N..U.
> > > > > Cdrom drive tries to read it, re-read it.. for some time.  Finally,
> > > > > when all the N..U-1 blocks are read, kernel returns block number N
> > > > > (as requested) to an application, successefully.
> > > > > 
> > > > > Now an app requests block number N+1, and kernel tries to read
> > > > > blocks N+1..U+1.  Retrying again as in previous step.
> > > > > 
> > > > > And so on, up to when an app requests block number U-1.  And when,
> > > > > finally, it requests block U, it receives read error.
> > > > > 
> > > > > So, kernel currentry tries to re-read the same failing block as
> > > > > many times as the current readahead value (256 (times?) by default).
> > > > 
> > > > Good insight... But I'm not sure about it.
> > > > 
> > > > Jens, will a bad sector cause the _whole_ request to fail?
> > > > Or only the page that contains the bad sector?
> > > 
> > > Depends entirely on the driver, and that point we've typically lost the
> > > fact that this is a read-ahead request and could just be tossed. In
> > > fact, the entire request may consist of read-ahead as well as normal
> > > read entries.
> > > 
> > > For ide-cd, it tends do only end the first part of the request on a
> > > medium error. So you may see a lot of repeats :/
> > 
> > Another question about it:
> >         If the block layer issued a request, which happened to contain
> >         R ranges of B bad blocks, i.e. 3 ranges of 9 bad-blocks:
> >                 ___b_____bb___________bbbbbb____
> >         How many retries will incur? 1, 3, 9, or something else?
> >         If it is 3 or more, then we are even more bad luck :(
> 
> Again, this is driver specific. But for ide-cd, if it's using PIO the
> right thing should happen since we do each chunk individually. For dma
> it looks much worse, since we only get an EIO back from the hardware for
> the entire range. It wont do the right thing at all, only for the very
> last thing when get get past the last bbbbbb block.
> 
> > Will it be suitable to _automatically_ apply the following retracting
> > policy on I/O error? Please comment if there's better ways:
> 
> Probably it should be even more aggressively scaling down. The real
> problem is the drivers of course, we should spend some time fixing them
> up too.

nod, it's so frustrating...

Updated the patch, please comment if necessary.

With this patch, retries are reduced from, say, 256, to 5.

Wu
---

--- linux.orig/mm/filemap.c
+++ linux/mm/filemap.c
@@ -809,6 +809,32 @@ grab_cache_page_nowait(struct address_sp
 EXPORT_SYMBOL(grab_cache_page_nowait);
 
 /*
+ * CD/DVDs are error prone. When a medium error occurs, the driver may fail
+ * a _large_ part of the i/o request. Imagine the worst scenario:
+ *
+ *      ---R__________________________________________B__________
+ *         ^ reading here                             ^ bad block(assume 4k)
+ *
+ * read(R) => miss => readahead(R...B) => media error => frustrating retries
+ * => failing the whole request => read(R) => read(R+1) =>
+ * readahead(R+1...B+1) => bang => read(R+2) => read(R+3) =>
+ * readahead(R+3...B+2) => bang => read(R+3) => read(R+4) =>
+ * readahead(R+4...B+3) => bang => read(R+4) => read(R+5) => ......
+ *
+ * It is going insane. Fix it by quickly scale down the readahead size.
+ */
+static void shrink_readahead_size_eio(struct file *filp,
+					struct file_ra_state *ra)
+{
+	if (!ra->ra_pages)
+		return;
+
+	ra->ra_pages /= 4;
+	printk(KERN_WARNING "Retracting readahead size of %s to %lu\n",
+			filp->f_dentry->d_iname, ra->ra_pages);
+}
+
+/*
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level
  * stuff.
@@ -983,6 +1009,7 @@ readpage:
 				}
 				unlock_page(page);
 				error = -EIO;
+				shrink_readahead_size_eio(filp, &ra);
 				goto readpage_error;
 			}
 			unlock_page(page);
@@ -1535,6 +1562,7 @@ page_not_uptodate:
 	 * Things didn't work out. Return zero to tell the
 	 * mm layer so, possibly freeing the page cache page first.
 	 */
+	shrink_readahead_size_eio(file, ra);
 	page_cache_release(page);
 	return NULL;
 }
