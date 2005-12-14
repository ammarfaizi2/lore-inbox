Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVLNT7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVLNT7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVLNT7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:59:31 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:7039 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964921AbVLNT7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:59:30 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
Date: Wed, 14 Dec 2005 11:17:10 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512140922.43877.david-b@pacbell.net> <43A05B58.4030009@ru.mvista.com>
In-Reply-To: <43A05B58.4030009@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512141117.11244.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> static inline ssize_t spi_w8r8(struct spi_device *spi, u8 cmd)
> {
>         ssize_t                 status;
>         u8                      result;
> 
>         status = spi_write_then_read(spi, &cmd, 1, &result, 1);
> 
>         /* return negative errno or unsigned value */
>         return (status < 0) ? status : result;
> }
> 
> You're allocating u8 var on stack, then allocate a 1-byte-long buffer 
> and copy the data instead of letting the controller driver decide 
> whether this allocation/copy is necessary or not.

Yeah, like that matters in the face of the overhead to queue
the message, get to the head of the SPI transfer queue, go
through that queue, then finally wake up the task that was
synchronously blocking in write_then_read().  Oh, and since
that's inlined, GCC may be re-using existing state...

If folk want an "it looks simple" convenient/friendly API,
there is always a price to pay.  In this case, that cost is
dwarfed by the mere fact that they're using a synchronous
model to access shared resources (the SPI controller).


> >>Then he starts messing with allocate-or-use-preallocated stuff etc. etc.
> >>Why isn't he just kmalloc'ing/kfree'ing buffers each time these 
> >>functions are called 
> >
> >So that the typical case, with little SPI contention, doesn't
> >hit the heap?  That's sure what I thought ... though I can't speak
> >for what other people may think I thought.  You were the one that
> >wanted to optimize the atypical case to remove a blocking path!
>  
> I meant kmalloc'ing/kfree'ing buffers is spi_w8r8/spi_w8r16/etc.

As I said:  so the _typical_ case doesn't hit the heap.   There are
inherent overheads for such RPC-style calls.  But there's also no
point in gratuitously increasing them.

- Dave
