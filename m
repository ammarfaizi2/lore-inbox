Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267112AbSKSGgb>; Tue, 19 Nov 2002 01:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267114AbSKSGgb>; Tue, 19 Nov 2002 01:36:31 -0500
Received: from dp.samba.org ([66.70.73.150]:13495 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267112AbSKSGga>;
	Tue, 19 Nov 2002 01:36:30 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: module-init-tools-0.6/modprobe.c - support subdirectories 
In-reply-to: Your message of "Mon, 18 Nov 2002 07:32:47 -0800."
             <20021118073247.A10109@adam.yggdrasil.com> 
Date: Tue, 19 Nov 2002 17:42:38 +1100
Message-Id: <20021119064333.C5C1C2C2C4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021118073247.A10109@adam.yggdrasil.com> you write:
> 	The following untested patch adds subdirectory support to
> module-init-tools-0.6/modprobe.c.  I really need this for tools that I
> use for building initial ramdisks to do things like select all SCSI
> and IDE drivers without having to release a new version of the ramdisk
> maker every time a new SCSI or IDE driver is added.  The patch is a net
> addition of four lines to modprobe.c.

Hmm, I'm not entirely convinced.  Moving back into subdirs introduces
a namespace which isn't really there.  However, as you say, it's
trivial.

> 	I am sorry I was not able to test this change, but it would be
> a lot of work for me to bring up a system without module device ID
> table support.  I know your ChangeLog says that support is coming.  I
> wonder if it would break your module utilities to leave the old macros
> device ID macros in place and let people run the existing depmod.

I'm actually tempted to push your patch for the moment, since it might
be a week before device ID support is tested and polished enough to go
in, with everything else I am doing.  OTOH, the current method exposes
kernel internals to external userspace programs, which is why I do it
differently.

> 	I also worry about about the latency of reading the
> kernel symbols for all modules every time modprobe is called.  If I
> want to have all of the modules installed, that's at least 1143
> modules on x86, and this might be the standard installation of a Linux
> distribution.  Here again, the existing depmod program could be used.

Yes, it's a fairly obvious optimization: I'd be very interesting in
timing measurements.  Another method is to use
/var/cache/modprobe/`uname-r`.dep and use it if available and more
recent than any module (removes the requirement for depmod).

> 	Finally, I am skeptical of the benefits being worth the cost
> of putting an ELF relocator and symbol table parser in the kernel.

>From the (just posted) FAQ:

Q: Doesn't putting linking code into the kernel just add bloat?
A: The total linking code is about 200 generic lines, 100
   x86-specific lines.  The ia64 linking code is about 500 lines (it's
   the most complex).  Richard Henderson has a great suggestion for
   simplifying it furthur, which I'm implementing now.  "insmod" is
   now a single portable system call, meaning insmod can be written in
   about 20 lines of code.

   The previous code had to implement the two module loading
   system calls, the module querying system call, and the /proc/ksyms
   output, required a little more code than the current x86 linker.

Q: Why not just fix the old code?
A: Because having something so intimate with the kernel in userspace
   greatly restricts what changes the kernel can make.  Moving into
   the kernel means I have implemented modversions, typesafe
   extensible module parameters and kallsyms without altering
   userspace in any way.  Future extensions won't have to worry about
   the version of modutils problem.

Hope that clarifies,
Rusty,
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
