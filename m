Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVBCLss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVBCLss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVBCLjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:39:36 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:1456 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262755AbVBCLfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:35:12 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 3 Feb 2005 12:30:22 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: mathieu.okuyama@free.fr, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc3 - BT848 no signal
Message-ID: <20050203113022.GK10602@bytesex>
References: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org> <1107407987.2097.18.camel@lb.loomes.de> <87is5a0wxm.fsf@bytesex.org> <1107428571.2068.4.camel@lb.loomes.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107428571.2068.4.camel@lb.loomes.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > mt2032_set_if_freq failed with -121
> 
> OK here you go.

Thanks, seems to be a initialization order bug which changes the default
state of the tda9887 output ports.  The patch below should fix that.

  Gerd

diff -u linux-2.6.11/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.11/drivers/media/video/tda9887.c	2005-01-25 11:57:21.000000000 +0100
+++ linux/drivers/media/video/tda9887.c	2005-02-03 12:26:16.246003021 +0100
@@ -305,9 +305,9 @@
 	printk("  B5   force mute audio: %s\n",
 	       (buf[1] & 0x20) ? "yes" : "no");
 	printk("  B6   output port 1   : %s\n",
-	       (buf[1] & 0x40) ? "high" : "low");
+	       (buf[1] & 0x40) ? "high (inactive)" : "low (active)");
 	printk("  B7   output port 2   : %s\n",
-	       (buf[1] & 0x80) ? "high" : "low");
+	       (buf[1] & 0x80) ? "high (inactive)" : "low (active)");
 
 	printk(PREFIX "write: byte C 0x%02x\n",buf[2]);
 	printk("  C0-4 top adjustment  : %s dB\n", adjust[buf[2] & 0x1f]);
@@ -545,9 +545,9 @@
 	int rc;
 
 	memset(buf,0,sizeof(buf));
+	tda9887_set_tvnorm(t,buf);
 	buf[1] |= cOutputPort1Inactive;
 	buf[1] |= cOutputPort2Inactive;
-	tda9887_set_tvnorm(t,buf);
 	if (UNSET != t->pinnacle_id) {
 		tda9887_set_pinnacle(t,buf);
 	}
