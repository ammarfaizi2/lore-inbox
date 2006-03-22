Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932867AbWCVWbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbWCVWbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932864AbWCVWa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:30:56 -0500
Received: from ns.suse.de ([195.135.220.2]:39397 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932863AbWCVWay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:30:54 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
Date: Wed, 22 Mar 2006 22:58:09 +0100
User-Agent: KMail/1.9.1
Cc: virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222105.58912.ak@suse.de> <4421C9D4.3050806@vmware.com>
In-Reply-To: <4421C9D4.3050806@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222258.11904.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 23:04, Zachary Amsden wrote:

> 
> It doesn't.  But consider that oprofile is a time based NMI sampler.  

That's one of its modes, mostly used for people with broken APICs. 

But the primary mode of operation is an  event based sampler using 
performance counter events.


> There still is.  This is why you have the "sti; sysexit" pair, and why 
> safe_halt() is "sti; hlt".  You really don't want interrupts in those 
> windows.  The architectural oddity forced us to make these calls into 
> the VMI interface.  A third one, used by some operating systems, is 
> "sti; nop; cli" - i.e. deliver pending interrupts and disable again.  In 
> most other cases, it doesn't matter.

Sounds like something that should be discussed in the spec.
 
> > Seems useless to me.
> >   
> 
> Agree.  TSC is broken in so many ways, that it really should not be used 
> for anything other than unreliable cycle counting.

It can be used with an aggressive white list and if you know what you're
doing. The x86-64 kernel follows this approach, which allows to use
it at least on some common classes of systems (AMD single core, Intel
non NUMA P4) 

Actually for cycle counting it is useless because on newer Intel CPUs
it always runs at the highest P state no matter which P state you're in.

My evil plan to deal with that was to export the cycle count running in PMC0
for the NMI watchdog to ring 3 so people could just use RDPMC 0 instead.
There was some opposition to this idea unfortunately.

But the hypervisor should keep its fingers out of all that as far as possible.




> 
> >   
> >> +    VMI_RDPMC
> >> +
> >> +       VMICALL VMI_UINT64 VMI_RDPMC(VMI_UINT64 dummy, VMI_UINT32 counter);
> >> +
> >> +       Similar to RDTSC, this call provides the functionality of reading
> >> +       processor performance counters.  It also is selectively visible to
> >> +       userspace, and maintaining accurate data for the performance counters
> >> +       is an extremely difficult task due to the side effects introduced by
> >> +       the hypervisor.
> >>     
> >
> > Similar.
> >
> > Overall feeling is you have far too many calls. You seem to try to implement
> > a full x86 replacement, but that makes it big and likely to be buggy. And 
> > it's likely impossible to implement in any Hypervisor short of a full emulator
> > like yours.
> >
> > I would try a diet and only implement facilities that are actually likely
> > to be used by modern OS.
> >   
> 
> The interface can't really go on too much of a diet - some kernel 
> somewhere, maybe not Linux, under some hypervisor, maybe not VMware or 
> Xen, may want to use these features. 

This might sound arrogant, but I would expect that near all modern
kernels don't use much more of the x86 subset than Linux is using
(biggest exception I can think of would be interrupt priorities) 



> 
> Taken to the extreme, where the patch processing is done before the 
> kernel runs, in the hypervisor itself, using the annotation table 
> provided by the guest kernel, it is even easier.  If you see an 
> annotation for a feature you don't care to implement, you don't do 
> anything at all - you leave the native instructions as they are.  In 
> this case, neither the kernel nor the hypervisor has any extra code at 
> all to deal with cases they don't care about.  But the rich interface is 
> still there, and if someone wants to bathe in butter, who are we to 
> judge.  

So basically you're trying to implement VT/Pacifica in software
with all these trap? 

I'm not sure that's the right approach.

My feeling would be that for a efficient para virtualized interface a better
approach would be to try to optimize the kernels a bit more 
for the emulated case.

Longer term there will be more optimizations (like better interaction
of VM maybe or para drivers that work faster). But if the base interface
is already so big that adding even more stuff might make it explode
at some point.

> There certainly are uses for it.  For example, WRMSR is not on  
> critical paths in i386 Linux today. 

Actually i got a feature request today that would require to optionally
do a wrmsr in the context switch :/


-Andi
