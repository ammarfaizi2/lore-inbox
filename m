Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317311AbSFCIfE>; Mon, 3 Jun 2002 04:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317313AbSFCIfD>; Mon, 3 Jun 2002 04:35:03 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:4876 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S317311AbSFCIe7>; Mon, 3 Jun 2002 04:34:59 -0400
Message-ID: <3CFB2A38.60242CBA@opersys.com>
Date: Mon, 03 Jun 2002 04:35:04 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Adeos nanokernel for Linux kernel
Content-Type: multipart/mixed;
 boundary="------------0A8391E6E92C327136836BE9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0A8391E6E92C327136836BE9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


We have released the initial implementation of the Adeos nanokernel.
The following is a complete description of its background, its
implementation, its API, and its potential uses. Please also see the
press release (http://www.freesoftware.fsf.org/adeos/pr-2002-06-03.en.txt)
and the project's workspace (http://freesoftware.fsf.org/projects/adeos/).
The Adeos code is distributed under the GNU GPL.

The Adeos nanokernel is based on research and publications made in the
early '90s on the subject of nanokernels. Our basic method was to
reverse the approach described in most of the papers on the subject.
Instead of first building the nanokernel and then building the client
OSes, we started from a live and known-to-be-functional OS, Linux, and
inserted a nanokernel beneath it. Starting from Adeos, other client
OSes can now be put side-by-side with the Linux kernel.

To this end, Adeos enables multiple domains to exist simultaneously on
the same hardware. None of these domains see each other, but all of
them see Adeos. A domain is most probably a complete OS, but there is
no assumption being made regarding the sophistication of what's in
a domain.

To share the hardware among the different OSes, Adeos implements an
interrupt pipeline (ipipe). Every OS domain has an entry in the ipipe.
Each interrupt that comes in the ipipe is passed on to every domain
in the ipipe. Instead of disabling/enabling interrupts, each domain
in the pipeline only needs to stall/unstall his pipeline stage. If
an ipipe stage is stalled, then the interrupts do not progress in the
ipipe until that stage has been unstalled. Each stage of the ipipe
can, of course, decide to do a number of things with an interrupt.
Among other things, it can decide that it's the last recipient of the
interrupt. In that case, the ipipe does not propagate the interrupt
to the rest of the domains in the ipipe.

Regardless of the operations being done in the ipipe, the Adeos code
does __not__ play with the interrupt masks. The only case where the
hardware masks are altered is during the addition/removal of a domain
from the ipipe. This also means that no OS is allowed to use the real
hardware cli/sti. But this is OK, since the stall/unstall calls
achieve the same functionality.

Our approach is based on the following papers (links to these
papers are provided at the bottom of this message):
[1] D. Probert, J. Bruno, and M. Karzaorman. "Space: a new approach to
operating system abstraction." In: International Workshop on Object
Orientation in Operating Systems, pages 133-137, October 1991.
[2] D. Probert, J. Bruno. "Building fundamentally extensible application-
specific operating systems in Space", March 1995.
[3] D. Cheriton, K. Duda. "A caching model of operating system kernel
functionality". In: Proc. Symp. on Operating Systems Design and
Implementation, pages 179-194, Monterey CA (USA), 1994.
[4] D. Engler, M. Kaashoek, and J. O'Toole Jr. "Exokernel: an operating
system architecture for application-specific resource management",
December 1995.

If you don't want to go fetch the complete papers, here's a summary.
The first 2 discuss the Space nanokernel, the 3rd discussed the cache
nanokernel, and the last discusses exokernel.

The complete Adeos approach has been thoroughly documented in a whitepaper
published more than a year ago entitled "Adaptive Domain Environment
for Operating Systems" and available here: http://www.opersys.com/adeos
The current implementation is slightly different. Mainly, we do not
implement the functionality to move Linux out of ring 0. Although of
interest, this approach is not very portable.

Instead, our patch taps right into Linux's main source of control
over the hardware, the interrupt dispatching code, and inserts an
interrupt pipeline which can then serve all the nanokernel's clients,
including Linux.

This is not a novelty in itself. Other OSes have been modified in such
a way for a wide range of purposes. One of the most interesting
examples is described by Stodolsky, Chen, and Bershad in a paper
entitled "Fast Interrupt Priority Management in Operating System
Kernels" published in 1993 as part of the Usenix Microkernels and
Other Kernel Architectures Symposium. In that case, cli/sti were
replaced by virtual cli/sti which did not modify the real interrupt
mask in any way. Instead, interrupts were defered and delivered to
the OS upon a call to the virtualized sti.

Mainly, this resulted in increased performance for the OS. Although
we haven't done any measurements on Linux's interrupt handling
performance with Adeos, our nanokernel includes by definition the
code implementing the technique described in the abovementioned
Stodolsky paper, which we use to redirect the hardware interrupt flow
to the pipeline.

In terms of implementation, the Adeos' code is rather short since we
focused on setting the foundations for sharing interrupts between
domains. Here are the files we added:
kernel/adeos.c: Architecture-independent domain code.
arch/i386/kernel/adeos.c: Architecture-dependent domain code.
arch/i386/kernel/ipipe.c: Interrupt pipeline code.
include/asm-i386/adeos.h: Arch-dependent Adeos header.
include/linux/adeos.h: Main (arch-independent) Adeos header.

As you can see, only the i386 is currently supported. Nonetheless,
most of the architecture-dependent code is easily portable to other
architectures.

We also modified some files to tap into Linux interrupt dispatching
(all the modifications are encapsulated in #ifdef CONFIG_ADEOS/#endif):
        kernel/ksyms.c
        arch/i386/kernel/apic.c
        arch/i386/kernel/entry.S
        arch/i386/kernel/i386_ksyms.c
        arch/i386/kernel/i8259.c
        arch/i386/kernel/irq.c
        arch/i386/kernel/smp.c
        arch/i386/kernel/time.c
        arch/i386/kernel/traps.c
        arch/i386/mm/fault.c
        include/asm-i386/keyboard.h
        include/asm-i386/system.h

We modified the idle task so it gives control back to Adeos in order for
the ipipe to continue propagation:
arch/i386/kernel/process.c

We modified init/main.c to initialize Adeos very early in the startup.

Of course, we also added the appropriate makefile modifications and
config options so that you can choose to enable/disable Adeos as
part of the kernel build configuration.

Here is Adeos' public API:

    int adeos_register_domain(adomain_t *adp, adattr_t *attr);
    Register a new domain using the properties defined in the attribute.

    void adeos_unregister_domain(adomain_t *adp);
    Remove "adp" domain.

    void adeos_renice_domain(adomain_t *adp, int newpri);
    Change "adp"'s priority in the ipipe.

    void adeos_suspend_domain(void);
    This domain is done dealing with the current interrupt. This signals
    the ipipe to provide the interrupt to the next ipipe stage.

    void adeos_virtualize_irq(unsigned irq, void (*handler)(void),
    int (*acknowledge)(unsigned));
    Provide a handler and an acknowledgment function for "irq".

    void adeos_control_irq(unsigned irq, unsigned clrmask, unsigned
        setmask);
    Change the current domain's handling mask for irq "irq". "clrmask"
    is applied first and then "setmask" is applied.

    void adeos_stall_ipipe(void);
    Stall the current domain's ipipe stage. Alternative to cli.

    void adeos_unstall_ipipe(void);
    Unstall the current domain's ipipe stage. Alternative to sti.

    void adeos_restore_ipipe(unsigned x);
    Restore the ipipe from its saved state. Alternative to
    __restore_flags() and local_irq_restore(). This is used with the
    following defines:
    #define adeos_test_ipipe() \
	test_bit(IPIPE_STALL_FLAG,&adp_current->status)
    #define adeos_test_and_stall_ipipe() \
        test_and_set_bit(IPIPE_STALL_FLAG,&adp_current->status)
    Which replace __save_flags and local_irq_save(), respectively.

In Linux's case, adeos_register_domain() is called very early during
system startup. set_intr_gate() in arch/i386/kernel/traps.c is then
modified to call on adeos_virtualize_irq() so that Linux would tell
the ipipe that it needs the irq passed to set_intr_gate().

To add your domain to the ipipe, you need to:
1) Register your domain with Adeos using adeos_register_domain()
2) Call adeos_virtualize_irq() for all the IRQs you wish to be
notified about in the ipipe.

That's it. Provided you gave Adeos appropriate handlers in step
#2, your interrupts will be delivered via the ipipe.

During runtime, you may change your position in the ipipe using
adeos_renice_domain(). You may also stall/unstall the pipeline
and change the ipipe's handling of the interrupts according to your
needs.

We currently don't support SMP, but we do have APIC support on UP.

Here are some of the possible uses for Adeos (this list is far
from complete):
1) Much like User-Mode Linux, it should now be possible to have 2
Linux kernels living side-by-side on the same hardware. In contrast
to UML, this would not be 2 kernels one ontop of the other, but
really side-by-side. Since Linux can be told at boot time to use
only one portion of the available RAM, on a 128MB machine this
would mean that the first could be made to use the 0-64MB space and
the second would use the 64-128MB space. We realize that many
modifications are required. Among other things, one of the 2 kernels
will not need to conduct hardware initialization. Nevertheless, this
possibility should be studied closer.

2) It follows from #1 that adding other kernels beside Linux should
be feasible. BSD is a prime candidate, but it would also be nice to
see what virtualizers such as VMWare and Plex86 could do with Adeos.
Proprietary operating systems could potentially also be accomodated.

3) All the previous work that has been done on nanokernels should now
be easily ported to Linux. Mainly, we would be very interested to
hear about extensions to Adeos. Primarily, we have no mechanisms
currently enabling multiple domains to share information. The papers
mentioned earlier provide such mechanisms, but we'd like to see
actual practical examples.

4) By incorporating Adeos into the main kernel tree (I know my inbox
is probably going to fill up because of this one), kernel debuggers'
main problem (tapping into the kernel's interrupts) is solved and it
should then be possible to provide patchless kernel debuggers. They
would then become loadable kernel modules.

5) Drivers who require absolute priority and dislike other kernel
portions who use cli/sti can now create a domain of their own
and place themselves before Linux in the ipipe. This provides a
mechanism for the implementation of systems that can provide guaranteed
realtime response.

Of course, we are interested in hearing about comments and suggestions
you have about Adeos.

Best regards,

Philippe Gerum
Karim Yaghmour

----------------------------------------------------------------------
Links to papers:
1-
http://citeseer.nj.nec.com/probert91space.html
ftp://ftp.cs.ucsb.edu/pub/papers/space/iwooos91.ps.gz (not working)
http://www4.informatik.uni-erlangen.de/~tsthiel/Papers/Space-iwooos91.ps.gz

2-
http://www.cs.ucsb.edu/research/trcs/abstracts/1995-06.shtml
http://www4.informatik.uni-erlangen.de/~tsthiel/Papers/Space-trcs95-06.ps.gz

3-
http://citeseer.nj.nec.com/kenneth94caching.html
http://guir.cs.berkeley.edu/projects/osprelims/papers/cachmodel-OSkernel.ps.gz

4-
http://citeseer.nj.nec.com/engler95exokernel.html
ftp://ftp.cag.lcs.mit.edu/multiscale/exokernel.ps.Z
----------------------------------------------------------------------
--------------0A8391E6E92C327136836BE9
Content-Type: application/octet-stream;
 name="adeos.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="adeos.tgz"

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
AAA=

--------------0A8391E6E92C327136836BE9--

