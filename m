Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVLKURh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVLKURh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 15:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVLKURh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 15:17:37 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:14220 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750861AbVLKURh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 15:17:37 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [spi-devel-general] Re: [PATCH 2.6-git] SPI core refresh
Date: Sun, 11 Dec 2005 12:17:32 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <439C1D5E.1020407@ru.mvista.com> <439C5BE7.3030503@ru.mvista.com>
In-Reply-To: <439C5BE7.3030503@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111217.33009.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The benefit you're talking about is that you don't have to use 
> > heavyweight memory allocation. But... the transfer is basically async 
> > so spi->master->transfer will need to copy your message structure to 
> > its own-allocated structure so some memory copying will occur as this 

Incorrect, as you note below.


> > might be an async transfer (and therefore the stack-allocated message 
> > may be freed at some point when it's yet used!)
> > So your model implies concealed double message allocation/copying, 
> > doesn't it?
> > And if I'm wrong, can you please explain me this?
> 
> Oh, now looks like I understood what is meant. If a function uses 
> stack-allocated messages, it should ensure that it will not exit until 
> the message is processed (shouldn't it be documented somewhere?).

It is documented, but I'll make sure it comes up in a few more of the
places this confusion might arise.  It's a fairly basic rule for
C programming:  don't use pointers after they become invalid by
means of freeing back to the heap, or invalidating a stack frame.


> But  
> this solves the problem only partially since this technique fits only 
> the synchronous transfers.

Synchronous transfers can easily use stack allocation for
the descriptions, yes.

Not that they need to ... the ads7846 driver allocates its
spi_message and spi_transfer objects on the heap both for
synchronous operations (temperature and voltage sensing) and
for asynch ones (touchscreen tracking from timer and irq).


> Functions targeting async transfers will anyway have to kmalloc the 
> memory for message structure which makes your approach not really more 
> lightweight then ours. 

If you measure the number of error/fault cases when you ask how
lightweight an API is, it's clearly lighter weight to allow for
example one kzalloc -(with spi_message and its N spi_transfer
descriptors, plus possibly other driver state) rather than to
require many of them.  Just one fault path to write -- and debug.

My usual rule of thumb is that 1/3 of code (by lines) must handle
fault cases.   So APIs requiring more fault handling require more
driver code ... not lightweight!  That was a help, when fitting
into a tight size budget.  (As appropriate to what's more or less
a shift register API, needing to run quickly in uCLinux and such.) 

Plus, letting the driver do the kzalloc means there's no new API.
No-new-API is another way to promote lighter weight systems.  ;)


That said ... I know some people _do_ like krefcounted APIs that
do that kind of stuff.  Strongly.  Greg's been silent here other
than pointing out that your request alloc was too fat to inline.
Mine is trivially inlined, but not refcounted.  Likely there's a
happy middle ground, maybe

  mesg = spi_message_alloc(struct spi_device *, unsigned ntrans);
  mesg = spi_message_get(mesg);
  spi_message_put();

Or whatever.  Just add a kref to spi_message, and patch against
the current mm set (to the core and both drivers, but not
necessarily the spi_bitbang stuff).

- Dave
