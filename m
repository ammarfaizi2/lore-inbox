Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbRGZUQT>; Thu, 26 Jul 2001 16:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268686AbRGZUQJ>; Thu, 26 Jul 2001 16:16:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38661 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267771AbRGZUQB>;
	Thu, 26 Jul 2001 16:16:01 -0400
Date: Thu, 26 Jul 2001 21:15:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        torvalds@transmeta.com, tytso@valinux.com
Cc: Dawson Engler <engler@csl.stanford.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Evan Parker <nave@stanford.edu>,
        linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
Message-ID: <20010726211558.F2200@flint.arm.linux.org.uk>
In-Reply-To: <200107260113.SAA11847@csl.Stanford.EDU> <602725597.996180886@[169.254.62.211]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <602725597.996180886@[169.254.62.211]>; from linux-kernel@alex.org.uk on Thu, Jul 26, 2001 at 08:54:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 08:54:48PM +0100, Alex Bligh - linux-kernel wrote:
> May be I'm being dumb here, and without wishing to open the 'volatile'
> can of worms elsewhere, but:
> 
>    static char * tmp_buf;

Here is the fix...  I've updated it a bit to plug another small race in
rs_write as well.

The following code uses the tmp_buf_sem to lock the creation and freeing
of the tmp_buf page.  This same lock is used to prevent concurrent accesses
to this very same page in rs_write().

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

--- orig/drivers/char/serial.c	Sat Jul 21 10:46:42 2001
+++ linux/drivers/char/serial.c	Thu Jul 26 21:14:12 2001
@@ -1848,12 +1848,17 @@
 	if (serial_paranoia_check(info, tty->device, "rs_write"))
 		return 0;
 
-	if (!tty || !info->xmit.buf || !tmp_buf)
+	if (!tty || !info->xmit.buf)
 		return 0;
 
 	save_flags(flags);
 	if (from_user) {
 		down(&tmp_buf_sem);
+		if (!tmp_buf) {
+			up(&tmp_buf_sem);
+			restore_flags(flags);
+			return 0;
+		}
 		while (1) {
 			int c1;
 			c = CIRC_SPACE_TO_END(info->xmit.head,
@@ -3129,7 +3134,6 @@
 {
 	struct async_struct	*info;
 	int 			retval, line;
-	unsigned long		page;
 
 	MOD_INC_USE_COUNT;
 	line = MINOR(tty->device) - tty->driver.minor_start;
@@ -3157,17 +3161,16 @@
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 #endif
 
+	down(&tmp_buf_sem);
 	if (!tmp_buf) {
-		page = get_zeroed_page(GFP_KERNEL);
-		if (!page) {
+		tmp_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+		if (!tmp_buf) {
+			up(&tmp_buf_sem);
 			MOD_DEC_USE_COUNT;
 			return -ENOMEM;
 		}
-		if (tmp_buf)
-			free_page(page);
-		else
-			tmp_buf = (unsigned char *) page;
 	}
+	up(&tmp_buf_sem);
 
 	/*
 	 * If the port is the middle of closing, bail out now
@@ -5666,12 +5669,13 @@
 		if (DEACTIVATE_FUNC(brd->dev))
 			(DEACTIVATE_FUNC(brd->dev))(brd->dev);
 	}
-#endif	
+#endif
+	down(&tmp_buf_sem);
 	if (tmp_buf) {
-		unsigned long pg = (unsigned long) tmp_buf;
+		free_page(tmp_buf);
 		tmp_buf = NULL;
-		free_page(pg);
 	}
+	up(&tmp_buf_sem);
 	
 #ifdef ENABLE_SERIAL_PCI
 	if (serial_pci_driver.name[0])
