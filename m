Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbULTOey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbULTOey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 09:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbULTOey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 09:34:54 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:65006 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S261306AbULTOes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 09:34:48 -0500
Message-ID: <41C6E2E1.8030801@mtg-marinetechnik.de>
Date: Mon, 20 Dec 2004 15:34:09 +0100
From: Richard Ems <richard.ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: Jon Mason <jdmason@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>	 <89245775041217090726eb2751@mail.gmail.com>	 <41C31421.7090102@mtg-marinetechnik.de>	 <8924577504121710054331bb54@mail.gmail.com> <8924577504121712527144a5cf@mail.gmail.com>
In-Reply-To: <8924577504121712527144a5cf@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer 
  full?"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon, hi list.

The following patch is what I'm trying now:
(I added the *np declaration to your patch, is this correct?)

Thanks, Richard

--- dl2k.c,orig-save-2004.12.20 2004-12-20 09:32:19.000000000 +0100
+++ dl2k.c      2004-12-20 15:24:39.051556188 +0100
@@ -562,9 +562,11 @@
  rio_tx_timeout (struct net_device *dev)
  {
         long ioaddr = dev->base_addr;
+       struct netdev_private *np = dev->priv;

-       printk (KERN_INFO "%s: Tx timed out (%4.4x), is buffer full?\n",
-               dev->name, readl (ioaddr + TxStatus));
+       printk (KERN_INFO "%s: Tx timed out (%4.4x) %d %d %x %x\n",
+               dev->name, readl (ioaddr + TxStatus), np->cur_tx, 
np->cur_rx,
+               readl (ioaddr + DMACtrl), readw(ioaddr + IntEnable));
         rio_free_tx(dev, 0);
         dev->if_port = 0;
         dev->trans_start = jiffies;
@@ -1005,8 +1007,9 @@
         /* PCI Error, a catastronphic error related to the bus interface
            occurs, set GlobalReset and HostReset to reset. */
         if (int_status & HostError) {
-               printk (KERN_ERR "%s: HostError! IntStatus %4.4x.\n",
-                       dev->name, int_status);
+               printk (KERN_ERR "%s: HostError! IntStatus %4.4x. %d %d 
%x %x\n",
+                       dev->name, int_status, np->cur_tx, np->cur_rx,
+                       readl (ioaddr + DMACtrl), readw(ioaddr + 
IntEnable));
                 writew (GlobalReset | HostReset, ioaddr + ASICCtrl + 2);
                 mdelay (500);
         }

-- 
Richard Ems
Tel: +49 40 65803 312
Fax: +49 40 65803 392
Richard.Ems@mtg-marinetechnik.de

MTG Marinetechnik GmbH - Wandsbeker Königstr. 62 - D 22041 Hamburg

GF Dipl.-Ing. Ullrich Keil
Handelsregister: Abt. B Nr. 11 500 - Amtsgericht Hamburg Abt. 66
USt.-IdNr.: DE 1186 70571

