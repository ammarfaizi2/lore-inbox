Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292900AbSCDUs3>; Mon, 4 Mar 2002 15:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292903AbSCDUsU>; Mon, 4 Mar 2002 15:48:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:12451 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292900AbSCDUsG>; Mon, 4 Mar 2002 15:48:06 -0500
Date: Mon, 4 Mar 2002 14:02:44 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
Message-ID: <20020304140244.A32644@vger.timpanogas.org>
In-Reply-To: <20020304104609.C31523@vger.timpanogas.org> <E16hxI9-00008m-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16hxI9-00008m-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 04, 2002 at 06:34:33PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 06:34:33PM +0000, Alan Cox wrote:
> > > Thats up to the network adapter. In fact the Linux drivers mostly do 
> > > keep preloaded with full sized buffers and only copy if the packet size
> > > is small (and copying 1 or 2 cache lines isnt going to hurt anyone)
> > 
> > There's an increase in latency.  For my application, I have no 
> 
> A very tiny one (especially if you keep a small buffer pool around too).
> To copy a packet is 2 cache line loads, which will dominate, some
> writes that you wont be able to measure, and a writeback you won't be
> able to instrument without a bus analyser.
> 
> For receive paths its up to the driver. The copy to smaller buffer is
> something the driver can choose to do. It and it alone decide what skbuff
> to throw at the kernel core
> 
> The bigger ring helping is interesting but itself begs a question. Do you
> ever dirty rather than merely reference skbuff data. In that case a bigger

Actually, I am plugging in my own data blocks into the skbuff->data
pointer from the drivers themselves.  When the driver allocates an 
skbuff, I use an alternate cache allocator to load the buffer 
into the skbuff, and I leave the two attached.  skb_release_data does
not release one of my data blocks.  These blocks are 4K aligned so 
I am not in the middle of a cache line (I think) in the data portion
when DMA is initiated.

> ring may simply be hiding the fact that the recycled skbuff has dirty
> cached data that has to be written back. Does the combination of hardware

This is probably happening.  I have an Arium here now, and am hooking
it up.  I can get memory bus traces and provide what's actually 
happening on the bus.  I do not ever DMA into a partial cache line.

Jeff

> you have do the right thing when it comes to the invalidating  - and do
> you ever DMA into a partial cache line ?

> 
> Alan
