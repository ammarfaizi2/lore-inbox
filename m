Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWHCKOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWHCKOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 06:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWHCKOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 06:14:23 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:47060 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932457AbWHCKOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 06:14:22 -0400
Message-ID: <44D1CC7D.4010600@vmware.com>
Date: Thu, 03 Aug 2006 03:14:21 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: A proposal - binary 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to propose an interface for linking a GPL kernel, 
specifically,
Linux, against binary blobs.  Stop.  Before you condemn this as evil, 
let me
explain in precise detail what a binary blob is.

First, there are two kinds of binary blobs.  There are the evil, malignant
kind, that use manipulative and despicable techniques to subvert the GPL by
copying code into Linux and, the most evil kind, which uses a GPL 
wrapper to
export GPL-only symbols to the binary blob.  This is unconditionally 
wrong.  I
do not support this kind of use.  These evil blobs are used to lock 
people into
a particular type of protocol or proprietary hardware interface.  In my
personal opinion, they should be unconditionally banned, or at least 
phased out
rapidly from any GPL kernel.  I have been frustrated by this in the 
past, where
binary filesystem modules would not allow me access to AFS when 
upgrading to a
new kernel version.  I do not wish that on anyone.

But there is also another kind of binary blob.  These are not the evil, 
nasty
subversion type blobs, but a benign kind that actually exists in binary 
form
not to close off choice, but to open it.  This is exactly the kind of 
binary
interface we are proposing with the VMI design.  Only with a specific
ABI can you guarantee future compatibility.  This is exactly the same thing
I believe some hardware vendors are trying to do.  When you have a fairly
complex interaction with the hardware layer, you have a lot of code which
suddenly becomes hardware dependent.  When that hardware is actually 
changing
rapidly, you have a serious problem keeping released drivers for that 
hardware
in sync.  Software release cycles are becoming much longer, and 
delivering new
capabilities to average consumers outside of that software release cycle 
is a
very difficult problem to solve.  As a result, vendors build some smarts 
into
the hardware - a firmware piece that can be loaded and actually run on the
processor.  This firmware allows the same driver to be used for many 
different
versions of the hardware, allowing a single software release to support
multiple versions of yet to be released hardware.  It is only natural to 
run
this privileged software inside a privileged context - the kernel.

In our case, this "hardware" is actually the virtual machine.  We must deal
with changes to the underlying hardware, as they are happening rapidly, 
and we
must support future compatibility for customers that decide to start 
using a
virtual machine in 2006 - it is a virtual machine, after all, and it should
continue running in 2016, no matter what the underlying hardware at that 
time
will look like.  In this sense, we have an even larger future compatibility
problem to solve than most hardware vendors.  So it is critical to get an
interface that works now.

The essence of our interface is a separation between the kernel, and the
hypervisor compatibility layer, which we call the VMI.  This layer is
completely separate from the kernel, and absolutely cannot be compiled 
into the
kernel.  Why?  Because doing so negates all of the benefits this layer is
supposed to provide.  It is separate from the kernel not to lock anyone 
into a
proprietary design or prevent anyone from distributing a working 
kernel.  It is
separate to allow the hypervisor backend to change radically without
introducing any changes whatsoever into the kernel.  This is absolutely
required for future compatibility - with new versions of each hypervisor 
being
released regularly, and new competing hypervisors emerging, it is a 
necessity.
This allows the hypervisor development process, as well as the Linux kernel
development process, to continue unimpeded in the face of rapid change 
on each
side.  Having an open binary interface encourages growth and competition in
this area, rather than locking anyone into a proprietary design.  It 
also does
not stop anyone from distributing a working, fully source compiled 
kernel in
any circumstance I can imagine.  If you don't have the firmware for a 
VE-10TB
network card compiled into your kernel, but also don't have a VE-10TB 
network
card, you haven't been deprived of anything, and have very little to 
complain
about.  Provided, of course, that when you do buy a VE-10TB network 
card, it
happily provides the required firmware to you at boot time.

On the other hand, the GPL is not friendly to this type of linking against
binary fragments that come from firmware.  But they really, absolutely, 
must be
separate from the kernel.  There is no argument against this from a feature
point of view.  But there is also no reason that they must be 
binary-only.  The
interface between the two components surely must be binary - just as the
interface between userspace and the kernel, or between the apps and 
glibc must
be binary.  This means the code from one layer is visible to the other 
purely
as a binary "blob".  But not an evil one.  And by NO circumstances, is it
required to be a CLOSED source binary blob.  In fact, why can't it be 
open?  In
the event of a firmware bug, in fact, it is very desirable to have this
software be open so that it can be fixed - and reflashed onto the card, 
where
the firmware belongs.

Let me illustrate the major differences between an "evil" binary blob, a
typical vendor designed hardware support layer, a well designed, open 
binary
interface, and a traditional ROM or extensible firmware layer.  I think you
will see why our VMI layer is quite similar to a traditional ROM, and very
dissimilar to an evil GPL-circumvention device.  I can't truly speak for 
the
video card vendors who have large binary modules in the kernel, but I would
imagine I'm not far off in my guesses, and they can correct me if I am 
wrong.

                                         EVIL    VENDOR     VMI      ROM
Module runs at kernel privilege level:     YES       YES     YES    
MAYBE (*)
Module is copied into the kernel:          YES     MAYBE      NO       NO
Module is part of kernel address space:    YES       YES      NO(+)    ??
Module has hooks back into kernel:         YES     MAYBE      NO       NO
Kernel has hooks into module:              YES       YES     YES      YES
Module has proprietary 3rd party code:   MAYBE     MAYBE(?)   NO      YES
Module has significant software IP:        YES     MAYBE(?)   NO    
MAYBE (?)
Module is open source:                      NO     MAYBE   MAYBE       NO

(*) In the ROM case, sometimes these are run in V8086 mode, not at full
hardware privilege level, and whether the < 1MB physical ROM region is 
part of
the "kernel" address space proper, or just happens to appear in kernel 
address
space as a result of linear mapping of physical space is a debatable 
matter.

(+) The VMI layer is not technically part of the kernel address space.  
It is
never mapped by the kernel, and merely exists magically hanging out in 
virtual
address space above the top of the fixmap, in hypervisor address space.  
But it
can be read and called into by the kernel, so whether this constitutes 
being
part of the same address space is a dicey matter of precise definition.  
I would
propose that only supervisor level pages that are allocated, mapped and
controlled by the kernel constitute the kernel address space, or 
alternately,
the kernel address space consists of the linear range of virtual address 
space
for which it can create supervisor-level mappings.

(?) There are only two reasonable objections I can see to open sourcing the
binary layer.  One is revealing IP by letting people see the code.  This is
really a selfish concern, not a justification for keeping the code 
binary only,
while still allowing it the privilege of running in the kernel address 
space.
The other objection I see is if that code has 3rd party pieces in it 
that are
unable to be licensed under an open software license.  This really is a 
hard
stopper for open sourcing the code, as the vendor doesn't actually own the
copyright, and thus can't redistribute that code under a different 
license.  We
don't have any such restrictions, as we wrote all our code ourselves, 
but many
ROMs and firmware layers do have such problems.  ROMs might also have 
some IP
in the form of trade secrets protecting power management or other 
features run
in SMM mode - but this is just a guess.  And IANAL - so take all this 
with a
grain of salt, it is purely my uninformed personal opinion.

This brings me to the essence of my proposal - why not allow binary 
"blobs" to
be linked inside Linux, in exactly the same way modules are linked?  If 
these
binary modules are actually open sourced, but separate from the kernel, is
there no reason they can't actually link against GPL symbols within Linux?
What if these modules exposed an ELF header which had exactly the same
information as a typical module?  In this case, kernel version is not 
relevant,
as these modules are truly kernel independent, but device/module version 
is.
The biggest issue is that the source and build environment to these 
modules is
not the standard environment -- in fact many of these binary modules 
might have
extremely bizarre build requirements.  We certainly do.  But still there
remains no reason that a well encapsulated build environment and open 
source
distribution of these modules cannot exist.  We are actively working on 
this for
our VMI layer.  Perhaps a good solution to this problem would be to 
provide a
link embedded in the binary which points to a URL where this environment 
can be
downloaded and built - or even fully buildable compressed source within the
binary itself for most friendly binaries with plenty of space to burn.
There may be other issues which I may not be aware of on our end, but that
has no bearing on finding out what the Linux and open source community 
wants.

I propose this as a solution because I would like to see binary (only) 
blobs go
away, and I would never again like to see hardware vendors design stupid 
code
which relies on firmware in the operating system to initialize a hardware
device (can I say WinModem?) which is not published and open code.  The 
point
of an interface like this is to open and standardize things in a way that
vendors can benefit from a hardware abstraction layer, and to make sure 
that
the GPL is not violated in the process of doing so.  I would very much 
like to
see Linux come up with a long term proposal that can accommodate open 
firmware
which actually runs in kernel mode, while at the same time assuring that 
this
code is authorized within the license boundaries afforded to it and 
available
for use by any operating system.

Thank you very much for your patience - I can get verbose, and I've already
gone too long.  This is still a very controversial issue, and I wanted to
clarify several points that merit attention before dooming myself to 
enduring
the yet to come flames.  Again, I must say IANAL, and I can't promise
that VMware or any other hardware vendor that wants to use a binary
interface will agree to everything I have proposed.  But I would like to
open the issue for discussion and get feedback from the open source 
community
on this issue, which I think will become more important in the future.

Zach
