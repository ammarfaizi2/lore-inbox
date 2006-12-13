Return-Path: <linux-kernel-owner+w=401wt.eu-S1751199AbWLMVtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWLMVtA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWLMVtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:49:00 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:21700 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbWLMVs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:48:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LMn8SJW+xdpnuqbdPm/04u1MqScFiTtJ7Ng2SqtS/wUQeHVLE8Mmbg2wuxM3fJQhsrXlI+zv7ecIk1apTln/F18a0e0HCSdH7KhCpLBMLCeMSxOYTa7kzZPQBDmTO2DDcMQND+CnzwAtOTaYPc6wybko/wLrBtXX6LvcE8PckI8=
Message-ID: <f2b55d220612131348q705cd2aey9f9a0cde21a5b316@mail.gmail.com>
Date: Wed, 13 Dec 2006 13:48:58 -0800
From: "Michael K. Edwards" <medwards.linux@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061213210219.GA9410@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
	 <20061213210219.GA9410@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Greg KH <gregkh@suse.de> wrote:
> On Wed, Dec 13, 2006 at 12:38:05PM -0800, Michael K. Edwards wrote:
> > Seriously, though, please please pretty please do not allow a facility
> > for "going through a simple interface to get accesses to irqs and
> > memory regions" into the mainline kernel, with or without toy ISA
> > examples.
>
> Why?  X does it today :)

Er, I rest my case?  Anyway, the history around X11 is completely
different from the present situation, and there were good arguments at
the time for structuring the problem so that the X server was
relatively kernel-neutral even if it was banging directly on a
framebuffer, and later on 2-D acceleration hardware.  As graphics
chips have become more sophisticated, pure-userspace X11 has become
less tenable.

> > Embedded systems integrators have enough trouble with chip vendors who
> > think that exposing the device registers to userspace constitutes a
> > "driver".
>
> Yes, and because of this, they create binary only drivers today.  Lots
> of them.  All over the place.  Doing crazy stupid crap in kernelspace.

It does not get less crazy and stupid because we open a big hole from
kernelspace to userspace and let them pretend that they have a GPL
"driver" when all of the chip init logic is peeked and poked from the
same closed code in userspace.  Most low-level drivers (the kind that
involve IRQs and registers local to the CPU; USB is different) cannot
be done right from userspace and we shouldn't encourage people to try.

> Then there are people who do irq stuff in userspace but get it wrong.
> I've seen that happen many times in lots of different research papers
> and presentations.

Their problems need not become our problems.

> This interface does it correctly, and it allows those people who for
> some reason feel they do want to keep their logic in non-gpl code, to do
> it.

People who want to keep their logic in non-GPL code do so by providing
binary-only drivers.  That's a sane compromise in certain sectors, and
occasionally results in the eventual opening of the driver (when the
illusion of competitive advantage in closed-ness wears off) in
integrable shape.  A customer with some leverage and technical skill
can negotiate for access to the source code so that he can fix the
bugs that are biting him, rebuild with a toolchain that isn't from the
Dark Ages, and so forth: a real-life demonstration to the vendor that
letting outsiders work on the code will sell more chips.  But if you
actively encourage a brain-damaged userspace driver strategy, that
opportunity is lost.

> It also allows code that needs floating point to not be in the kernel
> and in one instance using this interface actually sped up the device
> because of the lack of the need to go between kernel and userspace a
> bunch of times.

What instance is that?  Are you sure it wasn't a case of things being
done in the driver that should have been done in a library all along?

> > The correct description is more like "porting shim for MMU-less RTOS
> > tasks"; and if the BSP vendors of the world can make a nickel
> > supplying them, more power to them.  Just not in mainline, please.
>
> Again, X does this today, and does does lots of other applications.
> This is a way to do it in a sane manner, to keep people who want to do
> floating point out of the kernel, and to make some embedded people much
> happier to use Linux, gets them from being so mad at Linux because we
> keep changing the internal apis, and makes me happier as they stop
> violating my copyright by creating closed drivers in the kernel.

Today's problem is that too many chip suppliers' in-house software
people have neither the skills nor the schedule room nor the influence
to insist that drivers be written competently and maintainably,
whether or not they are maintained in the public view.  So chipmakers
turn to the BSP vendors, whose business model is built around being
the only people who can do incremental development on the code they
write.

I'm not at all hostile to BSP vendors or to chipmakers who wind up in
this position; that's the way most of the industry works nowadays.
But I do want to know when I'm dealing with that situation, because
the appropriate strategies for getting a product to market are
different when it costs the chip vendor real cash money each time they
commission a recompile to meet some customer's expectations.
Pretending that driver code doesn't need reviewing every few months as
the kernel's locking strategies, timer handling, internal APIs, etc.
evolve makes things worse.

Just like the only thing worse that a salesperson who's on commission
is a salesperson who isn't on commission, the only thing worse than a
closed device driver in kernelspace is a closed device driver in
userspace.

Cheers,
- Michael
