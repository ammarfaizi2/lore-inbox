Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265885AbVBDNFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbVBDNFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266053AbVBDNFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:05:32 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:19386 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265968AbVBDNFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:05:13 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 4 Feb 2005 14:01:03 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] tv-card tuner fixup
Message-ID: <20050204130102.GA24220@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

That one should go into 2.6.11.

- fix initialization order bug.
- disable + comment current secam tweak, will not work that way ...

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/tda9887.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff -u linux-2.6.11/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.11/drivers/media/video/tda9887.c	2005-02-04 11:26:26.000000000 +0100
+++ linux/drivers/media/video/tda9887.c	2005-02-04 12:43:57.615444344 +0100
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
@@ -545,19 +545,24 @@
 	int rc;
 
 	memset(buf,0,sizeof(buf));
+	tda9887_set_tvnorm(t,buf);
 	buf[1] |= cOutputPort1Inactive;
 	buf[1] |= cOutputPort2Inactive;
-	tda9887_set_tvnorm(t,buf);
 	if (UNSET != t->pinnacle_id) {
 		tda9887_set_pinnacle(t,buf);
 	}
 	tda9887_set_config(t,buf);
 	tda9887_set_insmod(t,buf);
 
+#if 0
+	/* This as-is breaks some cards, must be fixed in a
+	 * card-specific way, probably using TDA9887_SET_CONFIG to
+	 * turn on/off port2 */
 	if (t->std & V4L2_STD_SECAM_L) {
 		/* secam fixup (FIXME: move this to tvnorms array?) */
 		buf[1] &= ~cOutputPort2Inactive;
 	}
+#endif
 
 	dprintk(PREFIX "writing: b=0x%02x c=0x%02x e=0x%02x\n",
 		buf[1],buf[2],buf[3]);

-- 
#define printk(args...) fprintf(stderr, ## args)
