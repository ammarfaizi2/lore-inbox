Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWEQJ5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWEQJ5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 05:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWEQJ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 05:57:34 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:35737 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751085AbWEQJ5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 05:57:33 -0400
Date: Wed, 17 May 2006 05:54:39 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Paul Mackerras <paulus@samba.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, davem@davemloft.net, arnd@arndb.de,
       kenneth.w.chen@intel.com, sam@ravnborg.org, clameter@sgi.com,
       kiran@scalex86.org
Subject: [RFC PATCH 00/09] robust VM per_cpu variables
Message-ID: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-688922444-1147859679=:8408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-688922444-1147859679=:8408
Content-Type: TEXT/PLAIN; charset=US-ASCII

(I tried to include all arch maintianers and memory maintainers, if I
missed someone, please let me know).


OK, as promised, I've got a working VM percpu solution.

A little history: please read the thread http://lkml.org/lkml/2006/4/14/137

Preivously I noticed that the per_cpu variables were implemented with
a little hack that Rusty Russell wrote up.  I call it a hack because,
for modules an arbitrary number was used to hold all per_cpu variables
that would be used in the kernel or in modules.  If this number was too
big, you waste the memory that is allocated for it, and if it were
too small, you wont be able to load all the modules that are required.

My first attempt to fix this introduced another dereference, to allow
for modules to allocate their own memory.  This was quickly shot down,
and for good reason, because dereferences kill performance, and don't
play nice with large SMP systems that depend on per_cpu being fast.

But that first attempt had one benefit.  It had good responses on how
to actually fix the problem.  Without the first try, I would not have
tried this approach.

So what is this solution?

I now place the per_cpu variables into VM, such that the pages are
only allocated when needed. All the architecture needs to do is
supply a VM address range, size for each CPU to use (note this
implementation expects all the VM CPU areas to be together), and
three functions to allow for allocating page tables at bootup.

The bootup page table allocations are needed because the percpu
variables are used before the system initializes the memory. So
bootmem is needed to load the page tables.

But that's it!  No more hacks for architectures with lots of CPUS and
NUMA to implement their own percpu algorithms.  They just supply the
functions to allocate the variables, and the memory will be loaded
appropriately.  So all architectures with VM can use the generic
solution.  Does the main-line kernel support any architectures that
doesn't have a VM?

Another benefit is that this approach removes the one redirection that
was already used in the generic solution.  Since the virtual memory
of the architecture for the per_cpu is static, the calculation to
find the variable is done with constants.  So this is another win
for this solution.

So the three things that this patch gives us are:

1) Robust per_cpu.  No more guessing the size of the per_cpu variable
   sections.  Default VM is 1 Meg per cpu.  If you use more than that
   I guess you're SOL.

2) Generic solution for all architectures.  No more fancy hacks to
   get the per cpu offest.

3) Removes the inderection of the current per_cpu generic solution.

The set of patches that I have implement this for the i386 architecture
and lays out the ground work for others.  The i386 implementation I did
was mainly a hack.  Nick Piggin suggested that before I do too much
work, I should post my stuff and ask for comments.  That's what I'm doing
now.

This patch set works for my laptop (P4 HT) and I haven't tested
it with any other configuration.  The implementation that I did for
i386 was only to get it to work and is not flexible.  It needs much
better implementation, and I ask for help with that.

I basically concentrated to the core stuff.  Another nice thing about
this patch set is that it needs both CONFIG_HAS_VM_PERCPU and
__ARCH_HAS_VM_PERCPU to take advantage of the VM percpu implementation.
Without these set, it defaults to the old usage.  This way we
can slowly implement each architecture, in an incremental fashion.

OK, let'er rip. Flame me, yell at me, curse me, but please give me
feedback.

Thanks for your time.

-- Steve

PS. The attached module was used to test this patch on my laptop.


--8323328-688922444-1147859679=:8408
Content-Type: TEXT/x-csrc; charset=US-ASCII; name="per_cpu.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0605170554390.8408@gandalf.stny.rr.com>
Content-Description: 
Content-Disposition: attachment; filename="per_cpu.c"

I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KI2luY2x1ZGUgPGxpbnV4L3Bl
cmNwdS5oPg0KDQojZGVmaW5lIEJJR19TSVpFIDQyMDANCkRFRklORV9QRVJf
Q1BVKGludCAsIGJpZ2FycmF5W0JJR19TSVpFXSk7DQoNCnN0YXRpYyBpbnQg
X19pbml0IHBlcmNwdV9pbml0KHZvaWQpDQp7DQoJaW50IGksIHg7DQoJZm9y
IChpPTA7IGNwdV9wb3NzaWJsZShpKSA7IGkrKykNCgkJZm9yICh4PTA7IHgg
PCBCSUdfU0laRTsgeCsrKSB7DQoJCQlpZiAoISh4JTEwMCkpDQoJCQkJcHJp
bnRrKCJwcm9jZXNzaW5nICVkOiVkXG4iLCBpLCB4KTsNCgkJCXBlcl9jcHUo
YmlnYXJyYXlbeF0sIGkpID0gMTAwMDAgKyB4Ow0KCQl9DQoJcmV0dXJuIDA7
DQp9DQoNCnN0YXRpYyB2b2lkIF9fZXhpdCBwZXJjcHVfZXhpdCh2b2lkKQ0K
ew0KCWludCBpOw0KDQoJZm9yIChpPTE7IGkgPCBCSUdfU0laRTsgaSA8PD0g
MSkNCgkJcHJpbnRrKCJiaWdhcnJheVslZF0gPSAlZFxuIiwgaSwgcGVyX2Nw
dShiaWdhcnJheVtpXSwwKSk7DQp9DQoNCm1vZHVsZV9pbml0KHBlcmNwdV9p
bml0KTsNCm1vZHVsZV9leGl0KHBlcmNwdV9leGl0KTsNCg0KTU9EVUxFX0FV
VEhPUigiTXkgbmFtZSBoZXJlIik7DQpNT0RVTEVfREVTQ1JJUFRJT04oInBl
cmNwdSEiKTsNCk1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCg0K

--8323328-688922444-1147859679=:8408--
