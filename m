Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266781AbUG1HMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266781AbUG1HMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUG1HMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:12:18 -0400
Received: from ozlabs.org ([203.10.76.45]:64393 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266781AbUG1HLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:46 -0400
Date: Wed, 28 Jul 2004 16:53:08 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [1/15] orinoco merge preliminaries - squash backwards compatibility
Message-ID: <20040728065308.GD16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com> <20040715010137.GB3697@zax> <41068E4B.2040507@pobox.com> <20040728065128.GC16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065128.GC16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove various bits of code in the orinoco driver for backwards
compatibility with older kernels: old versions of the wireless
extensions, lack of MODULE_LICENSE, older PCMCIA interfaces.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c
+++ working-2.6/drivers/net/wireless/orinoco.c
@@ -446,9 +446,7 @@
 
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for Lucent Orinoco, Prism II based and similar wireless cards");
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("Dual MPL/GPL");
-#endif
 
 /* Level of debugging. Used in the macros in orinoco.h */
 #ifdef ORINOCO_DEBUG
@@ -464,11 +462,6 @@
 /* Compile time configuration and compatibility stuff               */
 /********************************************************************/
 
-/* Wireless extensions backwards compatibility */
-#ifndef SIOCIWFIRSTPRIV
-#define SIOCIWFIRSTPRIV		SIOCDEVPRIVATE
-#endif /* SIOCIWFIRSTPRIV */
-
 /* We do this this way to avoid ifdefs in the actual code */
 #ifdef WIRELESS_SPY
 #define SPY_NUMBER(priv)	(priv->spy_number)
@@ -1614,13 +1607,11 @@
 				le16_to_cpu(tallies.RxDiscards_WEPExcluded);
 		wstats->discard.misc +=
 			le16_to_cpu(tallies.TxDiscardsWrongSA);
-#if WIRELESS_EXT > 11
 		wstats->discard.fragment +=
 			le16_to_cpu(tallies.RxMsgInBadMsgFragments);
 		wstats->discard.retries +=
 			le16_to_cpu(tallies.TxRetryLimitExceeded);
 		/* wstats->miss.beacon - no match */
-#endif /* WIRELESS_EXT > 11 */
 	}
 	break;
 	case HERMES_INQ_LINKSTATUS: {
@@ -2582,10 +2573,8 @@
 
 	/* Much of this shamelessly taken from wvlan_cs.c. No idea
 	 * what it all means -dgibson */
-#if WIRELESS_EXT > 10
 	range.we_version_compiled = WIRELESS_EXT;
 	range.we_version_source = 11;
-#endif /* WIRELESS_EXT > 10 */
 
 	range.min_nwid = range.max_nwid = 0; /* We don't use nwids */
 
@@ -2612,22 +2601,17 @@
 		range.max_qual.qual = 0;
 		range.max_qual.level = 0;
 		range.max_qual.noise = 0;
-#if WIRELESS_EXT > 11
 		range.avg_qual.qual = 0;
 		range.avg_qual.level = 0;
 		range.avg_qual.noise = 0;
-#endif /* WIRELESS_EXT > 11 */
-
 	} else {
 		range.max_qual.qual = 0x8b - 0x2f;
 		range.max_qual.level = 0x2f - 0x95 - 1;
 		range.max_qual.noise = 0x2f - 0x95 - 1;
-#if WIRELESS_EXT > 11
 		/* Need to get better values */
 		range.avg_qual.qual = 0x24;
 		range.avg_qual.level = 0xC2;
 		range.avg_qual.noise = 0x9E;
-#endif /* WIRELESS_EXT > 11 */
 	}
 
 	err = orinoco_hw_get_bitratelist(priv, &numrates,
@@ -2680,7 +2664,6 @@
 	range.txpower[0] = 15; /* 15dBm */
 	range.txpower_capa = IW_TXPOW_DBM;
 
-#if WIRELESS_EXT > 10
 	range.retry_capa = IW_RETRY_LIMIT | IW_RETRY_LIFETIME;
 	range.retry_flags = IW_RETRY_LIMIT;
 	range.r_time_flags = IW_RETRY_LIFETIME;
@@ -2688,7 +2671,6 @@
 	range.max_retry = 65535;	/* ??? */
 	range.min_r_time = 0;
 	range.max_r_time = 65535 * 1000;	/* ??? */
-#endif /* WIRELESS_EXT > 10 */
 
 	if (copy_to_user(rrq->pointer, &range, sizeof(range)))
 		return -EFAULT;
@@ -3354,7 +3336,6 @@
 	return err;
 }
 
-#if WIRELESS_EXT > 10
 static int orinoco_ioctl_getretry(struct net_device *dev, struct iw_param *rrq)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
@@ -3406,7 +3387,6 @@
 
 	return err;
 }
-#endif /* WIRELESS_EXT > 10 */
 
 static int orinoco_ioctl_setibssport(struct net_device *dev, struct iwreq *wrq)
 {
@@ -3790,7 +3770,6 @@
 		wrq->u.txpower.flags = IW_TXPOW_DBM;
 		break;
 
-#if WIRELESS_EXT > 10
 	case SIOCSIWRETRY:
 		err = -EOPNOTSUPP;
 		break;
@@ -3798,7 +3777,6 @@
 	case SIOCGIWRETRY:
 		err = orinoco_ioctl_getretry(dev, &wrq->u.retry);
 		break;
-#endif /* WIRELESS_EXT > 10 */
 
 	case SIOCSIWSPY:
 		err = orinoco_ioctl_setspy(dev, &wrq->u.data);
Index: working-2.6/drivers/net/wireless/orinoco.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.h
+++ working-2.6/drivers/net/wireless/orinoco.h
@@ -14,32 +14,9 @@
 #include <linux/version.h>
 #include "hermes.h"
 
-/* Workqueue / task queue backwards compatibility stuff */
-
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,41)
-#include <linux/workqueue.h>
-#else
-#include <linux/tqueue.h>
-#define work_struct tq_struct
-#define INIT_WORK INIT_TQUEUE
-#define schedule_work schedule_task
-#endif
-
-/* Interrupt handler backwards compatibility stuff */
-#ifndef IRQ_NONE
-
-#define IRQ_NONE
-#define IRQ_HANDLED
-typedef void irqreturn_t;
-
-#endif
-
 /* To enable debug messages */
 //#define ORINOCO_DEBUG		3
 
-#if (! defined (WIRELESS_EXT)) || (WIRELESS_EXT < 10)
-#error "orinoco driver requires Wireless extensions v10 or later."
-#endif /* (! defined (WIRELESS_EXT)) || (WIRELESS_EXT < 10) */
 #define WIRELESS_SPY		// enable iwspy support
 
 #define ORINOCO_MAX_KEY_SIZE	14
Index: working-2.6/drivers/net/wireless/hermes.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.c
+++ working-2.6/drivers/net/wireless/hermes.c
@@ -54,9 +54,7 @@
 
 MODULE_DESCRIPTION("Low-level driver helper for Lucent Hermes chipset and Prism II HFA384x wireless MAC controller");
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("Dual MPL/GPL");
-#endif
 
 /* These are maximum timeouts. Most often, card wil react much faster */
 #define CMD_BUSY_TIMEOUT (100) /* In iterations of ~1us */
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c
@@ -207,9 +207,7 @@
 static char version[] __initdata = "orinoco_tmd.c 0.01 (Joerg Dorchain <joerg@dorchain.net>)";
 MODULE_AUTHOR("Joerg Dorchain <joerg@dorchain.net>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using the TMD7160 PCI bridge");
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("Dual MPL/GPL");
-#endif
 
 static int __init orinoco_tmd_init(void)
 {
Index: working-2.6/drivers/net/wireless/orinoco_cs.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_cs.c
+++ working-2.6/drivers/net/wireless/orinoco_cs.c
@@ -47,9 +47,7 @@
 
 MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for PCMCIA Lucent Orinoco, Prism II based and similar wireless cards");
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("Dual MPL/GPL");
-#endif
 
 /* Module parameters */
 
@@ -144,15 +142,6 @@
 /* PCMCIA stuff     						    */
 /********************************************************************/
 
-/* In 2.5 (as of 2.5.69 at least) there is a cs_error exported which
- * does this, but it's not in 2.4 so we do our own for now. */
-static void
-orinoco_cs_error(client_handle_t handle, int func, int ret)
-{
-	error_info_t err = { func, ret };
-	pcmcia_report_error(handle, &err);
-}
-
 /*
  * This creates an "instance" of the driver, allocating local data
  * structures for one device.  The device is registered with Card
@@ -216,7 +205,7 @@
 
 	ret = pcmcia_register_client(&link->handle, &client_reg);
 	if (ret != CS_SUCCESS) {
-		orinoco_cs_error(link->handle, RegisterClient, ret);
+		cs_error(link->handle, RegisterClient, ret);
 		orinoco_cs_detach(link);
 		return NULL;
 	}
@@ -495,7 +484,7 @@
 	return;
 
  cs_failed:
-	orinoco_cs_error(link->handle, last_fn, last_ret);
+	cs_error(link->handle, last_fn, last_ret);
 
  failed:
 	orinoco_cs_release(link);
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c
+++ working-2.6/drivers/net/wireless/orinoco_plx.c
@@ -329,9 +329,7 @@
 static char version[] __initdata = "orinoco_plx.c 0.13e (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
 MODULE_AUTHOR("Daniel Barlow <dan@telent.net>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using the PLX9052 PCI bridge");
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("Dual MPL/GPL");
-#endif
 
 static int __init orinoco_plx_init(void)
 {


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
