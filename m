Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVCPOV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVCPOV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVCPOV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:21:27 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:57277 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261249AbVCPOVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:21:22 -0500
Message-ID: <423840DE.2050509@drzeus.cx>
Date: Wed, 16 Mar 2005 15:21:18 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-6781-1110982967-0001-2"
To: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH][MMC] Power cycle (round 2)
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-6781-1110982967-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

I didn't get any response from you the last time I submitted this so I'm
going to nag you some more ;)

This patch is vital for one of my MMC cards. The only other way I've
found to get it working is by changing the OCR. And that would cause
problems on other controllers so it was not an option.

The patch is rather well tested with over 500 downloads and no reported
problems. Just to keep everyone happy the default is still 'no' for
Kconfig but I personally would think a 'yes' would be better.

Rgds
Pierre

--=_hades.drzeus.cx-6781-1110982967-0001-2
Content-Type: text/x-patch; name="mmc-powercycle.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-powercycle.patch"

Index: linux-wbsd/drivers/mmc/mmc.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc.c	(revision 72)
+++ linux-wbsd/drivers/mmc/mmc.c	(working copy)
@@ -666,13 +666,26 @@
 		host->ocr = mmc_select_voltage(host, ocr);
 
 		/*
-		 * Since we're changing the OCR value, we seem to
-		 * need to tell some cards to go back to the idle
-		 * state.  We wait 1ms to give cards time to
-		 * respond.
+		 * Some cards shut down when receiving an OCR of
+		 * zero. But since they send their mask before
+		 * shutting down we can still calculate a correct
+		 * voltage. To get them back to life we need to
+		 * cycle power.
+		 *
+		 * When changing OCR values we also need to put
+		 * the cards in idle state.
 		 */
 		if (host->ocr)
+		{
+
+#ifdef CONFIG_MMC_POWERCYCLE
+			mmc_power_off(host);
+			mmc_delay(100);
+			mmc_power_up(host);
+#endif /* CONFIG_MMC_POWERCYCLE */
+
 			mmc_idle_cards(host);
+		}
 	} else {
 		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 		host->ios.clock = host->f_min;
Index: linux-wbsd/drivers/mmc/Kconfig
===================================================================
--- linux-wbsd/drivers/mmc/Kconfig	(revision 95)
+++ linux-wbsd/drivers/mmc/Kconfig	(revision 96)
@@ -19,6 +19,18 @@
 	  This is an option for use by developers; most people should
 	  say N here.  This enables MMC core and driver debugging.
 
+config MMC_POWERCYCLE
+	bool "Reboot cards after scan (EXPERIMENTAL)"
+	depends on MMC != n && EXPERIMENTAL
+	default n
+	help
+	  Some cards to not follow the MMC spec. fully and shut down
+	  during init. Enable this option to reboot the card after
+	  the initial scan.
+	  
+	  Most people should say N here. If you happen to have a card
+	  that isn't detected then try enabling this option.
+
 config MMC_BLOCK
 	tristate "MMC block device driver"
 	depends on MMC

--=_hades.drzeus.cx-6781-1110982967-0001-2--
