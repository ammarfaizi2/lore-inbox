Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUDYGsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUDYGsO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 02:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUDYGsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 02:48:14 -0400
Received: from ns.clanhk.org ([69.93.101.154]:46795 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S261706AbUDYGsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 02:48:08 -0400
Message-ID: <408B5F50.8090700@clanhk.org>
Date: Sun, 25 Apr 2004 01:48:48 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Lightfoot <jeffml@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] net/sk98lin: correct buggy VPD in ASUS MB
References: <20040406175012.64fe9d7c.jeffml@pobox.com>
In-Reply-To: <20040406175012.64fe9d7c.jeffml@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Lightfoot wrote:

The following patch to net/sk98lin/skvpd.c was put together by Marc
Bouget, mbouget at club-internet.fr.  He currently doesn't have time to
interface with linux-kernel so I offered to work that front.

This patch works around a corrupt EEPROM (VPD?) in the ASUS K8V Deluxe
SE motherboard ethernet chipset and allows the network driver to work
correctly.  We have written to ASUS and the sk98lin maintainers but have
not heard anything back.

Does this have a chance to be included in mainline or is there a
preferable way to fix these kind of issues?

  -- Jeff Lightfoot

------------------------------------------------------------------------

Just to confirm, I experienced this error.  Kernel log as follows:

sk98lin: Network Device Driver v6.22
(C)Copyright 1999-2004 Marvell(R).
eth0:
      PrefPort:A  RlmtMode:Check Link State
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: -- ERROR --
        Class:  internal Software error
        Nr:  0x19e
        Msg:  Vpd: Cannot read VPD keys
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled

And latter in the log I have:
try[18484]: segfault at 0000003000000008 rip 0000002a95e9dcae rsp 
0000007fbfffe230 error 4
try[24948]: segfault at 0000003000000008 rip 0000002a96033cae rsp 
0000007fbfffe250 error 4

>--- drivers/net/sk98lin/skvpd.c.orig	2004-04-05 17:32:59.000000000 -0700
>+++ drivers/net/sk98lin/skvpd.c	2004-04-05 17:33:26.000000000 -0700
>@@ -468,6 +468,16 @@
> 	
> 	pAC->vpd.vpd_size = vpd_size;
> 
>+	/* Asus K8V Se Deluxe bugfix. Correct VPD content */
>+	/* MBo April 2004 */
>+	if( ((unsigned char)pAC->vpd.vpd_buf[0x3f] == 0x38) &&
>+	    ((unsigned char)pAC->vpd.vpd_buf[0x40] == 0x3c) &&
>+	    ((unsigned char)pAC->vpd.vpd_buf[0x41] == 0x45) ) {
>+		printk("sk98lin : humm... Asus mainboard with buggy VPD ? correcting data.\n");
>+		(unsigned char)pAC->vpd.vpd_buf[0x40] = 0x38;
>+	}
>+
>+
> 	/* find the end tag of the RO area */
> 	if (!(r = vpd_find_para(pAC, VPD_RV, &rp))) {
> 		SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_ERR | SK_DBGCAT_FATAL,
>  
>
With the patch:

sk98lin: Network Device Driver v6.23
(C)Copyright 1999-2004 Marvell(R).
sk98lin : humm... Asus mainboard with buggy VPD ? correcting data.
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled

I'm also able poll more information back from the driver with the patch 
applied.  Like ifconfig will return number of packets, etc.

-ryan
