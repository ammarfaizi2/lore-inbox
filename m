Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932914AbWCVWg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbWCVWg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbWCVWgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:36:25 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:1809 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932897AbWCVWgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:36:17 -0500
Message-ID: <4421D0C9.6080603@vmware.com>
Date: Wed, 22 Mar 2006 14:33:45 -0800
From: Daniel Arai <arai@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <200603222115.46926.ak@suse.de> <20060322214025.GJ15997@sorel.sous-sol.org> <4421CCA8.4080702@vmware.com>
In-Reply-To: <4421CCA8.4080702@vmware.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> Chris Wright wrote:
>
>> Strongly agreed.  The strict ABI requirements put forth here are not
>> in-line with Linux, IMO.  I think source compatibility is the limit of
>> reasonable, and any ROM code be in-tree if something like this were to
>> be viable upstream.
> 
> The idea of in-tree ROM code doesn't make sense.  The entire point of 
> this layer of code is that it is modular, and specific to the 
> hypervisor, not the kernel.  Once you lift the shroud and combine the 
> two layers, you have lost all of the benefit that it was supposed to 
> provide.

To elaborate a bit more, the "ROM" layer is "published" by the hypervisor.  This 
layer of abstraction will let you take a VMI-compiled kernel and run it 
efficiently on any hypervisor that exports a VMI interface - even one that you 
didn't know about (or didn't exist) when you compiled your kernel.

If the ROM part is compiled into the code, then you have to compile in support 
for the specific hypervisor(s) you want to run on.  It might be reasonable for 
this code to be in a lodable kernel module, rather than a device ROM per se, but 
you still want that kernel module to be provided by the hypervisor.

Suppose someone implements a ROM layer for UML, or QEMU, or even for Microsoft's 
hypervisor.  Having the ROM published by the hypervisor now lets you run your 
kernel on that new hypervisor without recompiling.  While this might not be much 
of a benefit for an individual developer who downloads and compiles his own 
kernel, this is a huge win for people who distribute binary kernels, or large IT 
organizations that may have large heterogenous virtual machine farms to maintain.

Going forward, having the ROM layer published by the hypervisor gives the 
hypervisor more flexibility than having the code statically compiled into the 
kernel.  Consider when hardware virtualization becomes more prevalent.  Perhaps 
there are places where today hypercalls make sense, but with hardware 
virtualization, you'd rather have the hardware just take care of it.  CPUID is 
the only example I can come up with at the moment, but there are certainly 
others.  VMI lets the hypervisor decide that it doesn't actually need to replace 
the CPUID instruction with a hypercall.  The important factor here is that only 
the hypervisor, not the kernel, knows about these performance tradeoffs.  Or 
maybe in the next version of Xen, it's possible to use sysenter rather than an 
interrupt instruction to do hypercalls.  If the hypervisor publishes this code, 
even older kernels can transparently take advantage of faster ways of doing 
certain things.

Dan.

