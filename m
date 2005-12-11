Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVLKXyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVLKXyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVLKXyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 18:54:55 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:58037 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750910AbVLKXyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 18:54:55 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [spi-devel-general] Re: [PATCH 2.6-git] SPI core refresh
Date: Sun, 11 Dec 2005 15:54:52 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <200512111217.33009.david-b@pacbell.net> <439CA488.3050302@ru.mvista.com>
In-Reply-To: <439CA488.3050302@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111554.53143.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Synchronous transfers can easily use stack allocation for
> >the descriptions, yes.
> >
> >Not that they need to ... the ads7846 driver allocates its
> >spi_message and spi_transfer objects on the heap both for
> >synchronous operations (temperature and voltage sensing) and
> >for asynch ones (touchscreen tracking from timer and irq).
>  
> So are you talking about only kzalloc vs kmalloc?

Certainly not.  But I was re-emphasizing that zero-init rule,
in a different part of my reply.


> I was trying to compare the approaches in a somehow deeper way.
> That said, I meant that not exposing any structures you don't have to 
> expose was usually a right way to do things.
> We don't expose SPI message and you do.

What information there _isn't_ in the "have to expose" category?

Yours certainly has some ... clocks as per-message not per-device,
and your message utilities still doing kmalloc() and memcpy() in
places where it's not clearly necessary.  Plus the error-prone
notion that completion callbacks could be optional, and a few
other things I've pointed out previously.

The choice of an array of spi_transfer rather than a custom
singly linked list (not even list_head)?  I just picked the
one with the smallest mandatory overhead (including adding the
least number of fault cases to test and recover from).  Lots of
APIs made the same choice; it works just fine here.  Heck, it's
one of the few things here that resembles the I2C API!


> On the other hand, our approach is flexible in means of message 
> allocation. I. e. a small memory allocation library can be implemented 
> transparently to device drivers that handles message allocation. It's 
> very easy (and lightweight :)) since the message structure is always of 
> a same length... Agree?

No, as I explained before.  But I'd not mind having optional layers
like that, so long as they were in fact optional.  Yours is not; plus
it's heavy-weight (embedding mallocation of dma bounce buffers and
copying into/out of them, even when it's not necessary) and it's not
refcounted.


> >That said ... I know some people _do_ like krefcounted APIs that
> >do that kind of stuff.  Strongly.  Greg's been silent here other
> >than pointing out that your request alloc was too fat to inline.
> >Mine is trivially inlined, but not refcounted.  Likely there's a
> >happy middle ground, maybe
> >
> >  mesg = spi_message_alloc(struct spi_device *, unsigned ntrans);
> >  mesg = spi_message_get(mesg);
> >  spi_message_put();
> >  
> >
> Well, it's pretty much what we do in the latest one...

No, you have no get/put krefcounting, and (to repeat an earlier
comment) you also require "ntrans" separate allocations.  So
"what 'we' do in the latest one" is substantially different.


> Though we use one-by-one chaining and not specifying the number of 
> messages in chain.
> I'm not sure which approach is better, really.

In terms of potential faults that requires (debugging) driver code to
recover from, having a single allocation is a clear win.  Have you
ever noticed now many patches go into Linux to handle cases where
driver fault cleanup got confused, and oopsed in one of the less
common (but still observed in the Real World) scenarios?


> Maybe an API like 
> struct spi_mjsg *spi_message_alloc(struct spi_device *, unsigned ntrans);
> spi_add_transfer(struct spi_msg *, ...);
> ...

I thought about such an "add" call, but there'd need to be three of them
(to add a TX buffer, an RX buffer, or both TX and RX buffers) and it really
doesn't seem even conceptually hard to expect folk to write

	msg->transfer[0].tx_buf = ...;
	msg->transfer[0].length = ...;

	msg->transfer[1].rx_buf = ...;
	msg->transfer[1].length = ...;

	msg->transfer[2].tx_buf = ...;
	msg->transfer[2].rx_buf = ...;
	msg->transfer[2].length = ...;

And in fact, having that stuff explicit seems preferable to me; no point
in "convenience" wrappers for something already that simple.

The only potentially useful thing about an spi_transfer_add_{rx,tx,txrx}()
set of inlines would be that it might make the protocol tweaking options
stand out more.  Say, like the "drop chipselect for 20 usec after this
and before the next one", or other customization.  Me, I'd rather highlight
such options with intelligent use of whitespace and comments.


> is better than what we've got now (see patch sent 12/05; I plan to post 
> the update tomorrow).
> I would just like to say that defining such an API looks better thing to 
> me than dealing with SPI message structure explicitly.

You've heard where and why I disagree.  But I'd probably not turn down a
patch that adds optional krefcounting support for spi_message, returning
a message with the transfer[] array ready to be filled out.

- Dave

