Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267848AbTBRPCe>; Tue, 18 Feb 2003 10:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267849AbTBRPCe>; Tue, 18 Feb 2003 10:02:34 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:27862 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S267848AbTBRPCc>; Tue, 18 Feb 2003 10:02:32 -0500
Date: Tue, 18 Feb 2003 17:11:38 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH]: M5451 (OSS trident.c) did not come out of reset
Message-ID: <20030218151138.GU2492@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last time I booted 2.5, I noticed that my sound card no longer
works. The card is:

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]
M5451 PCI AC-Link Controller Audio Device (rev 01)

And the computer is a thinkpad R30. It turns out that this patch, from
Alan Cox on 01/11/2002, broke it for me, by failing ali_reset_5451 if
the card doesn't come out of reset:

# --------------------------------------------
# 02/11/01	alan@lxorguk.ukuu.org.uk	1.786.161.45
# [PATCH] some trident needs longer delays to power up codecs
# --------------------------------------------

The 2.4 behaviour is to continue as usual even if the card doesn't
come out of reset, because it's a non fatal error on at least some
cards. This patch reverts the behaviour to the 2.4 behaviour, which
works for me. If anyone knows how to tell for a given card whether
this is a fatal error or not, please let me know and I'll update the
patch.  

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1046  -> 1.1047 
#	 sound/oss/trident.c	1.30    -> 1.31   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/18	mulix@alhambra.mulix.org	1.1047
# The M5451 can sometimes not come out of reset. 
# This is non fatal and it continues to work fine, so print a nasty message
# but don't fail the driver initialization. 
# --------------------------------------------
#
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	Tue Feb 18 10:10:50 2003
+++ b/sound/oss/trident.c	Tue Feb 18 10:10:50 2003
@@ -3933,8 +3933,10 @@
 		udelay(5000);
 	}
 
-	printk(KERN_ERR "ALi 5451 did not come out of reset.\n");
-	return 1;
+	/* This is non fatal if you have a non PM capable codec.. */
+	printk(KERN_ERR "ALi 5451 did not come out of reset "
+	       "- continuing anyway.\n");
+	return 0;
 }
 
 /* AC97 codec initialisation. */







-- 
Muli Ben-Yehuda
http://www.mulix.org
http://syscalltrack.sf.net

