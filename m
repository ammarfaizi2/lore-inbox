Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266696AbRGYI1q>; Wed, 25 Jul 2001 04:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266698AbRGYI1g>; Wed, 25 Jul 2001 04:27:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29444 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266696AbRGYI1a>;
	Wed, 25 Jul 2001 04:27:30 -0400
Date: Wed, 25 Jul 2001 09:27:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Evan Parker <nave@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, tytso@valinux.com,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: Re: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
Message-ID: <20010725092732.A21614@flint.arm.linux.org.uk>
In-Reply-To: <Pine.GSO.4.31.0107241704430.11742-100000@myth10.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0107241704430.11742-100000@myth10.Stanford.EDU>; from nave@stanford.edu on Tue, Jul 24, 2001 at 05:08:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 05:08:23PM -0700, Evan Parker wrote:
> One of them, the last one, is pretty clearly a bug, but the
> other 10 are questionable.  Those 10 are all simple variations on the
> following code:
> 
> Start --->
> 	if (!tmp_buf) {
> 		page = get_free_page(GFP_KERNEL);
> 
> Error --->
> 		if (tmp_buf)
> 			free_page(page);
> 		else
> 			tmp_buf = (unsigned char *) page;
> 	}

The following patch fixes this:

--- orig/drivers/char/serial.c	Sat Jul 21 10:46:42 2001
+++ linux/drivers/char/serial.c	Wed Jul 25 09:19:49 2001
@@ -3157,17 +3157,17 @@
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 #endif
 
+	down(&tmp_buf_sem);
 	if (!tmp_buf) {
 		page = get_zeroed_page(GFP_KERNEL);
 		if (!page) {
+			up(&tmp_buf_sem);
 			MOD_DEC_USE_COUNT;
 			return -ENOMEM;
 		}
-		if (tmp_buf)
-			free_page(page);
-		else
-			tmp_buf = (unsigned char *) page;
+		tmp_buf = (unsigned char *) page;
 	}
+	up(&tmp_buf_sem);
 
 	/*
 	 * If the port is the middle of closing, bail out now
@@ -5666,12 +5666,14 @@
 		if (DEACTIVATE_FUNC(brd->dev))
 			(DEACTIVATE_FUNC(brd->dev))(brd->dev);
 	}
-#endif	
+#endif
+	down(&tmp_buf_sem);
 	if (tmp_buf) {
 		unsigned long pg = (unsigned long) tmp_buf;
 		tmp_buf = NULL;
 		free_page(pg);
 	}
+	up(&tmp_buf_sem);
 	
 #ifdef ENABLE_SERIAL_PCI
 	if (serial_pci_driver.name[0])


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

