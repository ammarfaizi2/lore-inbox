Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbVIJEM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbVIJEM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 00:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbVIJEM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 00:12:28 -0400
Received: from web51612.mail.yahoo.com ([68.142.224.85]:31131 "HELO
	web51612.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030488AbVIJEM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 00:12:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JIawYVAkJwp1FxBNM4CFGhSqq66HduwtoGpnYm0RmQExQkn4w2k6ycZTE5+KF9/oA79PMxhgiS18DczFnlDNrgC3gE/FDGijS/H8FMYG5qLqWmF4WXacg3prZNU0hijXgN3Mx45NxD64izPKyF16tO9MHvQLpkmmyb5gX2xa7HI=  ;
Message-ID: <20050910041218.29183.qmail@web51612.mail.yahoo.com>
Date: Fri, 9 Sep 2005 21:12:18 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1126308949.4799.54.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Fri, 2005-09-09 at 15:42 -0400, Luben Tuikov wrote:
> > +static const struct scsi_host_template sas_host_template = {
> > +       .module = THIS_MODULE,
> > +       /* .name is initialized */
> > +       .name = "",
> > +       .queuecommand = sas_queuecommand,
> > +       .eh_strategy_handler = sas_scsi_recover_host,
> > +       .eh_timed_out = sas_scsi_timed_out,
> > +       .slave_alloc = sas_slave_alloc,
> > +       .slave_configure = sas_slave_configure,
> > +       .slave_destroy = sas_slave_destroy,
> > +       .change_queue_depth = sas_change_queue_depth,
> > +       .change_queue_type = sas_change_queue_type,
> > +       .bios_param = sas_bios_param,
> > +       /* .can_queue is initialized */
> > +       .this_id = -1,
> > +       .sg_tablesize = SG_ALL,
> > +       .max_sectors = SCSI_DEFAULT_MAX_SECTORS,
> > +       /* .cmd_per_lun is initilized to .can_queue */
> > +       .use_clustering = ENABLE_CLUSTERING,
> > +};
> 
> You can't do something like this and be generic.  You intercept all of
> the slave_* calls and try to provide the template.

I don't intecept them.

A SAS LLDD doesn't implement them.  It implements Execute Command SCSI RPC,
and a bunch of TMFs.

> This has produced a class that might wrapper nicely around the aic94xx
> but it won't attach nicely to any other SAS driver.

How can you say something so generic?
     "it won't attach nicely to any other SAS driver"?
Do you know _all_ other SAS drivers?  You don't even know _one_!
(other than aic94xx)

See how some fields are initialized?  The comments on top of them even
say that.  Why cannot sg_tablesize, max_sectors and use_clustering
be also initialized similarly? (when the SAS LLDD registers with the
SAS Layer)

What you're talking about can be accommodated, easily.

No self respecting SAS chip would not do 64 bit DMA, or have an sg tablesize
or any other limitation.

Naturally, aic94xx has _no limitations_. :-)  But hey, our hardware just
kicks a*s!

> You can't decide what table size and alignment your drivers are going to
> have because not all will conform to them.  I already know that SATA (ex
> ATA) vendors are getting into the SAS market ... they have particularly

Yes, you heard this about ATA, and you think it applies to SAS?

FUD!  This is handled by the transport/hardware/sequencer.

Look at Execute Command SCSI RPC in the code -- this is _the_ whole
point!

> weird SG allocation and alignment requirements for some of their stuff.
> 
> To be an actual transport class, aside from actually using the transport
> class infrastructure, the code actually has to provide common routines
> that a class of drivers can use.

OMG? You must be completely on crack!

Did you not read the Announcement emails, 0, 1, 2?

How about SAS Domain Discover?  How about Expander configuration?
How about Port management?  How about SAS device configuration?

(Oh, I know, the solution you're paid to push into the kernel
doesn't need those since it does all SAS in the firmware.)

Look, I repeat again: A SAS LLDD need to generate at least 2 types
of event to use this infrastructure.

You are _completely_ on crack and I am aware that the whole world
is reading this email.

Did you not look at the code and see how little a SAS LLDD needs to
implement in order to use this infrastructure?

> There's already an embryonic SAS class working its way through the SCSI
> list.  Could you look at enhancing that instead of trying to produce a
> competing class?

Hmm, lets see:
I posted today, a _complete_ solution, 1000 years ahead of this
"embryonic SAS class" you speak of.

This complete solution was written of the actual SCSI specs, and it
supports _everything_, including Domain discovery, user space configuration
of expanders, _and_ a user space program was written and included, and
any kind of device there is for SAS domains.

While this "embryonic SAS class" doesn't implement _any_ of that.
It is vastly incomplete, and _most of all_ it doesn't adhere to the spec,
because, again, the firmware of the controller you're writing this
against, hides all SAS from the driver.

So why would I go to an _inferior_ "solution", which doesn't follow
any spec, SAM or SPC or SAS while there is a complete SAS solution written
which completely adheres to the specs? (which absolves this other solution,
which would've never implemented Domain discovery, again because all SAS is
hidden in the firmware)

Furthermore, why do you want to use a downgrade solution?

The answer is simple:
   After "emd", Dell (Hi Matt!) learned quickly that if they want something
in SCSI Core, they have to hire the people who _make_the_decisions_ what
goes in and stays out of SCSI Core, to write that something, irrespectively
of whether those people have the know-how to do that and irrespectively of
how crappy the code is.  As long as it will go into the kernel.  (Naturally
everyone wants to sell their product and $1e9 is a lot of money.)

So as long as *you are on their payroll*, what are you discussing here
with me?  *You have an agenda*!  You are not seeking the right
solution, you're seeking the agenda that you're being paid to follow.

Furthermore, LSI's SAS controller, which Dell is using, does
*not* export _anything_ SAS to SCSI Core.  This is the whole point
of MPT (their licensed technology) -- to hide the transport
in the firmware and export only pure SCSI LUs to the kernel, so that
_one_ driver can work with multiple transports which the firmware
is implementing and hiding from the driver (at least this was the inital
thought).  For this reason  their driver should've been included into
the kernel from the get go, but you created some work for yourself.

So this "embryonic SAS class" you speak of, is being written
to accomodate _that_particular_ product, again by the people
who make the decisions of what goes into or out of the kernel,
being on the payroll of those companies.  Whether that solution
follows anything SAS, nobody cares -- you're on their payroll
and they have to sell the product.

OTOH, aic94xx is a true SAS LLDD -- it exposes SAS to a managment
layer, giving more freedom to the user to do discovery and configuration
of the domain.  Thus, the possibilities are endless.

So, now let me ask you this question:
   Since I posted today a _complete_ solution to SAS support in the
kernel, why don't you scrap that "embryonic SAS class" and make
that "SAS" LLDD generate those 2 events and make use of that
infrastructure which is clearly superior.

Or do you have to complete the contract you signed and got paid
to do?

SCSI Core has become one crazy circus, where very little to none SCSI
competence and expertise is present.  It is vendor driven, rather
than technology driven.

I long for the days of the previous maintainer.  Had it not been
for him and Andi, we may have never had scsi commands from a slab,
scsi_done queue, done_q softirq processing, scsi timer hook, etc.
Of course back then Splentec wasn't your payrol company, but there
was some common sense present in linux-scsi.

      Luben

