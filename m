Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSLGXjT>; Sat, 7 Dec 2002 18:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSLGXjT>; Sat, 7 Dec 2002 18:39:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:480 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264983AbSLGXjM>;
	Sat, 7 Dec 2002 18:39:12 -0500
Message-ID: <3DF28863.D7642140@digeo.com>
Date: Sat, 07 Dec 2002 15:46:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Matt Rickard <mjr318@psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Oops with 3c59x module (3com 3c595 NIC)
References: <20021207164300.2a35f18d.mjr318@psu.edu> <3DF2738A.2447599@digeo.com> <3DF28151.40706@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 23:46:44.0470 (UTC) FILETIME=[E6150160:01C29E4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Andrew Morton wrote:
> > That's a transmit underrun - data is not being fed into the NIC
> > across the PCI bus fast enough.  Possibly something has gone
> > wrong with the busmastering logic on the mainboard, or the NIC.
> >
> > The driver will reset the transmitter when this happens, as per the
> > manual.  There's not much else we can do.
> 
> pci-skeleton.c and several of Don's drivers actually do do something
> else on TxUnderrun, twiddle DMA burst settings:
> 
>          if ((intr_status & TxUnderrun)
>                  && (np->tx_config & TxThresholdField) !=
> TxThresholdField) {
>                  long ioaddr = dev->base_addr;
>                  np->tx_config += TxThresholdInc;
>                  writel(np->tx_config, ioaddr + TxMode);
>                  np->stats.tx_fifo_errors++;
>          }
> 
> I wonder how feasible it is to do that on 3c59x hardware?

It is quite feasible.  But it seems that current versions of the
driver disable thresholding anyway.  We had some problems...

Uncommenting this line:

//  issue_and_wait(dev, SetTxStart|0x07ff);

might be interesting.
