Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbUAJU2y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbUAJU2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:28:54 -0500
Received: from bn247.neoplus.adsl.tpnet.pl ([80.54.184.247]:20137 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S265434AbUAJU2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:28:52 -0500
Message-ID: <4000607D.1020102@attika.ath.cx>
Date: Sat, 10 Jan 2004 21:28:45 +0100
From: Piotr Kaczuba <pepe@attika.ath.cx>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tulip driver: errors instead TX packets?
References: <20040110144831.GA16080@orbiter.attika.ath.cx> <400035F5.3040300@pobox.com>
In-Reply-To: <400035F5.3040300@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Piotr Kaczuba wrote:
> 
>> I've got a ADMtek Centaur (3cSOHO100B-TX) running with the tulip 
>> driver  on 2.6.1. I wonder if anyone has noticed that ifconfig shows 
>> the  packets sent in the errors field instead of the TX packets field. 
>> At  least, this is what I assume because it shows 0 TX packets and 
>> 11756  errors.
> 
> This is an old error, but since packets show up, nobody bothers with the 
> incorrect statistics...

It seems that the error lies in the following piece of code from 
drivers/net/tulip/interrupt.c, function tulip_interrupt. I've inserted 
an additional printk after the "if (status & 0x8000)" and it looks like 
normal operation of the nic is considered as an major error by the 
driver because my printk appeared in dmesg output right after bringing 
the interface up. I assume that the else branch is never executed 
although I didn't test what happens if an transmit error really happens. 
I wonder if a fix for this problem consists of just changing the value 
of the AND mask but I have no idea what the right value would be.


   if (status & 0x8000) {
           /* There was an major error, log it. */
#ifndef final_version
           if (tulip_debug > 1)
              printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
                        dev->name, status);
#endif
           tp->stats.tx_errors++;
           if (status & 0x4104) tp->stats.tx_aborted_errors++;
           if (status & 0x0C00) tp->stats.tx_carrier_errors++;
           if (status & 0x0200) tp->stats.tx_window_errors++;
           if (status & 0x0002) tp->stats.tx_fifo_errors++;
           if ((status & 0x0080) && tp->full_duplex == 0)
                   tp->stats.tx_heartbeat_errors++;
   } else {
           tp->stats.tx_bytes +=
                   tp->tx_buffers[entry].skb->len;
           tp->stats.collisions += (status >> 3) & 15;
           tp->stats.tx_packets++;
   }


Piotr Kaczuba
