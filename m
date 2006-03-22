Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbWCVXgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWCVXgu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWCVXgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:36:50 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:45064 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932608AbWCVXgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:36:49 -0500
Message-ID: <4421DF62.8020903@vmware.com>
Date: Wed, 22 Mar 2006 15:36:02 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Linus Torvalds <torvalds@osdl.org>,
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
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421CCA8.4080702@vmware.com> <20060322225117.GM15997@sorel.sous-sol.org>
In-Reply-To: <20060322225117.GM15997@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> You could compile all platform layers you want to support with the kernel.
>   

But the entire point is that you don't know what platform layers you 
want to support.  The platform layers can change.  Xen has changed the 
platform layer and re-optimized kernel / hypervisor transitions how many 
times?  The platform layer provides exactly the flexibility to do that, 
so that a kernel you compile today against a generic platform can work 
with the platform layer provided by Xen 4.0 tomorrow.

Compiling the platform layer with the kernel for "source compatibility" 
is exactly what prevents you from doing this.  And you get stuck having 
the same stable and inflexible ABI to the hypervisor, rather than a 
carefully architected ABI just before it.  The most important design 
decision in creating the VMI layer was disallowing data dependence 
between the compiled kernel and the hypervisor ABI.

I have seen, and will continue to see, every single shared data block 
layout change to meet the demands of new features.  Eventually, you get 
to a point where it is growing antlers and having new hooves grafted 
onto it, yet still requires all of the original cruft you used to do.  
It is either a maintenance nightmare, or a compatibility nightmare.  If 
you want compatibility, you really can't break that interface all the 
time, and the real world demands of customers using virtualization 
solutions really do want that compatibility.  You simply can't certify a 
complex platform if you have to recompile your kernel for every new 
release of your chosen hypervisor.  Bugs do get introduced this way, the 
older kernels fall out of maintenance, and eventually you are forcing 
them to upgrade to the latest kernels, which even worse, may have 
changed the userspace interface, dropped legacy feature support, and 
broken your key application that was the entire point of running in a VM 
to begin with.  People throw things in VMs and then expect those VMs to 
keep running for years, and you really can't break that.

So instead, you impose a giant maintenance burden on the hypervisor, 
forcing them to go to all efforts to avoid breaking this hypervisor 
ABI.  That leads directly to crufty, unstable, and poor performing code.

So the VMI layer is all about defining an ABI at a slightly higher 
level.  A level which has many benefits you simply can't get from source 
compatibility.  It is about the future, about preparing for the unknown, 
about giving a powerful abstraction to the platform layer to do whatever 
it chooses to do.

If Intel announces a new chip tomorrow, with a feature bit that allows 
selective privileged instructions to operate in non-zero supervisor 
CPLs, you're really going to regret the fact that you can't issue page 
invalidations and TLB flushes directly in the kernel because you 
unwisely decided to compile these in as direct int $0x81 hypercalls.  
You can change the platform layer and let new versions pick that up, and 
try to encourage people to move to newer kernels.  And you have to make 
this change for every single operating system you support, leading to 
greater risk for introducing bugs in addition to any unwanted side 
effects of a kernel upgrade.  Even worse, you may find a bug that 
_requires_ changing the platform layer.  It might be a wide, gaping 
security hole.  We had a few in the course of development (kernel CS 
entry value stored in shared area..).  Now you have to break the 
hypervisor ABI, all your customers think you suck, and they have to 
upgrade all their systems.  Perhaps they have been happily running the 
2.4.26 kernel up to now.  What do they do?

Why do you want to bind yourself to source compatibility, when it does 
not bring you features at all, it only hurts you in terms of deployment 
flexibility?

Zach
