Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271180AbRHOMzr>; Wed, 15 Aug 2001 08:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271181AbRHOMzi>; Wed, 15 Aug 2001 08:55:38 -0400
Received: from ligarius-fe0.ultra.net ([146.115.8.189]:35844 "EHLO
	ligarius-fe0.ultra.net") by vger.kernel.org with ESMTP
	id <S271180AbRHOMzZ>; Wed, 15 Aug 2001 08:55:25 -0400
Message-ID: <3B7A7238.578D919F@ma.ultranet.com>
Date: Wed, 15 Aug 2001 08:59:36 -0400
From: Jim Houston <jhouston@ma.ultranet.com>
Organization: First Rate Software, Inc.
X-Mailer: Mozilla 4.6 [en] (X11; U; Linux 2.0.33 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: brian@worldcontrol.com, hermes@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org
Subject: [Fwd: Re:[PATCH] eth0: Error -16 writing packet header to BAP]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Brian, David,

I figured out why my last patch didn't work.  The tabs got 
expanded to spaces because I did the old cut and paste.
Please forgive this newbie mistake.

Jim Houston

--   

The patch which follows "fixes" a problem I'm seeing with the
orinoco_cs wireless driver.  The problem results in the error
"Error -110 writing packet header to BAP," and the connection locks up.
This happens almost immediately with the link active. I see this problem
with old "Wavelan Bronze" cards which the driver reports as "Firmware ID 1F
vendor 0x1 (Lucent) version 3.06."  I'm assuming that the problem
is a feature of this old hardware/firmware.  

The change is to some existing error handling (avoidance?) code
which retries if it detects an error setting a BAP offset.  My change
also does this retry if the operation times out.  I looked at the
wvlan_cs driver (which just works) to see if it had a similar
workaround.  It doesn't.

--
Jim Houston


diff -urN -X /home/jim/dontdiff linux-2.4.7-orig/drivers/net/wireless/hermes.c linux-2.4.7/drivers/net/wireless/hermes.c
--- linux-2.4.7-orig/drivers/net/wireless/hermes.c	Tue Jul 31 22:55:00 2001
+++ linux-2.4.7/drivers/net/wireless/hermes.c	Tue Jul 31 22:34:09 2001
@@ -53,9 +53,9 @@
 #include <stdarg.h>
 
 #define DMSG(stuff...) do {printk(KERN_DEBUG "hermes @ 0x%x: " , hw->iobase); \
-			printk(#stuff);} while (0)
+			printk(##stuff);} while (0)
 
-#define DEBUG(lvl, stuff...) if ( (lvl) <= HERMES_DEBUG) DMSG(#stuff)
+#define DEBUG(lvl, stuff...) if ( (lvl) <= HERMES_DEBUG) DMSG(##stuff)
 
 #else /* ! HERMES_DEBUG */
 
@@ -330,20 +330,17 @@
 		reg = hermes_read_reg(hw, oreg);
 	}
 
-	if (reg & HERMES_OFFSET_BUSY) {
-		DEBUG(0,"hermes_bap_seek: returning ETIMEDOUT...\n");
-		return -ETIMEDOUT;
-	}
-
 	/* For some reason, seeking the BAP seems to randomly fail somewhere
 	   (firmware bug?). We retry a few times before giving up. */
-	if (reg & HERMES_OFFSET_ERR) {
-		if (l--) {
-			udelay(1);
-			goto retry;
-		} else
-			return -EIO;
+	if ( (reg & (HERMES_OFFSET_BUSY | HERMES_OFFSET_ERR)) && l--) {
+		udelay(1);
+		goto retry;
 	}
+	if (reg & HERMES_OFFSET_BUSY)
+		return -ETIMEDOUT;
+
+	if (reg & HERMES_OFFSET_ERR)
+		return -EIO;
 
 	return 0;
 }
