Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWBVRMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWBVRMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWBVRMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:12:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751362AbWBVRMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:12:22 -0500
Date: Wed, 22 Feb 2006 09:08:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Zeuthen <david@fubar.dk>
cc: Kay Sievers <kay.sievers@suse.de>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <1140625103.21517.18.camel@daxter.boston.redhat.com>
Message-ID: <Pine.LNX.4.64.0602220848280.30245@g5.osdl.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> 
 <20060217231444.GM4422@stusta.de>  <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
  <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> 
 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> 
 <20060221225718.GA12480@vrfy.org>  <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
  <20060222152743.GA22281@vrfy.org>  <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org>
 <1140625103.21517.18.camel@daxter.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Feb 2006, David Zeuthen wrote:
> 
> Oh, you know, I don't think that's exactly how it works; HAL is pretty
> much at the mercy of what changes goes into the kernel. And, trust me,
> the changes we need to cope with from your so-called stable API are not
> so nice. 

Why do you "cope"?

Start complaining. If kernel changes screw up something, COMPLAIN. Loudly. 
They shouldn't.

> It also makes me release note that newer HAL releases require newer
> kernel and udev releases and that's alright.

It's _somewhat_ ok to have a well-defined one-way dependency. It's sad, 
but inevitable sometimes.

For example, the kernel does have a dependency on the compiler used to 
compile it. We try to avoid it as far as possible, but we've slowly been 
updating it, first from 1.40 to 2.75 to 2.9x and now to 3.1. But the 
kernel obviously shouldn't have any other run-time dependencies, because 
everything else is "on top of" the kernel.

What is NOT ok is to have a two-way dependency. If user-space HAL code 
depends on a new kernel, that's ok, although I suspect users would hope 
that it wouldn't be "kernel of the week", but more a "kernel of the last 
few months" thing. 

But if you have a TWO-WAY dependency, you're screwed. That means that you 
have to upgrade in lock-step, and that just IS NOT ACCEPTABLE. It's 
horrible for the user, but even more importantly, it's horrible for 
developers, because it means that you can't say "a bug happened" and do 
things like try to narrow it down with bisection or similar.

> For just one example of API breaking see
> 
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175998

So the kernel obviously shouldn't be just randomly changing the type 
numbers around. 

The _real_ bug seems to be that some people think it is OK to do this kind 
of user-visible changes, without even considering the downstream, or 
indeed, without even telling anybody else (like Andrew or me) about it.

> This breaks stuff for end users in a stable distribution. Not good.

Indeed. Not good at all.

And yes, some of it may be just HAL being a fragile mess, and some of it 
may end up being just user-level code that must be made to be more robust 
("I see a new type I don't understand" "Ok, assume a lowest common 
denominator, and stop whining about it"). 

But a lot of it is definitely some kernel people being _waayy_ too 
cavalier about userspace-visible changes.

> I think maintaining a stable syscall interface makes sense. Didn't you
> once say that only the syscall interface was supposed to be stable? Or
> was that Greg KH? I can't remember...

It's _not_ just system calls. It's any user-visible stuff. That very much 
includes /proc, /sys, and any "kernel pipes" aka netlink etc bytestreams.

What is not stable is the _internal_ data structures. We break external 
modules, and we sometimes break even in-kernel drivers etc with abandon, 
if that is what it takes to fix something or make it prettier.

So fcntl and ioctl numbers etc are _inviolate_, because they are part of 
the system interface. As is /proc and /sys. We don't change them just 
because it's "convenient" to change them in the kernel. 

If /sys needs an extended type to describe the command set of a device, we 
do NOT just change an existing attribute in /sys. 

> And I also think that breaking things like sysfs can be alright as long
> as you coordinate it with major users of it, e.g. udev and HAL.

The major users are USERS. Not developers. It doesn't help to "coordinate" 
things, when what gets screwed is the end-user who no longer can upgrade 
his kernel without worrying that something might break.

THIS IS WHY WE MUST MAKE THE KERNEL INTERFACES STABLE!

If users cannot upgrade their kernels safely, we will have two totally
unacceptable end results:

 - users won't upgrade. They don't dare to, because it's too painful, and 
   they don't understand HAL or hotplug, or whatever. 

   If a developer cannot see that this is unacceptable, then that 
   developer is a nincompoop and needs to be educated.

 - users upgrade, and generate bug reports and waste other developers time 
   because those other developers didn't realize that the HAL cabal had 
   decided that that breakage was "ok".

   Or worse, they don't generate the bug reports, and then six months from 
   now, when they test again, and it's still broken, they generate a 
   really bad one ("it doesn't work") when everybody - including the HAL 
   cabal - has forgotten what it was all about.

   Again, if a developer cannot see that this is unacceptable, then that 
   developer is not playing along, and needs to have his mental compass 
   re-oriented.

The fact is, regressions are about 10x more costly than fixing old bugs. 
They cause problems downstream that just waste everybodys time. It's a 
_hell_ of a lot more efficient to spend extra time to keep old interfaces 
stable than it is to cause regressions.

> One day perhaps sysfs will be "just right" and you can mark it as being
> stable. I just don't think we're there yet. And I see no reason
> whatsoever to paint things as black and white as you do.

Nothing will _ever_ be "just right", and this has been going on too long. 
We had better get our act together.

		Linus
