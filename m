Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbUBYGSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 01:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbUBYGSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 01:18:10 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:2969 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262630AbUBYGSF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 01:18:05 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>, manfred@colorfullife.com
Date: Wed, 25 Feb 2004 17:17:45 +1100
Cc: saw@saw.sw.com.sg, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
Message-ID: <20040225061745.GA29654@cse.unsw.EDU.AU>
References: <403AF155.1080305@colorfullife.com> <20040223225659.4c58c880.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20040223225659.4c58c880.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the stack trace when transfering data to the Itanium box the eepro100 driver
seems to be producing the slab errors.
                                                                                                                                                             
To check this I swapped over to the Intel e100 driver and the slab errors have ceased.
                                                                                                                                                             
A quick look at eepro100.c shows that it takes a lock in
speedo_interrupt(..)
                                                                                                                                                             
Then the callgraph looks something like this.
                                                                                                                                                             
speedo_interrupt(..)
        |->speedo_rx(..)
            |->speedo_refill_rx_buffers(..)
                |->speedo_rx_alloc(..)
                   |->dev_alloc_skb(..)
                        |->alloc_skb(..)

Though I do not think the lock is held when alloc_skb(..) is called?

Andrey you would know more about what is going on in the eepro100 driver any
comments.

I have posted the latest logs at:
http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/

the file *-xffUL are the equivilent debug files.

Included here is also some disassembled code that may help

I found the back trace of the new slab error code limited debugging
since earlier we were able to see the trace from the network code
also.

Darren

On Mon, 23 Feb 2004, Andrew Morton wrote:

> Manfred Spraul <manfred@colorfullife.com> wrote:
> >
> >  From your logs:
> > 
> > >Feb 23 14:54:24 calypso kernel: Slab corruption: start=e00000017e84ea00, expend=e00000017e84f1ff, problemat=e00000017e84f020
> > >Feb 23 14:54:24 calypso kernel: Last user: [<a0000001003c9f30>](kfree_skbmem+0x30/0x80)
> > >Feb 23 14:54:24 calypso kernel: Data: ************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!
> **!
> > ***************************************
> > >Feb 23 14:54:28 calypso kernel: **************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************6A *************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!
> **!
> > ***************************************
> > >Feb 23 14:54:28 calypso kernel: ************************************************************A5 
> > >  
> > >
> > "6a" instead of 0x6b. One bit is wrong, this is often an indication of a 
> > hardware problem. Do you use ECC memory and is ECC enabled in the BIOS?
> 
> Actually, it's often caused by someone doing atomic_dec_and_test() against
> something which was already freed.  Or spin_lock().  One would need to work
> out what field is at that offset.  If it is an atomic_t or a spinlock_t,
> there you are.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
