Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272736AbRILKXi>; Wed, 12 Sep 2001 06:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272737AbRILKX2>; Wed, 12 Sep 2001 06:23:28 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:14861 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S272736AbRILKXK>; Wed, 12 Sep 2001 06:23:10 -0400
Date: Wed, 12 Sep 2001 12:23:27 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Pascal Schmidt <pleasure.and.pain@web.de>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.2.20pre10: cannot link ISDN into kernel, netif_wake_queue
In-Reply-To: <Pine.LNX.4.33.0109120155440.9784-100000@neptune.sol.net>
Message-ID: <Pine.LNX.4.33.0109121214360.28657-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2001, Pascal Schmidt wrote:

> Well, I already reported something like this for 2.2.20pre9 and was told
> there would be a patch fixing it going to Alan, but this doesn't seem to
> be the case.

Sorry, I can't even remember if I sent the patch to Alan or if I decided 
to wait for a new -pre to resync against.

Anyway, here's a patch with should be applied for 2.2.20.

--Kai

o support for IPAC v2 in the hisax driver
p fix link error when hisax is compiled into the kernel
o some debugging output for Cisco HDLC
o remove some unneeded checks for NULL
o print called number within ttyI emulation when enabled in some
  register (off by default)

diff -ur linux-2.2.20-pre10/drivers/isdn/hisax/asuscom.c linux-2.2.20-pre10.work/drivers/isdn/hisax/asuscom.c
--- linux-2.2.20-pre10/drivers/isdn/hisax/asuscom.c	Wed Sep 12 10:13:53 2001
+++ linux-2.2.20-pre10.work/drivers/isdn/hisax/asuscom.c	Wed Sep 12 10:32:09 2001
@@ -1,4 +1,4 @@
-/* $Id: asuscom.c,v 1.11.6.1 2001/02/16 16:43:25 kai Exp $
+/* $Id: asuscom.c,v 1.11.6.2 2001/07/13 09:20:12 kai Exp $
  *
  * asuscom.c     low level stuff for ASUSCOM NETWORK INC. ISDNLink cards
  *
@@ -20,7 +20,7 @@
 
 extern const char *CardType[];
 
-const char *Asuscom_revision = "$Revision: 1.11.6.1 $";
+const char *Asuscom_revision = "$Revision: 1.11.6.2 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -341,7 +341,7 @@
 	cs->cardmsg = &Asus_card_msg;
 	val = readreg(cs->hw.asus.cfg_reg + ASUS_IPAC_ALE, 
 		cs->hw.asus.cfg_reg + ASUS_IPAC_DATA, IPAC_ID);
-	if (val == 1) {
+	if ((val == 1) || (val == 2)) {
 		cs->subtyp = ASUS_IPAC;
 		cs->hw.asus.adr  = cs->hw.asus.cfg_reg + ASUS_IPAC_ALE;
 		cs->hw.asus.isac = cs->hw.asus.cfg_reg + ASUS_IPAC_DATA;
diff -ur linux-2.2.20-pre10/drivers/isdn/hisax/config.c linux-2.2.20-pre10.work/drivers/isdn/hisax/config.c
--- linux-2.2.20-pre10/drivers/isdn/hisax/config.c	Wed Sep 12 10:13:53 2001
+++ linux-2.2.20-pre10.work/drivers/isdn/hisax/config.c	Wed Sep 12 10:32:09 2001
@@ -434,7 +434,7 @@
 }
 
 #ifndef MODULE
-static void __init HiSax_setup(char *str, int *ints)
+void __init HiSax_setup(char *str, int *ints)
 {
 	int i, j, argc;
 	argc = ints[0];
diff -ur linux-2.2.20-pre10/drivers/isdn/isdn_net.c linux-2.2.20-pre10.work/drivers/isdn/isdn_net.c
--- linux-2.2.20-pre10/drivers/isdn/isdn_net.c	Wed Sep 12 10:13:55 2001
+++ linux-2.2.20-pre10.work/drivers/isdn/isdn_net.c	Wed Sep 12 11:47:36 2001
@@ -1,4 +1,4 @@
-/* $Id: isdn_net.c,v 1.140.6.6 2001/06/11 22:08:37 kai Exp $
+/* $Id: isdn_net.c,v 1.140.6.8 2001/08/14 14:04:21 kai Exp $
 
  * Linux ISDN subsystem, network interfaces and related functions (linklevel).
  *
@@ -191,7 +191,7 @@
 static void isdn_net_ciscohdlck_connected(isdn_net_local *lp);
 static void isdn_net_ciscohdlck_disconnected(isdn_net_local *lp);
 
-char *isdn_net_revision = "$Revision: 1.140.6.6 $";
+char *isdn_net_revision = "$Revision: 1.140.6.8 $";
 
  /*
   * Code for raw-networking over ISDN
@@ -1431,7 +1431,7 @@
 }
 
 /* cisco hdlck device private ioctls */
-static int
+int
 isdn_ciscohdlck_dev_ioctl(struct device *dev, struct ifreq *ifr, int cmd)
 {
 	isdn_net_local *lp = (isdn_net_local *) dev->priv;
@@ -1743,6 +1743,11 @@
 	case CISCO_TYPE_SLARP:
 		isdn_net_ciscohdlck_slarp_in(lp, skb);
 		goto out_free;
+	case CISCO_TYPE_CDP:
+		if (lp->cisco_debserint)
+			printk(KERN_DEBUG "%s: Received CDP packet. use "
+				"\"no cdp enable\" on cisco.\n", lp->name);
+		goto out_free;
 	default:
 		printk(KERN_WARNING "%s: Unknown Cisco type 0x%04x\n",
 		       lp->name, type);
@@ -2016,17 +2021,8 @@
 {
 	ushort max_hlhdr_len = 0;
 	isdn_net_local *lp = (isdn_net_local *) ndev->priv;
-	int drvidx,
-	 i;
+	int drvidx, i;
 
-	if (ndev == NULL) {
-		printk(KERN_WARNING "isdn_net_init: dev = NULL!\n");
-		return -ENODEV;
-	}
-	if (ndev->priv == NULL) {
-		printk(KERN_WARNING "isdn_net_init: dev->priv = NULL!\n");
-		return -ENODEV;
-	}
 	ether_setup(ndev);
 	lp->org_hhc = ndev->hard_header_cache;
 	lp->org_hcu = ndev->header_cache_update;
diff -ur linux-2.2.20-pre10/drivers/isdn/isdn_net.h linux-2.2.20-pre10.work/drivers/isdn/isdn_net.h
--- linux-2.2.20-pre10/drivers/isdn/isdn_net.h	Wed Sep 12 10:13:55 2001
+++ linux-2.2.20-pre10.work/drivers/isdn/isdn_net.h	Wed Sep 12 10:32:09 2001
@@ -1,4 +1,4 @@
-/* $Id: isdn_net.h,v 1.19.6.1 2001/04/20 02:41:58 keil Exp $
+/* $Id: isdn_net.h,v 1.19.6.2 2001/08/14 14:04:21 kai Exp $
 
  * header for Linux ISDN subsystem, network related functions (linklevel).
  *
@@ -36,6 +36,7 @@
 #define CISCO_ADDR_UNICAST    0x0f
 #define CISCO_ADDR_BROADCAST  0x8f
 #define CISCO_CTRL            0x00
+#define CISCO_TYPE_CDP        0x2000
 #define CISCO_TYPE_INET       0x0800
 #define CISCO_TYPE_SLARP      0x8035
 #define CISCO_SLARP_REPLY     0
diff -ur linux-2.2.20-pre10/drivers/isdn/isdn_ppp.c linux-2.2.20-pre10.work/drivers/isdn/isdn_ppp.c
--- linux-2.2.20-pre10/drivers/isdn/isdn_ppp.c	Wed Sep 12 11:46:12 2001
+++ linux-2.2.20-pre10.work/drivers/isdn/isdn_ppp.c	Wed Sep 12 11:47:52 2001
@@ -26,6 +26,7 @@
 #include <linux/version.h>
 #include <linux/poll.h>
 #include <linux/isdn.h>
+#include <linux/isdn_compat.h>
 #include <linux/ppp-comp.h>
 
 #include "isdn_common.h"
diff -ur linux-2.2.20-pre10/drivers/isdn/isdn_tty.c linux-2.2.20-pre10.work/drivers/isdn/isdn_tty.c
--- linux-2.2.20-pre10/drivers/isdn/isdn_tty.c	Wed Sep 12 10:13:55 2001
+++ linux-2.2.20-pre10.work/drivers/isdn/isdn_tty.c	Wed Sep 12 10:32:10 2001
@@ -1,4 +1,4 @@
-/* $Id: isdn_tty.c,v 1.94.6.3 2001/07/03 14:48:25 kai Exp $
+/* $Id: isdn_tty.c,v 1.94.6.5 2001/08/14 14:12:18 kai Exp $
 
  * Linux ISDN subsystem, tty functions and AT-command emulator (linklevel).
  *
@@ -66,7 +66,7 @@
 static int si2bit[8] =
 {4, 1, 4, 4, 4, 4, 4, 4};
 
-char *isdn_tty_revision = "$Revision: 1.94.6.3 $";
+char *isdn_tty_revision = "$Revision: 1.94.6.5 $";
 
 
 /* isdn_tty_try_read() is called from within isdn_tty_rcv_skb()
@@ -1182,8 +1182,6 @@
 
 	if (isdn_tty_paranoia_check(info, tty->device, "isdn_tty_write"))
 		return 0;
-	if (!tty)
-		return 0;
 	if (from_user)
 		down(&info->write_sem);
 	/* See isdn_tty_senddown() */
@@ -2711,6 +2709,10 @@
 			    if (!(m->mdmreg[REG_CIDONCE] & BIT_CIDONCE)) {
 				    isdn_tty_at_cout("\r\nCALLER NUMBER: ", info);
 				    isdn_tty_at_cout(dev->num[info->drv_index], info);
+				    if (m->mdmreg[REG_CDN] & BIT_CDN) {
+					    isdn_tty_at_cout("\r\nCALLED NUMBER: ", info);
+					    isdn_tty_at_cout(info->emu.cpn, info);
+				    }
 			    }
 			}
 			isdn_tty_at_cout("\r\n", info);
@@ -2736,6 +2738,10 @@
 						isdn_tty_at_cout("\r\n", info);
 						isdn_tty_at_cout("CALLER NUMBER: ", info);
 						isdn_tty_at_cout(dev->num[info->drv_index], info);
+						if (m->mdmreg[REG_CDN] & BIT_CDN) {
+							isdn_tty_at_cout("\r\nCALLED NUMBER: ", info);
+							isdn_tty_at_cout(info->emu.cpn, info);
+						}
 					}
 					break;
 				case RESULT_NO_CARRIER:
diff -ur linux-2.2.20-pre10/drivers/isdn/isdn_tty.h linux-2.2.20-pre10.work/drivers/isdn/isdn_tty.h
--- linux-2.2.20-pre10/drivers/isdn/isdn_tty.h	Wed Aug 29 01:35:24 2001
+++ linux-2.2.20-pre10.work/drivers/isdn/isdn_tty.h	Wed Sep 12 11:08:28 2001
@@ -1,4 +1,4 @@
-/* $Id: isdn_tty.h,v 1.22 2000/06/21 09:54:29 keil Exp $
+/* $Id: isdn_tty.h,v 1.22.6.1 2001/08/14 14:12:18 kai Exp $
 
  * header for Linux ISDN subsystem, tty related functions (linklevel).
  *
@@ -85,7 +85,10 @@
 
 #define REG_CPN      23
 #define BIT_CPN       1
+#define REG_CPNFCON  23
 #define BIT_CPNFCON   2
+#define REG_CDN      23
+#define BIT_CDN       4
 
 /* defines for result codes */
 #define RESULT_OK		0
diff -ur linux-2.2.20-pre10/drivers/isdn/isdn_ttyfax.c linux-2.2.20-pre10.work/drivers/isdn/isdn_ttyfax.c
--- linux-2.2.20-pre10/drivers/isdn/isdn_ttyfax.c	Mon Dec 11 01:49:42 2000
+++ linux-2.2.20-pre10.work/drivers/isdn/isdn_ttyfax.c	Wed Sep 12 10:32:10 2001
@@ -1,4 +1,4 @@
-/* $Id: isdn_ttyfax.c,v 1.7 2000/05/11 22:29:21 kai Exp $
+/* $Id: isdn_ttyfax.c,v 1.7.6.1 2001/08/14 14:12:18 kai Exp $
 
  * Linux ISDN subsystem, tty_fax AT-command emulator (linklevel).
  *
@@ -33,7 +33,7 @@
 #include "isdn_ttyfax.h"
 
 
-static char *isdn_tty_fax_revision = "$Revision: 1.7 $";
+static char *isdn_tty_fax_revision = "$Revision: 1.7.6.1 $";
 
 #define PARSE_ERROR1 { isdn_tty_fax_modem_result(1, info); return 1; }
 
@@ -86,7 +86,7 @@
 			break;
 		case 2:	/* +FCON */
 			/* Append CPN, if enabled */
-			if ((m->mdmreg[REG_CPN] & BIT_CPNFCON) &&
+			if ((m->mdmreg[REG_CPNFCON] & BIT_CPNFCON) &&
 				(!(dev->usage[info->isdn_channel] & ISDN_USAGE_OUTGOING))) {
 				sprintf(rs, "/%s", m->cpn);
 				isdn_tty_at_cout(rs, info);

