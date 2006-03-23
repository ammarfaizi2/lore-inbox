Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWCWSvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWCWSvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWCWSvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:51:01 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47630 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1422659AbWCWSvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:51:00 -0500
Message-ID: <4422EE12.7060908@vmware.com>
Date: Thu, 23 Mar 2006 10:50:58 -0800
From: Zachary Amsden <zach@vmware.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
>>
>> Yeah, point is the interface is normal C API, and has the similar free
>> form that normal kernel API's have.
>
> i think this sounds very sane, and an OS-specific interface shim gets 
> around problems such as finding CPU-specific state -- we can get at 
> smp_processor_id() just the same as the rest of the kernel, for 
> example. We could extend the concept of the interface shim we already 
> have -- a set of OS-specific high performance shims, plus a fallback 
> OS-agnostic shim.

Getting at smp_processor_id() is exactly the type of thing you _don't_ 
want to do.  You really can't have callbacks into the guest in the 
hypervisor platform layer.  It really is not efficient, and you cause 
yourself more trouble than it is worth.

And where exactly is smp_processor_id() exported to modules?  It's not.  
You've just locked your module into the current kernel's idea of how to 
get at smp_processor_id().  It changes based on compilation options of 
the kernel - for example, it is different with 4K stacks.  It has 
changed from a number of other different options in the past.

The fact that XenoLinux needs smp_processor_id() at all is quite 
ludicrous.  To disable interrupts, which is used fairly commonly to 
disable pre-emption as well, what does XenoLinux have to do?

It has to disable pre-emption to call smp_processor_id() so that it can 
disable interrupts, the re-enable preemption so that it can disable 
pre-emption.

That is truly convoluted, and is exactly why you should never get into 
these types of situations to begin with.

Zach
