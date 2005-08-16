Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVHPDKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVHPDKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 23:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVHPDKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 23:10:32 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:26814
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S965078AbVHPDKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 23:10:32 -0400
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base
	Driver (dcdbas) with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, Douglas_Warzecha@Dell.com,
       Matt_Domsch@Dell.com
In-Reply-To: <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com>
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com>
	 <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 22:10:28 -0500
Message-Id: <1124161828.10755.87.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 21:29 -0400, Kyle Moffett wrote:
> On Aug 15, 2005, at 18:58:56, Michael_E_Brown@Dell.com wrote:
> >> Why can't you just implement the system management actions in
> >> the kernel driver?  This is tantamount to a binary SMI hook to
> >> userspace.  What functionality does this provide on a dell
> >> system from an administrator's point of view?
> 
> >     The second alternative is not entirely feasible. We have over 60
> > SMI functions, and we would have to write a kernel-mode wrapper for
> > each and every one. I hope you agree that code that doesn't exist is
> > less buggy than code that is, and that code that is in userspace is a
> > whole lot less likely to cause a kernel crash than code that is in
> > the kernel.
> 
> I think the second alternative is actually feasible and preferable. The
> point of the kernel is to provide safe and secure access to two things:
>    1) Hardware through an abstraction layer
>    2) Software services (like IP stack) that are not feasible to do in
>       userspace.
> 
> A system that just provides a hunk of DMA RAM and the ability to  
> generate

We are only using the DMA allocation API, we are not actually doing DMA
to those addresses. We use the DMA API to easily restrict allocations to
4GB, as has been previously requested, instead of rolling our own
allocation functions.

> interrupts is definitely not 2, and does not really follow the ideal
> behind 1 either.  I gave the firmware example earlier.  There are  
> several
> devices that provide access to update firmware by reading and writing a
> firmware file directly in sysfs, then updating it on reboot if  
> necessary.

But... the firmware loading example is bogus. We already have the Dell
RBU driver for system BIOS updates, and it has been accepted into the
kernel. This driver (dcdbas) has absolutely nothing to do with firmware
loading. I'm confused as to why you have brought up this example again
after Doug just finished saying that dcdbas has nothing to do with
firmware updates.

So, in a sense, we are _ALREADY_ following your advice, having already
split out the firmware driver into it's own driver that sits under the
firmware/ class.

Sorry, but I think you mis-understand the whole point behind this
driver. This _is_ an abstraction.

For instance, if you have 16 journaling file systems in your kernel, it
would make a lot of sense to pull out the common journaling code and
create a separate journaling subsystem in the kernel, much like jbd. It
would then make sense to make people justify adding new journaling
methods to the kernel for a new file system, since there already exists
one journaling abstraction.

But, it only should go so far. Just because it makes sense to
standardize on one journaling layer in the kernel, doesn't mean that it
also makes sense to pull in all of mysql into the kernel.

In our case, we have a whole bunch of unrelated SMI calls to the BIOS
that have absolutely nothing in common except that they use the SMI
calling method. We have abstracted down to the lowest common denominator
of what we can put into the kernel to enable our whole managment stack.
Rather than re-invent the SMI stack for each of these functions, we have
provided an abstraction.

To take a concrete example, I suggested to Doug to mention fan status. I
get the feeling that you possibly think that this would be better
integrated into lmsensors, or something like that. That really isn't the
case, as lmsensors is really geared towards bit-banging lm81 (for
example) chips to get fan status. In our case, we have a standardized
BIOS interface to get this info, and that standardized method involves
SMI and not bit-banging interfaces. Once this driver is accepted into
the kernel, we can go and add support in the _userspace_ lmsensors libs
to poll fan and temp using this driver.

For example, we already have at least one buggy implementation of this
exact stack in the kernel as the i8k driver. The i8k driver was reverse-
engineered and works, but it does not follow the spec at all, and so is
subject to major breakage if the BIOS changes. With dcdbase + libsmbios,
we can write this _correctly_, and in such a way that it follows the
spec and will not break on BIOS updates.

What you are asking us to do is just not feasible on many levels. First,
just from the number of functions we would have to implement. We would
have to implement about 60 new sysfs files, with at least 120 separate
functions for read/write. Each function would have to take into account
the specific calling requirements of that specific function. Then, we
would have to implement all of the bugfixes and platform-specific
workarounds in the kernel for each of those functions for each Dell
platform. Each time another function is added to BIOS, we would have to
go out and patch everybody's kernel to support the new function.

Besides the fact that this is just not a good design, there just isn't
the manpower to maintain all of these in the kernel along with the
requisite testing for each update, not to mention the lag between when
we have to submit something and when it would show up in a vendor
kernel.

> >  We are trying to keep our kernel bloat down. We don't really think  
> > that
> > customers of IBM or HP really want their Red Hat kernels loaded  
> > down with
> > a bunch of Dell-only code.
> 
> That's what kconfig is for.  My G4 Powerbook doesn't have support for
> hardware found in my G4 desktop any more than an IBM box should be  
> forced
> to have support for Dell hardware, yet all platforms work fine from the
> same kernel tree.

Vendor kernels? Red Hat and SuSE (to pick two) ship, basically, one i386
kernel (granted, with UP/SMP/bigmem flavors), and we would like to make
it easy for them to enable this by default.

--
Michael

