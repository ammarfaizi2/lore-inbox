Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVLASbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVLASbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 13:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVLASbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 13:31:21 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:25464 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932396AbVLASbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 13:31:21 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] SPI core refresh
Date: Thu, 1 Dec 2005 10:31:11 -0800
User-Agent: KMail/1.7.1
Cc: Mark Underwood <basicmark@yahoo.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051130202930.67776.qmail@web36914.mail.mud.yahoo.com> <438EA389.7030704@ru.mvista.com>
In-Reply-To: <438EA389.7030704@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200512011031.12167.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 November 2005 11:17 pm, Vitaly Wool wrote:
> Mark Underwood wrote:
> 
> >>However, there also are some advantages of our core compared to David's I'd like to mention
> >>
> >>- it can be compiled as a module
> 
> >So can David's. You can use BIOS tables in which case you must compile the SPI core into the
> >kernel but you can also use spi_new_device which allows the SPI core to be built as a module (and
> >is how I am using it).
> 
> You limit the functionality, so it's not the case.

As noted in my comparison of last week (you're still ignoring that):

 - Mine lets board-specific device tables be declared in the
   relevant arch_setup() thing (board-*.c).  Both frameworks allow
   later board specific code to dynamically declare the devices,
   with binary (Dave's) or parsed-text (Dmitry's) descriptions. 

What Mark said was that in this case he used the "late" init.  You seem
to be saying he's not allowed to do that.  Which is nonsense; there are
distinct mechanisms for the good reason that "late" init doesn't work
so well without dynamic discovery ... which SPI itself doesn't support.
Hence the need for board-specific "this hardware exists" tables.


> If there's more than one SPI controller onboard, spi_write_then_read 
> will serialize the transfers ...

Which, as has been pointed out, would be a trivial thing to fix
if anyone were actually to have a problem.  Sure it'd incur the
cost of a kmalloc on at least some paths -- serializing in the
slab layer instead! -- but that's one price of using convenience
helpers not performance oriented calls.


>	 Moreover, if, say, two  
> kernel threads with different priorities are working with two SPI 
> controllers respectively *priority inversion* will happen.

That characteristic being inherited from semaphores (or were they
updated with RT_PREEMPT?), and being in common with most I/O queues
in the system.  Not something to blame on any line of code I wrote.

Oh, and I noticed a priority inversion in your API which shows
up with one SPI controller managing two devices.  Whoops!  I'd
far rather have such inversions be implementation artifacts; it's
easy to patch an implementation, hard to change all API users.


> >>- it's more adapted for use in real-time environments
> >>- it's not so lightweight, but it leaves less effort for the bus driver developer.
> >
> >But also less flexibility. A core layer shouldn't _force_ a policy
> 
> Nope, it's just a default policy.

One that every driver pays the price for.  Allocating a task even
when it doesn't need it; every call going through a midlayer that
wants to take over queue management policy; and more.  (Unless you
made a big un-remarked change in a patch you called "refresh"...)


> >on a bus driver. I am currently developing an adapter driver for David's system and I wouldn't say
> >that the core is making me do things I think the core should do. Please could you provide examples
> >of where you think Davids SPI core requires 'effort'.
> 
> Main are
> - the need to call 'complete' in controller driver

So you think it's better to have consistent semantics be optional?

That seems to be the notion behind your spi_transfer() call, which
can't decide whether it's going to be synchronous or asynchronous.
Instead, it decided to be error prone and be both.  :)


> - the need to implement policy in controller driver

The "policy" in question is something that sometimes needs to
be board-specific -- priority to THAT device, synch with THIS
external signal, etc -- which is why I see it as a drawback
that you insist the core implement one policy.

One policy is painfully easy to implement:  FIFO, processing
the requests in the order they arrive.  Easy to implement,
even with spinlocks, in a dozen lines of code.  If anyone
has a hard time writing that, they shouldn't be trying to
write a device driver.

- Dave

