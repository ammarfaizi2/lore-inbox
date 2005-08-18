Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVHRFeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVHRFeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVHRFeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:34:31 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:10395 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750735AbVHRFeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:34:31 -0400
Message-ID: <43041DDC.8050000@colorfullife.com>
Date: Thu, 18 Aug 2005 07:34:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ACPI Standby and nvidia ethernet driver causes network errors
 and drops
Content-Type: multipart/mixed;
 boundary="------------040603080705040808050108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040603080705040808050108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Avuton,


>I have not been able to duplicate this without going into standby,
>thus this bug may have existed before 2.6.12, as I just started using
>ACPI standby.
>
>  
>
Could you try the attached patch? Lots of error are often caused by half 
duplex/full duplex mismatches, and such a bug was just fixed.

--
    Manfred

--------------040603080705040808050108
Content-Type: text/plain;
 name="patch-forcedeth-042-forcelinkinit"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-forcedeth-042-forcelinkinit"

--- 2.6/drivers/net/forcedeth.c	2005-08-14 11:17:03.000000000 +0200
+++ build-2.6/drivers/net/forcedeth.c	2005-08-14 11:16:53.000000000 +0200
@@ -93,6 +93,8 @@
  *      0.40: 19 Jul 2005: Add support for mac address change.
  *      0.41: 30 Jul 2005: Write back original MAC in nv_close instead
  *			   of nv_remove
+ *      0.42: 06 Aug 2005: Fix lack of link speed initialization
+ *			   in the second (and later) nv_open call
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -104,7 +106,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.41"
+#define FORCEDETH_VERSION		"0.42"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -2178,6 +2180,9 @@
 		writel(NVREG_MIISTAT_MASK, base + NvRegMIIStatus);
 		dprintk(KERN_INFO "startup: got 0x%08x.\n", miistat);
 	}
+	/* set linkspeed to invalid value, thus force nv_update_linkspeed
+	 * to init hw */
+	np->linkspeed = 0;
 	ret = nv_update_linkspeed(dev);
 	nv_start_rx(dev);
 	nv_start_tx(dev);

--------------040603080705040808050108--
