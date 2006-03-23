Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422727AbWCWXqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWCWXqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWCWXqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:46:00 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:46603 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1422727AbWCWXp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:45:59 -0500
Message-ID: <44233332.3070404@vmware.com>
Date: Thu, 23 Mar 2006 15:45:54 -0800
From: Eli Collins <ecollins@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Chris Wright <chrisw@sous-sol.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Christopher Li <chrisl@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Kip Macy <kmacy@fsmware.com>, Jyothy Reddy <jreddy@vmware.com>,
       Anne Holler <anne@vmware.com>, Ky Srinivasan <ksrinivasan@novell.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [Xen-devel] Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>	<200603222115.46926.ak@suse.de>	<20060322214025.GJ15997@sorel.sous-sol.org>	<4421EC44.7010500@us.ibm.com>	<20060323004006.GQ15997@sorel.sous-sol.org> <caf37c433827769063ccb0269adbaa09@cl.cam.ac.uk>
In-Reply-To: <caf37c433827769063ccb0269adbaa09@cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2006 23:45:54.0598 (UTC) FILETIME=[ECE2A460:01C64ED3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
> We could extend the concept of the interface shim we already have -- a 
> set of OS-specific high performance shims, plus a fallback OS-agnostic 
> shim.

Currently the lack of a shim is the key difference between the VMI and 
Xen approaches. Forgive me for summarizing, but I'm not sure it's been 
made clear. The VMI is the interface between the OS and a shim layer--it 
is not a hypervisor interface. The kernel makes VMI calls to the shim 
and the shim makes hypercalls, if needed, to the hypervisor.

     VMI                   VMI native            Xen/Xen native


      OS                      OS                     OS
-------------- VMI      -------------- VMI
   Shim (ROM)
-------------- HV API                          -------------- HV API
   Hypervisor              Native HW              Hypervisor


The VMI isolates the kernel from the hypervisor so that the kernel and 
the hypervisor can evolve w/o hindering each other's development. The 
Xen approach still tightly couples the hypervisor with the kernel. 
Coupling the kernel and hypervisor together restricts their evolution 
and people who want to run different operating systems (or different 
versions of the same OS) on the same hypervisor. As Josh pointed out, 
you can run a single VMI Linux kernel on more versions of the Xen 
hypervisor than you can using a single XenLinux kernel because the VMI 
does not require a tight coupling.

Tight coupling also means you end up using a hypervisor when running a 
kernel natively (e.g. "supervisor mode kernel" in the unstable Xen 
repository). So for the native case you get a level of indirection (the 
hypervisor) that costs you performance, and for the virtual case you do 
not get a level of indirection (a shim) that buys you compatibility and 
diversity. For VMI, it's the reverse, you get the level of indirection 
in the virtual case and no indirection in the native case. You could 
have separate kernels, and all the associated costs, for these two cases.

There are many places where the VMI and Xen patches overlap; the key 
difference is that the VMI makes a distinction between the kernel and 
the hypervisor interfaces. As others have pointed out this distinction 
buys you a lot in terms of compatibility, ease of maintenance, and the 
ability to execute the same kernel in native and virtual environments 
with high performance.

Which particular bits get in is less important than the decision of 
whether or not the Linux community wants the kernel tightly coupled to 
the hypervisor. Extending the hypercall page you already have to 
decouple the hypervisor and kernel interfaces would be excellent.

Eli
