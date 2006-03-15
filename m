Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWCOFsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWCOFsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 00:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWCOFsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 00:48:13 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:19216 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932601AbWCOFsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 00:48:12 -0500
Message-ID: <4417A9C5.70300@vmware.com>
Date: Tue, 14 Mar 2006 21:44:37 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <20060313224902.GD12807@sorel.sous-sol.org> <4416078C.4030705@vmware.com> <20060314212742.GL12807@sorel.sous-sol.org> <441743BD.1070108@vmware.com> <20060315025720.GN12807@sorel.sous-sol.org>
In-Reply-To: <20060315025720.GN12807@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>>> 1) can't use stack based args, so have to allocate each data structure,
>>> which could conceivably fail unless it's some fixed buffer.
>>>       
>> We use a fixed buffer that is private to our VMI layer.  It's a per-cpu 
>> packing struct for hypercalls.  Dynamically allocating from the kernel 
>> inside the interface layer is a really great way to get into a whole lot 
>> of trouble.
>>     
>
> Heh, indeed that's why I asked.  per-cpu buffer means ROM state knows
> which vcpu is current.  How is this done in OS agnostic method w/out
> trapping to hypervisor?  Some shared data that ROM and VMM know about,
> and VMM updates as it schedules each vcpu?
>   

Yes, we have private mappings per CPU.  I don't think that is as 
feasible on Xen, since it requires the hypervisor to support a per-CPU 
PD shadow for each root.  But alternative implementations are possible 
using segmentation.  The primary advantage is that you don't need to 
call back from the interface layer to disable preemption for per-CPU 
data access.

It turns out to be really easy if you add the loadsegment / savesegment 
macros to the VMI interface, and require the kernel to abstain from 
using, say, the GS segment.  I think this is the path we are going down 
for the VMI on Xen 3 port.

> I agree with your final assessment, needs more threshing out.  It does
> feel a bit overkill at first blush.  I worry about these semantic
> changes as an annotation instead of explicit API update.  But I guess
> we still have more work on finding the right actual interface, not just
> the possible ways to annotate the calls.
>   

Yes, lets focus on finding the right interface for now - and just leave 
the door open a bit for the future.

Cheers,

Zach
