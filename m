Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUAKDMq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 22:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265734AbUAKDMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 22:12:45 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:46318 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S265732AbUAKDMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 22:12:44 -0500
Date: Sat, 10 Jan 2004 22:20:38 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Piotr Kaczuba <pepe@attika.ath.cx>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: tulip driver: errors instead TX packets?
Message-ID: <20040110222038.A4817@mail.kroptech.com>
References: <20040110144831.GA16080@orbiter.attika.ath.cx> <400035F5.3040300@pobox.com> <4000607D.1020102@attika.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4000607D.1020102@attika.ath.cx>; from pepe@attika.ath.cx on Sat, Jan 10, 2004 at 09:28:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 09:28:45PM +0100, Piotr Kaczuba wrote:
> Jeff Garzik wrote:
> > Piotr Kaczuba wrote:
> > 
> >> I've got a ADMtek Centaur (3cSOHO100B-TX) running with the tulip 
> >> driver  on 2.6.1. I wonder if anyone has noticed that ifconfig shows 
> >> the  packets sent in the errors field instead of the TX packets field. 
> >> At  least, this is what I assume because it shows 0 TX packets and 
> >> 11756  errors.
> > 
> > This is an old error, but since packets show up, nobody bothers with the 
> > incorrect statistics...
> 
> It seems that the error lies in the following piece of code from 
> drivers/net/tulip/interrupt.c, function tulip_interrupt. I've inserted 
> an additional printk after the "if (status & 0x8000)" and it looks like 
> normal operation of the nic is considered as an major error by the 
> driver because my printk appeared in dmesg output right after bringing 
> the interface up. I assume that the else branch is never executed 
> although I didn't test what happens if an transmit error really happens. 
> I wonder if a fix for this problem consists of just changing the value 
> of the AND mask but I have no idea what the right value would be.
> 
> 
>    if (status & 0x8000) {

According to my PNIC docs (don't have true Tulip docs handy), this bit
is the logical OR of all the Tx error bits, so it appears a true tx
error has ocurred.

>            /* There was an major error, log it. */
> #ifndef final_version
>            if (tulip_debug > 1)
>               printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
>                         dev->name, status);
> #endif

Enabling this printk and setting tulip_debug appropriately would tell us
what tx error you're experiencing.

>            tp->stats.tx_errors++;
>            if (status & 0x4104) tp->stats.tx_aborted_errors++;
>            if (status & 0x0C00) tp->stats.tx_carrier_errors++;
>            if (status & 0x0200) tp->stats.tx_window_errors++;
>            if (status & 0x0002) tp->stats.tx_fifo_errors++;
>            if ((status & 0x0080) && tp->full_duplex == 0)
>                    tp->stats.tx_heartbeat_errors++;

And this code bumps error counters based on the specific error that
ocurred.  It all seems perfectly sane to me. The actual problem lies
elsewhere, I think.

--Adam

