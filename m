Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbRGCTU2>; Tue, 3 Jul 2001 15:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265965AbRGCTUS>; Tue, 3 Jul 2001 15:20:18 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50859 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265947AbRGCTUO>;
	Tue, 3 Jul 2001 15:20:14 -0400
Message-ID: <3B421AEA.8809D11C@mandrakesoft.com>
Date: Tue, 03 Jul 2001 15:20:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: ACPI fundamental locking problems
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDF2B@orsmsx35.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:
> 
> > From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> > events/evxface.c:610:acpi_acquire_global_lock ->
> > events/evmisc.c:337:acpi_ev_acquire_global_lock ->
> > include/platform/acgcc.h:52:ACPI_ACQUIRE_GLOBAL_LOCK
> >
> > My immediate objections are,
> > (a) acgcc.h is re-implementing spinlocks in a non-standard,
> > non-portable, and expensive way, and (b) this entire code path is
> > incredibly expensive.
> 
> Well, when I look at other Linux code, I assume that if it does something
> weird, it does it for a reason.
> 
> That is the case here. The Global Lock is for synchronizing accesses between
> the OS (that's us) and the firmware (SMI). Normal spinlocks are for intra-OS
> locking. Here, we're synchronizing access with the BIOS. It's different.

I realize what the purpose of the global lock is...

How is the asm code in ACPI_ACQUIRE_GLOBAL_LOCK specific to interaction
between OS and SMI?


> All this code has been working for as long as I can remember.

;-)  Under Windows?  Irrelevant.  Linux uses the hardware totally
differently from Windows.
Under Linux?  You cannot come close to saying CONFIG_ACPI is used by a
large number of users...  I don't think that claim can really be made
yet.


> You mention twice that it is "expensive". Keeping in mind the 80-20 rule, in
> what way do you find this code costly?

Compare your x86 asm code with the spinlock asm code.  More importantly,
why is a spinlock or other kernel intrinsic avoided in acgcc.h?  It's
much less portable this way.


> > But my fundamental objection is,
> > we are depending on vendors to get locking right in their
> > ACPI tables.
> > And assume by some magic or design that said locking works
> > with whatever
> > unrelated kernel locking is going on.
> 
> By design, it works. We get to slipstream Windows a little here in that
> vendors need to have a working Global Lock interface to pass WHQL.

(1) A working lock interface does not imply that -users- of the lock
interface are correct
(2) Nobody here puts stock in Windows tests, which I'm assuming the WHQL
is.


> > It is my initial belief that a smaller info query interface that can
> > parse useful ACPI would be more effective.  For times like
> > suspend/resume where we would want to execute control methods, well,
> > there's always the disasm -> write-small-driver cycle.  Who knows if
> > this is a realistics proposed solution.  But it really scares me to
> > depend on vendors to get locking right.
> 
> We're depending on vendors (aka the BIOS) for all the ACPI tables, as well
> as every other piece of a priori data we need to boot the OS.

The difference with ACPI is that vendors can write code that is executed
in the kernel's context (instead of what you can consider the BIOS's
context).  That is a whole new can of worms.


> Could I please ask that you at least show me a system where this is a
> problem before throwing out all the work we've done on ACPI because of this
> technical nit?

ACPI is so new I do not think this is necessary.  I am reading straight
from the spec, the same thing system implementors will read.


Anyway, for the main point, which you missed:

The global lock is not ONLY for SMM type stuff.  The vendor can use it
in control methods all over the place.  And the vendor can just as
easily screw up it up.  I do not trust a bios vendor to get runtime OS
locking correct...  and that is -totally- different from trusting the
BIOS to provide us with a tiny bit of information.

Look at the Linux boot sequence, which Randy Dunlap documented.  We
collect as much information as is reasonable from BIOS at startup, so we
won't have to talk to it again at runtime.

	Jeff


-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
