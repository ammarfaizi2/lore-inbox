Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130745AbRACUep>; Wed, 3 Jan 2001 15:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130344AbRACUe2>; Wed, 3 Jan 2001 15:34:28 -0500
Received: from [212.104.23.136] ([212.104.23.136]:65408 "EHLO
	spartaco.xcal.net") by vger.kernel.org with ESMTP
	id <S130983AbRACUdY>; Wed, 3 Jan 2001 15:33:24 -0500
Date: Wed, 3 Jan 2001 20:58:34 +0100
From: Andrea Baldoni <abaldoni@xcal.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] isdn iprofd hang ttyI1...
Message-ID: <20010103205834.A9742@xcal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The iprofd contained in isdnutils 3.0 use the same buffer and buffer size
in GETting and SETting via IOCTL IIOC[GS]ETPRF the virtual modem profiles.

The kernel use different sizes, so iprofd set incorrect data, resulting in a
hang of the ttyI from 1 to last. I suppose the right way to implement profile
save & restore will be kernel-version independent and maybe I will work on
that, but at the moment I made the IIOCGETPRF and IIOCSETPRF IOCTLs symmetric:

patch (for 2.4.0-prerelease)



--- drivers/isdn/isdn_common.c.orig	Wed Jan  3 20:39:30 2001
+++ drivers/isdn/isdn_common.c	Wed Jan  3 20:42:16 2001
@@ -1512,7 +1512,7 @@
 					int i;
 
 					if ((ret = verify_area(VERIFY_READ, (void *) arg,
-					(ISDN_MODEM_NUMREG + ISDN_MSNLEN)
+					(ISDN_MODEM_NUMREG + ISDN_MSNLEN + ISDN_LMSNLEN)
 						   * ISDN_MAX_CHANNELS)))
 						return ret;
 
@@ -1521,6 +1521,9 @@
 						     ISDN_MODEM_NUMREG))
 							return -EFAULT;
 						p += ISDN_MODEM_NUMREG;
+						if (copy_from_user(dev->mdm.info[i].emu.plmsn, p, ISDN_LMSNLEN))
+							return -EFAULT;
+						p += ISDN_LMSNLEN;
 						if (copy_from_user(dev->mdm.info[i].emu.pmsn, p, ISDN_MSNLEN))
 							return -EFAULT;
 						p += ISDN_MSNLEN;



Ciao,
 Andrea Baldoni
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
