Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSLGXJj>; Sat, 7 Dec 2002 18:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSLGXJj>; Sat, 7 Dec 2002 18:09:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17416 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264875AbSLGXJi>;
	Sat, 7 Dec 2002 18:09:38 -0500
Message-ID: <3DF28151.40706@pobox.com>
Date: Sat, 07 Dec 2002 18:16:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Matt Rickard <mjr318@psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Oops with 3c59x module (3com 3c595 NIC)
References: <20021207164300.2a35f18d.mjr318@psu.edu> <3DF2738A.2447599@digeo.com>
In-Reply-To: <3DF2738A.2447599@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> That's a transmit underrun - data is not being fed into the NIC
> across the PCI bus fast enough.  Possibly something has gone
> wrong with the busmastering logic on the mainboard, or the NIC.
> 
> The driver will reset the transmitter when this happens, as per the
> manual.  There's not much else we can do.


pci-skeleton.c and several of Don's drivers actually do do something 
else on TxUnderrun, twiddle DMA burst settings:

         if ((intr_status & TxUnderrun)
                 && (np->tx_config & TxThresholdField) != 
TxThresholdField) {
                 long ioaddr = dev->base_addr;
                 np->tx_config += TxThresholdInc;
                 writel(np->tx_config, ioaddr + TxMode);
                 np->stats.tx_fifo_errors++;
         }

I wonder how feasible it is to do that on 3c59x hardware?

