Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbULMCTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbULMCTg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 21:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbULMCTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 21:19:34 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:27856 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261979AbULMCT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 21:19:28 -0500
Message-Id: <200412130219.iBD2JKF4001537@albireo.free.fr>
Date: Mon, 13 Dec 2004 03:19:20 +0100 (CET)
From: frahm@irsamc.ups-tlse.fr
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: Re: [Fwd: 2.6.10-rc3: tulip-driver: tulip_stop_rxtx() failed]
To: grundler@parisc-linux.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041212214803.GB22514@colo.lackof.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Grant, 

I am happy to help and to see my feedback was indeed useful. First I
would like to add to my first message, that I have observed a kind of
freezing for several seconds (5-10 seconds) of Firefox with one
particular web-page which heavily uses a flashplayer- and jave-plugin.
This does not appear in exactly the same form up to 2.6.10-rc2 but the
web-page under consideration is always kind of "heavy" and difficult to
load even with a high-speed connection. 


> I'm kicking myself now since I didn't include the CSR5 or CSR6 value from
> the last time it was read. Can you manually apply this small change
> and try it for me?
> 
> -			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed\n",
> -					tp->pdev->slot_name);
> +			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed"
> +					" (CSR5 0x%x CSR6 0x%x)\n",
> +					tp->pdev->slot_name,
> +					ioread32(ioaddr + CSR5),
> +					ioread32(ioaddr + CSR6));
> 
> Basically, I need the CSR5/CSR6 contents after the loop is exited.
> 

I have applied this modification to the file "drivers/net/tulip/tulip.h"
and recompiled the modules. 

I have activated and deactivated three times the device eth1 (by "dhcpcd
eth1" and "dhcpcd -k eth1") attached to the tulip driver and the result
in /var/log/messages is:

Dec 13 02:42:57 albireo kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Dec 13 02:42:57 albireo kernel: PCI: Found IRQ 10 for device 0000:00:0e.0
Dec 13 02:42:57 albireo kernel: PCI: Sharing IRQ 10 with 0000:00:0a.0
Dec 13 02:42:57 albireo kernel: tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
Dec 13 02:42:57 albireo kernel: eth1: ADMtek Comet rev 17 at 0001a400, 00:0C:F6:03:DA:D3, IRQ 10.
Dec 13 02:42:57 albireo dhcpcd.exe: interface eth1 has been configured with new IP=xx.xx.xx.xx
Dec 13 02:43:00 albireo kernel: 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
Dec 13 02:43:00 albireo kernel: eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
Dec 13 02:43:08 albireo dhcpcd[1340]: terminating on signal 1 
Dec 13 02:43:08 albireo kernel: 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)
Dec 13 02:43:08 albireo dhcpcd.exe: interface eth1 has been brought down
Dec 13 02:43:18 albireo dhcpcd.exe: interface eth1 has been configured with new IP=xx.xx.xx.xx
Dec 13 02:43:21 albireo kernel: 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
Dec 13 02:43:21 albireo kernel: eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
Dec 13 02:43:45 albireo dhcpcd[1357]: terminating on signal 1 
Dec 13 02:43:45 albireo kernel: 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)
Dec 13 02:43:45 albireo dhcpcd.exe: interface eth1 has been brought down
Dec 13 02:44:01 albireo dhcpcd.exe: interface eth1 has been configured with new IP=xx.xx.xx.xx
Dec 13 02:44:03 albireo kernel: 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
Dec 13 02:44:03 albireo kernel: eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
Dec 13 02:44:12 albireo dhcpcd[1374]: terminating on signal 1 
Dec 13 02:44:12 albireo kernel: 0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)
Dec 13 02:44:12 albireo dhcpcd.exe: interface eth1 has been brought down

The message with "tulip_stop_rxtx() failed" appears each time I activate
and deactivate the device. The values of CSR5 and CSR6 are reproduceable
but different for activation and deactivation:

  activation: (CSR5 0xfc664010 CSR6 0xff972113)
deactivation: (CSR5 0xfc06c012 CSR6 0xff970111)


I have also joined the output of /proc/pci for the network card in case
it may contain some useful information:

  Bus  0, device  14, function  0:
    Ethernet controller: Linksys NC100 Network Everywhere Fast Ethernet 10/100 (rev 17).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=255.Max Lat=255.
      I/O at 0xa400 [0xa4ff].
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe00003ff].


Greetings, Klaus.
