Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314088AbSDKPPh>; Thu, 11 Apr 2002 11:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314091AbSDKPPg>; Thu, 11 Apr 2002 11:15:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1858 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314088AbSDKPPe>; Thu, 11 Apr 2002 11:15:34 -0400
To: Andy Pfiffer <andyp@osdl.org>
Cc: suparna@in.ibm.com, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
In-Reply-To: <1759496962.1018114339@[10.10.2.3]>
	<m18z80nrxc.fsf@frodo.biederman.org> <3CB1A9A8.1155722E@in.ibm.com>
	<m1ofgum81l.fsf@frodo.biederman.org> <20020409205636.A1234@in.ibm.com>
	<m1y9fvlfyb.fsf@frodo.biederman.org> <1018461522.4453.212.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Apr 2002 09:08:44 -0600
Message-ID: <m1pu16l1c3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Wed, 2002-04-10 at 08:40, Eric W. Biederman wrote:
> 
> > Unless I missed something the Linux kernel won't work on smp though.
> > It is a matter of resetting the state of the apics, and ensuring you
> > are running on the first processor.  I don't believe bootimg did/does that.
> > 
> 
> The copy of bootimg that I have makes no effort to offline CPU's or
> reset the APICs.  If there is a newer version, I could not find it.
> 
> I have tried 3 different solutions for for Linux-reloading-linux
> (bootimg, two-kernel monte, and kexec), and none of them fully support
> the kinds of enterprise-class systems we (OSDL) care about:
> 
> 	1. multiprocessor x86 (p3, p4, +xeons) with APICs
> 	2. >4GB memory
> 	3. CPU hotplug
> 	4. device hotplug
> 	5. >= 2.5.x kernel

kexec should handle.
        1. multiprocessor x86 (p3, p4, +xeons) with APICs
        2. >4GB memory
        3. >= 2.5.x kernel
        4. potentially non-x86.
 
> In fact, I have yet to find any variation of linux-loading-linux that
> works at all on the 2-way P4-Xeon under my desk or the 8-way P3-Xeon in
> the lab.  The only system I have ever seen Two Kernel Monte work on here
> is a Celeron-based machine in a nearby cube.

Interesting.  I know I have it runs on the 2-way P4-Xeon under my
desk.  So maybe it is a compiler bug, or some weird firmware case I
don't handle correctly.
 
> The >4GB of memory problem is an interesting quirk -- if the
> linux-loading-linux implementation assumes that it can perform the final
> copy in 32-bit protected mode *without* paging enabled, it won't
> reliably work on >4GB systems.

Sure it will, if it only allocates the memory from the low 4GB, in fact
my kexec code makes certain to allocate memory from the kernel address
space.  get_free_page() in ZONE_NORMAL.  This is the low 896MB.  So
there shouldn't be a problem.  This was done very deliberately so it
would work on these kinds of systems.

> > In general yes.  There are some interesting side effects though.
> > Going through the pci bus and shutting off bus masters is a good
> > first approximation of what needs to happen.
> > 
> 
> The new device model from Pat (mochel@osdl.org) is probably the best way
> to go here; you'll be able to walk the driver tree and reliably turn off
> devices.

I totally agree.  Walking the driver tree is exactly what I want.
Disabling bus masters is just a quick hack to rule out a DMA killing
your linux booting linux.

> For the CPU side of things, the CPU hotplug work looks promising as
> well.

Interesting.  So far I haven't seen a system that supports CPU hot
plug, on x86 so I have no clue here.

Eric
