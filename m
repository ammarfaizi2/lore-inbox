Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWCNSEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWCNSEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWCNSEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:04:43 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:63750 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751706AbWCNSEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:04:43 -0500
Message-ID: <4417058E.1090202@vmware.com>
Date: Tue, 14 Mar 2006 10:03:58 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
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
Subject: Re: [RFC, PATCH 17/24] i386 Vmi msr patch
References: <200603131812.k2DICGJE005747@zach-dev.vmware.com> <200603141723.54365.ak@suse.de> <4416F038.90707@vmware.com> <200603141843.24159.ak@suse.de>
In-Reply-To: <200603141843.24159.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>> And I don't think it's a good idea to virtualize the TSC
>>> without CPU support.
>>>       
>> We currently don't support configurations without a TSC.  But we're not
>> trying to virtualize the TSC without CPU support.  It is possible.  But
>> I have no idea _why_ you would want to do such a thing.
>>     
>
> Don't change it then?
>   

I misunderstood you.  I thought when you said, "I don't think it's a 
good idea virtualize the TSC without CPU support" that meant on CPUs 
without a hardware TSC.  If you really meant on CPUs without 
virtualization hardware, well, that is something we do, and it is not 
only possible, it is necessary for many non-paravirtualized operating 
systems.  As I mention in the interface documentation, TSC and the 
performance counters in general are very problematic in a virtual 
machine - they can be visible to userspace, and they are hard to keep 
accurate.  Long term, dropping kernel usage of the TSC is a good thing 
to do for VMs.

The primary motivation for the change here was to get rid of the call to 
the VMI ROM for TSC support.  I am in the process of removing the ROM 
call sites so that they can instead be patched into the kernel 
directly.  I am actually unsure if there are any uses of the TSC left on 
critical paths with the new VMI timer support, but I inlined the code 
here for consistency.

I agree that long term, it doesn't need to be done, and these 
instructions can all go back to trap and emulate.  Perhaps they are even 
worth dropping from the list of VMI calls, since they really are 
problematic and/or not useful in a virtual machine.  This again, is a 
good point for debate.  We're open to suggestions, but keep in mind that 
the fact that other operating systems and hypervisors might find 
something useful in virtualizing them.  Maybe not.

> BTW I think it will be pretty tough to find enough competent reviewers
> for your patchkit.
>
> And is the spec still in flux or are you trying to implement an interface
> for an specification that is already put into stone? 
>   

Everything is still very much open to change, and nothing is cast in 
stone - this is about finding the best interface for Linux, and it is 
clear that it needs some iteration before that is found.  Which is why 
we are looking for feedback, exactly like this.

Thanks,

Zach
