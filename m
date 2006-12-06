Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937651AbWLFVNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937651AbWLFVNg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937653AbWLFVNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:13:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54495 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937652AbWLFVNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:13:35 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: "Lu, Yinghai" <yinghai.lu@amd.com>, "David Brownell" <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       "Peter Stuge" <stuge-linuxbios@cdy.org>,
       "Stefan Reinauer" <stepan@coresystems.de>, "Greg KH" <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linuxbios@linuxbios.org
Subject: Re: [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
References: <5986589C150B2F49A46483AC44C7BCA4907290@ssvlexmb2.amd.com>
	<200612062158.39250.ak@suse.de>
Date: Wed, 06 Dec 2006 14:12:44 -0700
In-Reply-To: <200612062158.39250.ak@suse.de> (Andi Kleen's message of "Wed, 6
	Dec 2006 21:58:39 +0100")
Message-ID: <m164co684z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wednesday 06 December 2006 21:43, Lu, Yinghai wrote:
>> -----Original Message-----
>> From: Andi Kleen [mailto:ak@suse.de] 
>> Sent: Wednesday, December 06, 2006 9:31 AM
>> 
>> >Also for usb console keep should be made default because the output
>> won't
>> >be duplicated.
>> 
>> Still need to tx_read to make console can take command?
>> 
>> Or transfer to generic usb_serial 
>
> I think the protocols are incompatible? 
>
>> or usb_debug that Greg just added 
>
> Ah I didn't notice that. If there is a usb_debug that works later
> then yes it would need to be disabled.
>
> However I see a certain advantage to keep using the early 
> usb console because it doesn't need any interrupts. So when the 
> kernel is very confused after an oops it might have a higher
> chance to still get the oops out.
>
> I haven't looked how the other usb_debug works -- if it's polled
> too then it wouldn't have much advantage.
>
> Ok one advantage of a non early usb_debug is that it will properly use pci 
> config space locking. The early implementation just ignores the port cf8 
> lock which might lead to corruption later. That's ok after
> an oops, but during normal output it can actually lead to
> data corruption if it interferes with somebody else's config write.
> Also on some systems cf8 is broken and doesn't work.
>
> Disadvantage of using the locks of course is that it can deadlock
> if an oops happen inside the critical region. So they might need
> to be added to bust_spinlocks()
>
> And it would be good if the late usb_debug still wouldn't rely
> on interrupts.
>
> But I agree it's probably better to transition to another usb_debug
> console and not do keep by default.

The only use of the early pci code is for finding the hardware.  Everything
else is through mmio.

The practical issue is that during the normal initialization of the ehci 
the reset of the hardware state is going to remove the delegation to the
ehci debug registers.

Greg's current thing uses the hardware but through the normal interrupt
driven usb methods.  I think it is worth using the ehci debug registers
if possible as that (except for reset) gives us independent control of
what is going on.

For understanding what needs to happen except for the initialization just
look at my dbgp_bulk_write routine.  That and the functions it call is
the only code in there that is executed.  It is just a hair more complicated
than other early debug port code because it has to deal with retransmits.
But I think it is still under 100 lines of code.


Eric
