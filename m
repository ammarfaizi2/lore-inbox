Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbUAKMQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUAKMQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:16:46 -0500
Received: from sa152.neoplus.adsl.tpnet.pl ([80.50.113.152]:57012 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S265863AbUAKMQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:16:19 -0500
Message-ID: <40013E83.6070108@attika.ath.cx>
Date: Sun, 11 Jan 2004 13:16:03 +0100
From: Piotr Kaczuba <pepe@attika.ath.cx>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: tulip driver: errors instead TX packets?
References: <20040110144831.GA16080@orbiter.attika.ath.cx> <400035F5.3040300@pobox.com> <4000607D.1020102@attika.ath.cx> <20040110222038.A4817@mail.kroptech.com>
In-Reply-To: <20040110222038.A4817@mail.kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> On Sat, Jan 10, 2004 at 09:28:45PM +0100, Piotr Kaczuba wrote:
> 
>>Jeff Garzik wrote:
>>
>>>Piotr Kaczuba wrote:
>>>
>>>
>>>>I've got a ADMtek Centaur (3cSOHO100B-TX) running with the tulip 
>>>>driver  on 2.6.1. I wonder if anyone has noticed that ifconfig shows 
>>>>the  packets sent in the errors field instead of the TX packets field. 
>>>>At  least, this is what I assume because it shows 0 TX packets and 
>>>>11756  errors.
>>>
>>>This is an old error, but since packets show up, nobody bothers with the 
>>>incorrect statistics...
>>
>>It seems that the error lies in the following piece of code from 
>>drivers/net/tulip/interrupt.c, function tulip_interrupt. I've inserted 
>>an additional printk after the "if (status & 0x8000)" and it looks like 
>>normal operation of the nic is considered as an major error by the 
>>driver because my printk appeared in dmesg output right after bringing 
>>the interface up. I assume that the else branch is never executed 
>>although I didn't test what happens if an transmit error really happens. 
>>I wonder if a fix for this problem consists of just changing the value 
>>of the AND mask but I have no idea what the right value would be.
>>
>>
>>   if (status & 0x8000) {
> 
> 
> According to my PNIC docs (don't have true Tulip docs handy), this bit
> is the logical OR of all the Tx error bits, so it appears a true tx
> error has ocurred.
> 
> 
>>           /* There was an major error, log it. */
>>#ifndef final_version
>>           if (tulip_debug > 1)
>>              printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
>>                        dev->name, status);
>>#endif
> 
> 
> Enabling this printk and setting tulip_debug appropriately would tell us
> what tx error you're experiencing.
> 
> 
>>           tp->stats.tx_errors++;
>>           if (status & 0x4104) tp->stats.tx_aborted_errors++;
>>           if (status & 0x0C00) tp->stats.tx_carrier_errors++;
>>           if (status & 0x0200) tp->stats.tx_window_errors++;
>>           if (status & 0x0002) tp->stats.tx_fifo_errors++;
>>           if ((status & 0x0080) && tp->full_duplex == 0)
>>                   tp->stats.tx_heartbeat_errors++;
> 
> 
> And this code bumps error counters based on the specific error that
> ocurred.  It all seems perfectly sane to me. The actual problem lies
> elsewhere, I think.

Here is the output of dmesg after setting TULIP_DEBUG to 4 and starting 
pppd (eth0 is used by PPPoE). I agree that the code looks okay but 
somehow every packet sent is considered to be an error although I don't 
experience any problems in everday network traffic.

Linux Tulip driver version 1.1.13 (May 11, 2002)
eth0: ADMtek Comet rev 49 at 0xe1fc5000, 00:04:75:B1:E0:77, IRQ 10.
eth0: tulip_up(), irq==10.
eth0: Done tulip_up(), CSR0 fff98000, CSR5 fc664010 CSR6 ff972113.
eth0: Added filter for 33:33:00:00:00:01  f99baaba bit 31.
eth0: Added filter for 33:33:ff:b1:e0:77  35362b05 bit 44.
eth0: Added filter for 33:33:00:00:00:01  f99baaba bit 31.
eth0: Added filter for 33:33:ff:b1:e0:77  35362b05 bit 44.
eth0: Added filter for 33:33:00:00:00:01  f99baaba bit 31.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Comet link status 0000 partner capability 0000.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: no IPv6 routers present
eth0: Added filter for 33:33:ff:b1:e0:77  35362b05 bit 44.
eth0: Added filter for 33:33:00:00:00:01  f99baaba bit 31.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 2a0b8c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 2a0b8c80.
eth0: Transmit error, Tx status 2a0b8c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 2a0b8c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Comet link status 0000 partner capability 0000.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Comet link status 0000 partner capability 0000.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Comet link status 0000 partner capability 0000.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Comet link status 0000 partner capability 0000.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.
eth0: Transmit error, Tx status 1a078c80.

(output truncated)


Piotr Kaczuba


