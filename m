Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269309AbUINL1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269309AbUINL1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269313AbUINLUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:20:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32746 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269280AbUINLQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:16:06 -0400
Date: Tue, 14 Sep 2004 13:06:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [patch] sched, tty: fix scheduling latencies in tty_io.c
Message-ID: <20040914110611.GA32077@elte.hu>
References: <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20040914110237.GC31370@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch fixes long scheduling latencies in tty_read() and 
tty_write() caused by the BKL.

has been tested as part of the -VP patchset and the tty_read() side 
has also been tested in earlier -mm trees.

	Ingo

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-tty_io.patch"


the attached patch fixes long scheduling latencies in tty_read() and
tty_write() caused by the BKL.

has been tested as part of the -VP patchset and the tty_read() side
has also been tested in earlier -mm trees.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/drivers/char/tty_io.c.orig	
+++ linux/drivers/char/tty_io.c	
@@ -660,12 +660,10 @@ static ssize_t tty_read(struct file * fi
 	if (!tty || (test_bit(TTY_IO_ERROR, &tty->flags)))
 		return -EIO;
 
-	lock_kernel();
 	if (tty->ldisc.read)
 		i = (tty->ldisc.read)(tty,file,buf,count);
 	else
 		i = -EIO;
-	unlock_kernel();
 	if (i > 0)
 		inode->i_atime = CURRENT_TIME;
 	return i;
@@ -688,17 +686,13 @@ static inline ssize_t do_tty_write(
 		return -ERESTARTSYS;
 	}
 	if ( test_bit(TTY_NO_WRITE_SPLIT, &tty->flags) ) {
-		lock_kernel();
 		written = write(tty, file, buf, count);
-		unlock_kernel();
 	} else {
 		for (;;) {
 			unsigned long size = max((unsigned long)PAGE_SIZE*2, 16384UL);
 			if (size > count)
 				size = count;
-			lock_kernel();
 			ret = write(tty, file, buf, size);
-			unlock_kernel();
 			if (ret <= 0)
 				break;
 			written += ret;

--tKW2IUtsqtDRztdT--
