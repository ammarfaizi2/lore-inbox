Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWECXGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWECXGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 19:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWECXGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 19:06:46 -0400
Received: from smtp-1.llnl.gov ([128.115.3.81]:62127 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S1751192AbWECXGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 19:06:45 -0400
Date: Wed, 03 May 2006 16:06:30 -0700
From: David Peterson <peterson66@llnl.gov>
Subject: Re: Problems with EDAC coexisting with BIOS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tim Small <tim@buttersideup.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Gross, Mark" <mark.gross@intel.com>,
       bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Message-id: <64140659c4.659c464140@llnl.gov>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.1 Patch 1 (built Jun  6 2002)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2006-05-03, Alan Cox wrote:
> > something with NMI-signalled errors, I was wondering what the 
problems 
> > with using NMI-signalled ECC errors were?
> 
> The big problem with NMI is that it can occur *during* a PCI
> configuration sequence (ie during pci_config_* functions). That 
> means we can't safely do some I/O, especially configuration space 
I/O in an NMI
> handler. At best we could set a flag and catch it afterwards.

This is roughly what I did in the NMI handling code I wrote for
bluesmoke.  If my memory is correct, I believe there's a spinlock
that pci_read_config_dword() and friends acquire.  Basically
I did the following type of thing:

    /* Using spin_trylock() below avoids deadlock in the case where
     * the code interrupted by the NMI is holding the lock.
     */
    if (likely(spin_trylock(&lock))) {
            We got the lock.  Go ahead and access PCI config space
            (and then drop the lock)...
    } else {
            This case should be rare in practice.  Defer the access to
            PCI config space outside NMI context (I wrote a little API
            that facilitates doing this kind of stuff in a manner that
            avoids deadlocks and race conditions associated with NMI
            handlers).
    }

For anyone who is interested, the code may be obtained by going to
http://sourceforge.net/projects/bluesmoke/ and downloading the latest
version of the 'bluesmoke' package.  It's experimental stuff that
hasn't seen much testing.  Also it's not quite functional as-is
because a little piece of code still needs to be added somewhere that
enables SERR#.

I'm not necessarily advocating that NMI-driven error handling should
go into the mainstream kernel.  The expected benefits would have to
be weighed against the extra complexity that the code introduces.
However the parts of the code that handle the basic NMI-related
synchronization issues are abstracted into a relatively clean 
architecture-independent API that may be useful in other places where
NMIs (or similar types of exceptions/interrupts on other platforms)
are used.  I posted this code to LKML a while ago but it has since
been improved.  Perhaps having this type of code (or something
similar) in just one location would be an improvement over reinventing
the wheel in a number of places.

There is an issue regarding NMI-driven error handling that may be a
substantial pain to deal with on x86: When NMI occurs, we can't be
sure whether the NMI is from the watchdog, or due to a hardware error.
Therefore we must check the hardware for errors on each NMI.  This is
no better than polling (at whatever frequency the watchdog runs at).

The above problem can be worked around as follows (although I'm
not advocating that this be done in Linux): Modify local_irq_disable()
and local_irq_enable() so that instead of using cli/sti machine
instructions they adjust the interrupt priority level (controlled by
the local APIC on x86 processors) as follows:

    local_irq_disable()
    {
            Set interrupt priority level to (MAX_PRIORITY - 1).
            In other words, all interrupts are masked out except
            those whose priority is MAX_PRIORITY.
    }

    local_irq_enable()
    {
            Set interrupt priority level to 0 (i.e. all interrupts
            are enabled).
    }

Then the watchdog may be implemented as a normal interrupt with
priority MAX_PRIORITY, and all other interrupts may be given lower
priorities.  NMI would then only be asserted for genuine hardware
errors (PCI parity errors, ECC memory errors, etc.).  This is
probably more trouble than it's worth.  However I think it's doable
in principle.




