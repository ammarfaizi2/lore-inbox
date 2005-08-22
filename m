Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVHVXNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVHVXNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVHVXNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:13:41 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:22673 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932360AbVHVXNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:13:39 -0400
Message-ID: <20050822003325.33507.qmail@web51613.mail.yahoo.com>
X-RocketYMMF: ltuikov
Date: Sun, 21 Aug 2005 17:33:25 -0700 (PDT)
From: Luben Tuikov <luben_tuikov@adaptec.com>
Reply-To: luben_tuikov@adaptec.com
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
To: James Bottomley <James.Bottomley@SteelEye.com>, luben_tuikov@adaptec.com
Cc: Andrew Morton <akpm@osdl.org>, Jim Houston <jim.houston@ccur.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1124661830.5068.19.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Bottomley <James.Bottomley@SteelEye.com> wrote:
> On Sun, 2005-08-21 at 10:27 -0700, Luben Tuikov wrote:
> > Is this the only use _you_ could find for a *radix tree*? ;-)
> > Since of course sd.c uses it just as an enumeration, according to
> > you this must be the only use? :-)
> 
> And Dicto Simpliciter to you too.
> 
> > It was designed as a general purpose id to pointer translation
> > service, just as the comment in it says.
> 
> idr was specifically designed with unlocked pre-allocation in mind.  The
> change you're proposing wants to allow pre allocation from irq context.
> This really doesn't look like a good change because the whole point of
> pre allocation is to do it at a point in time when the system can sleep
> if it has to.

No preallocation is done from IRQ context.  Do not spread FUD.
It seems to me that you're unaware how IDR works and unaware how
the driver works.

See the original patch submission -- I do explain why it is needed,
and show exactly how it breaks.  You may also want to look at the idr.c
code.  There is no reason not to promote the lock to an irq spinlock,
again, since it protects only data manipulation, as it should.

In fact, when you start writing code and actually face problems,
and start looking for the right tools, then you'll see it.  Right now
this is a useless argument and you should drop it.

> What I don't understand is why you need to pre allocate this tag from
> irq context.  Best practise is to allocate when you have user context
> but make use of it in IRQ context.

No preallocation is done in IRQ context.  See above.

Furthermore, you should know that a slab cache *settles* very
quickly, especially for IO.  You should've learned this when
I posted my results of SCSI Core using the slab cache for commands
5 years ago, before that code was in SCSI Core.

James, is this the most important thing for SCSI Core for the maintaner of
SCSI Core to discuss?

IDR's use?  A general library utility's use in a driver?
Is this what the SCSI Core maintainer will use to reject a driver's
acceptance?

When so many things have been said in the last week on this mailing
list, being in direct importance to SCSI Core: error handling
being one of them, another is HCIL usage, and other vendor
provided labels for LUs, native target support, etc.

> > > However, there is an infrastructure in the block layer called the
> > > generic tag infrastructure which was designed precisely for this purpose
> > > and which is designed to operate in IRQ context.
> > 
> > James, I'm sure you're well aware that,
> >    - a request_queue is LU-bound,
> >    - a SCSI _transport_ (*ANY*) can _only_ address domain devices, but
> >      _not_ LUs.  LUs are *not* seen on the domain.
> > 
> > See the different associations?  Then why are you posting such emails?
> 
> So you're planning to do some type of tag command queueing outside of
> the block framework?  Could you just look at what it would take to do it
> within the existing framework first?  I seem to have wasted quite a bit
> of time recently pulling spurious queueing code out of Adaptec drivers.

No one is implementing tag command queueing.  Why are you spreading FUD
into making people think that if you use tags, you must be doing
tagged command _queueing_?

Here:
    Tags do _not_ imply TCQ.
    TCQ does imply Tags.

> Remember that the code is adaptable ... we have non-block devices that
> use block queues for instance.

Completely irrelevant for a transport driver.  Stop throwing red-herring.

Instead let's start discussing matters SCSI, which have been due for
the last 5 years, which I had hoped you'd _lead_ or at least
*listen and take paches* into SCSI Core, you know, like other
maintainers do.  Those are:
    - 8 byte LUNs, opaque to SCSI Core,
    - native target (domain device) support,
    - native LU discovery,
    - HCIL becoming just one of _many_ possible labels for an LU, whereby
      vendors provide them.

*This* is what is important and relevant to SCSI Core.  Not to mention,
error handling, etc.

Now let's drop this and start discussing things which have been
a pain for the last 5 years, since the first SAM LLDD (iSCSI)
was introduced to SCSI Core (at least not publicly).

Let's take SCSI Core into the 21st century, shall we?  Please?

   Luben

