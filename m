Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292765AbSBZT3L>; Tue, 26 Feb 2002 14:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292763AbSBZT2x>; Tue, 26 Feb 2002 14:28:53 -0500
Received: from ns.suse.de ([213.95.15.193]:34567 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292762AbSBZT2s>;
	Tue, 26 Feb 2002 14:28:48 -0500
Date: Tue, 26 Feb 2002 20:27:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [CRASH] gdth / __block_prepare_write: zeroing uptodate buffer! / NMI Watchdog detected LOCKUP
Message-ID: <20020226202728.Y4036@inspiron.school.suse.de>
In-Reply-To: <20020226184043.GA10420@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020226184043.GA10420@paradigm.rfc822.org>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 07:40:43PM +0100, Florian Lohoff wrote:
> 
> Hi,
> i have been looking for deadlocks we are experiencing on a couple of 
> SMP machines (Dual Celeron and Dual PIII). After a night stressing a
> spare machine with dbench/bonnie++/tcpspray the machine locked up 30
> minutes after i killed the test. The last messages on the console were:
> 
> __block_prepare_write: zeroing uptodate buffer!
> 
> 15 times - Machine was answering ping first but stopped after a couple
> of minutes. Another couple of minutes later the nmi_watchdog stepped in
> and produced an oops:


the lockup should not be related to the above messages (looks more like
a driver bug).

But for the message thanks to Andrew's great testing effort, I found
some fs data (not metadata, so not that severe) corruption bug that
could generate the above message, here it is:

--- 2.4.18rc4aa1/fs/buffer.c.~1~	Sat Feb 23 08:21:00 2002
+++ 2.4.18rc4aa1/fs/buffer.c	Sun Feb 24 04:48:03 2002
@@ -1721,6 +1721,13 @@
 			if (buffer_new(bh)) {
 				unmap_underlying_metadata(bh);
 				if (Page_Uptodate(page)) {
+					/*
+					 * Avoid new and uptodate to be set at the same time
+					 * so we can retain the buffer_uptodate() bugcheck in
+					 * the undo/fixup pass below (goto out path).
+					 */
+					clear_bit(BH_New, &bh->b_state);
+
 					set_bit(BH_Uptodate, &bh->b_state);
 					continue;
 				}
@@ -1757,8 +1764,16 @@
 	 * Zero out any newly allocated blocks to avoid exposing stale
 	 * data.  If BH_New is set, we know that the block was newly
 	 * allocated in the above loop.
+	 *
+	 * Details:
+	 * 1) hole in uptodate page, get_block(create) allocate the block, so the buffer is
+	 *    new and additionally we also mark it uptodate (so remeber to clear BH_New
+	 *    above to avoid triggering the "zeroing" printk below).
+	 * 2) we must stop the "undo/clear" fixup pass not at the caller "to" but at the last
+	 *    block that we successfully arrived in the main loop.
 	 */
 	bh = head;
+	to = block_start; /* stop at the last successfully handled block */
 	block_start = 0;
 	do {
 		block_end = block_start+blocksize;



Andrew said it doesn't make the message go away, and infact I now
noticed that after the above fix the buffer_uptodate will generate false
positives, think an uptodate but unmapped buffer, uptodate because it
was an hole.

So in short I did now this new untested patch that should remove the
false positive too. The bugcheck was helpful to find the other bugs, but
now that the other bugs are fixed, I think we cannot keep it because
we must skip over those valid uptodate and newly mapped buffers and I
documented why in the patch.

diff -urN 2.4.18/fs/buffer.c 2.4.18aa1/fs/buffer.c
--- 2.4.18/fs/buffer.c	Tue Feb 26 17:51:28 2002
+++ 2.4.18aa1/fs/buffer.c	Tue Feb 26 20:23:33 2002
@@ -1680,8 +1680,21 @@
 	 * Zero out any newly allocated blocks to avoid exposing stale
 	 * data.  If BH_New is set, we know that the block was newly
 	 * allocated in the above loop.
+	 *
+	 * Details the buffer can be new and uptodate because:
+	 * 1) hole in uptodate page, get_block(create) allocate the block, so the buffer is
+	 *    new and additionally we also mark it uptodate
+	 * 2) The buffer is not mapped and uptodate due a previous partial read.
+	 *
+	 * We can always ignore uptodate buffers here, if you mark a buffer uptodate
+	 * you must make sure it contains the right data first.
 	 */
 	bh = head;
+	/*
+	 * We must stop the "undo/clear" fixup pass not at the caller "to" but at the last
+	 * block that we successfully arrived in the main loop.
+	 */
+	to = block_start; /* stop at the last successfully handled block */
 	block_start = 0;
 	do {
 		block_end = block_start+blocksize;
@@ -1689,9 +1702,7 @@
 			goto next_bh;
 		if (block_start >= to)
 			break;
-		if (buffer_new(bh)) {
-			if (buffer_uptodate(bh))
-				printk(KERN_ERR "%s: zeroing uptodate buffer!\n", __FUNCTION__);
+		if (buffer_new(bh) && !buffer_uptodate(bh)) {
 			memset(kaddr+block_start, 0, bh->b_size);
 			set_bit(BH_Uptodate, &bh->b_state);
 			mark_buffer_dirty(bh);


comments Andrew?

Andrea
