Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVASAsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVASAsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVASArz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:47:55 -0500
Received: from palrel10.hp.com ([156.153.255.245]:28365 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261553AbVASAra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:47:30 -0500
Date: Tue, 18 Jan 2005 16:47:22 -0800
To: Rusty Russell <rusty@rustcorp.com.au>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: [BUG] MODULE_PARM conversions introduces bug in Wavelan driver
Message-ID: <20050119004722.GA26468@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Rusty,

	(If you are not the culprit, please forward to the guilty party).

	The patch the the Wavelan driver that I quote below introduces
a nice bug that can crash the kernel. Maybe you want to think about
fixing it, or maybe I should revert the patch...

	As a side note...
	I personally don't like the "string pointer" module parameter,
previously 'p' and currently 'charp', because I can easily lead to
this kind of bug, add extra bloat in the module for various checks and
doesn't have a clean way to return the error to user space.
	I personally introduced the "double char array" module
parameter, 'c', to fix that. I even sent you the patch to add 'c'
support in your new module loader (see set_obsolete()). Would it be
possible to carry this feature with the new module_param_array ?
	Thanks in advance...

	Jean

-------------------------------------------------------------

diff -Nru a/drivers/net/wireless/wavelan.c b/drivers/net/wireless/wavelan.c
--- a/drivers/net/wireless/wavelan.c	2005-01-11 20:03:09 -08:00
+++ b/drivers/net/wireless/wavelan.c	2005-01-11 20:03:09 -08:00
@@ -4344,7 +4344,8 @@
 		struct net_device *dev = alloc_etherdev(sizeof(net_local));
 		if (!dev)
 			break;
-		memcpy(dev->name, name[i], IFNAMSIZ);	/* Copy name */
+		if (name[i])
+			strcpy(dev->name, name[i]);	/* Copy name */
 		dev->base_addr = io[i];
 		dev->irq = irq[i];
 
diff -Nru a/drivers/net/wireless/wavelan.p.h b/drivers/net/wireless/wavelan.p.h
--- a/drivers/net/wireless/wavelan.p.h	2005-01-11 20:03:07 -08:00
+++ b/drivers/net/wireless/wavelan.p.h	2005-01-11 20:03:07 -08:00
@@ -703,10 +703,11 @@
 /* Parameters set by insmod */
 static int	io[4];
 static int	irq[4];
-static char	name[4][IFNAMSIZ];
-MODULE_PARM(io, "1-4i");
-MODULE_PARM(irq, "1-4i");
-MODULE_PARM(name, "1-4c" __MODULE_STRING(IFNAMSIZ));
+static char	*name[4];
+module_param_array(io, int, NULL, 0);
+module_param_array(irq, int, NULL, 0);
+module_param_array(name, charp, NULL, 0);
+
 MODULE_PARM_DESC(io, "WaveLAN I/O base address(es),required");
 MODULE_PARM_DESC(irq, "WaveLAN IRQ number(s)");
 MODULE_PARM_DESC(name, "WaveLAN interface neme(s)");
