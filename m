Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUALWK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266521AbUALWK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:10:29 -0500
Received: from dq78.neoplus.adsl.tpnet.pl ([80.54.239.78]:50057 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S266520AbUALWKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:10:17 -0500
Message-ID: <40031B3C.1090602@attika.ath.cx>
Date: Mon, 12 Jan 2004 23:10:04 +0100
From: Piotr Kaczuba <pepe@attika.ath.cx>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: tulip driver: errors instead TX packets?
References: <20040110144831.GA16080@orbiter.attika.ath.cx> <400035F5.3040300@pobox.com> <4000607D.1020102@attika.ath.cx> <20040110222038.A4817@mail.kroptech.com> <40013E83.6070108@attika.ath.cx> <20040111122736.A16869@mail.kroptech.com>
In-Reply-To: <20040111122736.A16869@mail.kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> On Sun, Jan 11, 2004 at 01:16:03PM +0100, Piotr Kaczuba wrote:
> 
>>Here is the output of dmesg after setting TULIP_DEBUG to 4 and starting 
>>pppd (eth0 is used by PPPoE). I agree that the code looks okay but 
> 
> 
> <snip>
> 
>>eth0: Transmit error, Tx status 1a078c80.
> 
> 
> That would be heartbeat failure, no carrier, and loss of carrier. It's
> interesting that you seem to be able to get valid packets on the wire
> because the latter two errors are usually quite fatal. I suspect either
> the Comet is just buggy and those error bits aren't to be trusted or
> there is something wrong with the PHY config. I don't have docs on the
> Comet PHY so there's not much I can do.
> 
> On whim, does the patch below change anything for you?
> 
> --Adam
> 
> 
> --- linux-2.6.1/drivers/net/tulip/tulip_core.c.orig	Sun Jan 11 12:06:34 2004
> +++ linux-2.6.1/drivers/net/tulip/tulip_core.c	Sun Jan 11 12:09:13 2004
> @@ -438,7 +438,7 @@
>  		/* Enable automatic Tx underrun recovery. */
>  		outl(inl(ioaddr + 0x88) | 1, ioaddr + 0x88);
>  		dev->if_port = tp->mii_cnt ? 11 : 0;
> -		tp->csr6 = 0x00040000;
> +		tp->csr6 = 0x000C0000;
>  	} else if (tp->chip_id == AX88140) {
>  		tp->csr6 = tp->mii_cnt ? 0x00040100 : 0x00000100;
>  	} else
> 

Unfortunately, not. The errors are still there, but the status code has 
changed. Below is an excerpt from kern.log after applying the patch.

> Jan 12 21:34:57 orbiter kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
> Jan 12 21:34:57 orbiter kernel: eth0: ADMtek Comet rev 49 at 0xe1fea000, 00:04:75:B1:E0:77, IRQ 10.
> Jan 12 21:35:09 orbiter kernel: eth0: tulip_up(), irq==10.
> Jan 12 21:35:09 orbiter kernel: eth0: Done tulip_up(), CSR0 fff98000, CSR5 fc664010 CSR6 ff9f2113.
> Jan 12 21:35:09 orbiter kernel: eth0: Added filter for 33:33:00:00:00:01  f99baaba bit 31.
> Jan 12 21:35:09 orbiter kernel: eth0: Added filter for 33:33:ff:b1:e0:77  35362b05 bit 44.
> Jan 12 21:35:09 orbiter kernel: eth0: Added filter for 33:33:00:00:00:01  f99baaba bit 31.
> Jan 12 21:35:09 orbiter kernel: eth0: Added filter for 33:33:ff:b1:e0:77  35362b05 bit 44.
> Jan 12 21:35:09 orbiter kernel: eth0: Added filter for 33:33:00:00:00:01  f99baaba bit 31.
> Jan 12 21:35:09 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:09 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:09 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:09 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:10 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:10 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:12 orbiter kernel: eth0: Comet link status 0000 partner capability 0000.
> Jan 12 21:35:12 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:12 orbiter kernel: eth0: Transmit error, Tx status 2a0b8c00.
> Jan 12 21:35:12 orbiter kernel: eth0: Transmit error, Tx status 2a0b8c00.
> Jan 12 21:35:12 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:13 orbiter kernel: eth0: Transmit error, Tx status 2a0b8c00.
> Jan 12 21:35:13 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:13 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:13 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:13 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:13 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:14 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:15 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:18 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:18 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:18 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:19 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:19 orbiter kernel: eth0: no IPv6 routers present
> Jan 12 21:35:20 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:20 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:21 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.
> Jan 12 21:35:32 orbiter kernel: eth0: Transmit error, Tx status 1a078c00.


Piotr Kaczuba




