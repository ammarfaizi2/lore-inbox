Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWCHPmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWCHPmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 10:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWCHPmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 10:42:00 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:10901 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751013AbWCHPl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 10:41:59 -0500
Date: Wed, 8 Mar 2006 08:41:57 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@redhat.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Message-ID: <20060308154157.GI7301@parisc-linux.org>
References: <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308145506.GA5095@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 09:55:06AM -0500, Alan Cox wrote:
> On Wed, Mar 08, 2006 at 02:37:58PM +0000, David Howells wrote:
> > + (*) reads can be done speculatively, and then the result discarded should it
> > +     prove not to be required;
> 
> That might be worth an example with an if() because PPC will do this and if 
> its a read with a side effect (eg I/O space) you get singed..

PPC does speculative memory accesses to IO?  Are you *sure*?

> > +same set of data, but attempting not to use locks as locks are quite expensive.
> 
> s/are quite/is quite
> 
> and is quite confusing to read

His  grammar's right ... but I'd just leave out the 'as' part.  As
you're right that it's confusing  ;-)

> > +SMP memory barriers are normally mere compiler barriers on a UP system because
> 
> s/mere//
> 
> Makes it easier to read if you are not 1st language English.

Maybe s/mere/only/?

> > +SMP memory barriers are only compiler barriers on uniprocessor compiled systems
> > +because it is assumed that a CPU will be apparently self-consistent, and will
> > +order overlapping accesses correctly with respect to itself.
> 
> Is this true of IA-64 ??

Yes:

#else
# define smp_mb()       barrier()
# define smp_rmb()      barrier()
# define smp_wmb()      barrier()
# define smp_read_barrier_depends()     do { } while(0)
#endif

> > + (*) inX(), outX():
> > +
> > +     These are intended to talk to legacy i386 hardware using an alternate bus
> > +     addressing mode.  They are synchronous as far as the x86 CPUs are
> 
> Not really true. Lots of PCI devices use them. Need to talk about "I/O space"

Port space is deprecated though.  PCI 2.3 says:

"Devices are recommended always to map control functions into Memory Space."

> > +
> > +     These are guaranteed to be fully ordered and uncombined with respect to
> > +     each other on the issuing CPU, provided they're not accessing a
> 
> MTRRs
> 
> > +     prefetchable device.  However, intermediary hardware (such as a PCI
> > +     bridge) may indulge in deferral if it so wishes; to flush a write, a read
> > +     from the same location must be performed.
> 
> False. Its not so tightly restricted and many devices the location you write
> is not safe to read so you must use another. I'd have to dig the PCI spec 
> out but I believe it says the same devfn. It also says stuff about rules for
> visibility of bus mastering relative to these accesses and PCI config space
> accesses relative to the lot (the latter serveral chipsets get wrong). We
> should probably point people at the PCI 2.2 spec .

3.2.5 of PCI 2.3 seems most relevant:

Since memory write transactions may be posted in bridges anywhere
in the system, and I/O writes may be posted in the host bus bridge,
a master cannot automatically tell when its write transaction completes
at the final destination. For a device driver to guarantee that a write
has completed at the actual target (and not at an intermediate bridge),
it must complete a read to the same device that the write targeted. The
read (memory or I/O) forces all bridges between the originating master
and the actual target to flush all posted data before allowing the
read to complete. For additional details on device drivers, refer to
Section 6.5. Refer to Section 3.10., item 6, for other cases where a
read is necessary.

Appendix E is also of interest:

2. Memory writes can be posted in both directions in a bridge. I/O and
Configuration writes are not posted. (I/O writes can be posted in the
Host Bridge, but some restrictions apply.) Read transactions (Memory,
I/O, or Configuration) are not posted.

5. A read transaction must push ahead of it through the bridge any posted
writes originating on the same side of the bridge and posted before
the read.  Before the read transaction can complete on its originating
bus, it must pull out of the bridge any posted writes that originated
on the opposite side and were posted before the read command completes
on the read-destination bus.


I like the way they contradict each other slightly wrt config reads and
whether you have to read from the same device, or merely the same bus.
One thing that is clear is that a read of a status register on the bridge
isn't enough, it needs to be *through* the bridge, not *to* the bridge.
I wonder if a config read of a non-existent device on the other side of
the bridge would force the write to complete ...
