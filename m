Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWCED7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWCED7c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 22:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCED7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 22:59:32 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:34576 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750825AbWCED7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 22:59:31 -0500
Message-ID: <440A6212.8040408@vmware.com>
Date: Sat, 04 Mar 2006 19:59:14 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: "Zach, Yoav" <yoav.zach@intel.com>, hostmaster@ed-soft.at,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: [PATCH 1/1] EFI: Fix gdt load
References: <20060304185655.73247b76.akpm@osdl.org>
In-Reply-To: <20060304185655.73247b76.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Doh.  Too many Zachs.
>
>
> Begin forwarded message:
>
> Date: Sat, 4 Mar 2006 18:43:19 -0800
> From: Andrew Morton <akpm@osdl.org>
> To: Edgar Hucek <hostmaster@ed-soft.at>
> Cc: linux-kernel@vger.kernel.org, "Zach, Yoav" <yoav.zach@intel.com>, Matt Domsch <Matt_Domsch@dell.com>
> Subject: Re: [PATCH 1/1] EFI: Fix gdt load
>
>
> Edgar Hucek <hostmaster@ed-soft.at> wrote:
>   
>> This patch makes the kernel bootable again on ia32 EFI systems.
>>
>>     
>
> Argh, thanks.  I'll move the per_cpu() call inside the lock, just in case
> we happen to be running preemptibly there.
>
> Zach, Matt: please review, test and ack asap?
>   

Ok, that was subtle.  It took me 10 minutes staring at this code to 
notice the extra __pa and __va in the load_gdt call.  Actually, by sheer 
coincidence, the first one was actually still correct.  Normally, this 
code would just totally blow up, but you've just identity mapped virtual 
and physical addresses.  The second one will blow up after the EFI call 
without the fix.

Unfortunately, I can't test EFI; I have no machines here that are EFI 
capable.

This code has always confused me, though.  Why do we do this crazy hack 
to begin with?  The crazy hack is not remapping the GDT in physical 
space, or simulating non-paging memory with paging enabled - that is 
completely normal.  But why do we muck with the GDT for CPU zero instead 
of the current CPU?  If the EFI code decides to reload FS or GS, we have 
now leaked the user FS or GS from CPU zero onto the current CPU, and I 
see no code here which restricts EFI to run on the BSP.  This will break 
userspace TLS programs.  Of course, I have no evidence that EFI will 
reload FS or GS, but it must be doing something with segmentation, or 
you would not have needed to reload the GDT.

Second, there is another bug in this code as well.  Why do we care if 
PSE is enabled when identity mapping virtual to physical space?  PSE has 
_nothing_ to do with this.  You are copying top level page ranges, which 
are the same size, with or without PSE.  We should be checking if PAE is 
enabled, and we shouldn't even need to check, since it will either be 
compiled in or not.  This code is scarily just quite lucky that the 
kernel is small enough to fit.

For PAE mode, PSE is always going to be enabled (I believe), so you end 
up remapping 1GB of virtual space into physical space.  For non-PAE, PSE 
may or may not be enabled, in which case, you end up remapping either 
4MB or 8MB of the kernel virtual address space back at zero.

I don't believe 4MB is enough to make sure all of the per-cpu variables 
can be safely referenced, although I could be wrong.  So if there are 
EFI machines out there with processors installed that have no PSE 
support, and the kernel gets large enough, this code blows up again.  I 
actually think that is quite likely as EFI becomes more prevalent and 
older core processors continue to be made for the embedded market.

Zach
