Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWCEQsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWCEQsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 11:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWCEQsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 11:48:20 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:52674
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S932216AbWCEQsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 11:48:19 -0500
Message-ID: <440B1658.1090409@ed-soft.at>
Date: Sun, 05 Mar 2006 17:48:24 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, "Zach, Yoav" <yoav.zach@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: [PATCH 1/1] EFI: Fix gdt load
References: <20060304185655.73247b76.akpm@osdl.org> <440A6212.8040408@vmware.com>
In-Reply-To: <440A6212.8040408@vmware.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I fight against a new EFI bug. With 512MB ram the iMac boots fine, but when i add
extra 512MB to have 1GB ram the kernel stops booting. Still didn't found the problem.
I think it have something to do with the efi_memmap_walk funtction. The major problem
in debuging the problem is that i have no video out at this boot stage. I only can
test it with a machine reboot code.

cu

Edgar (gimli) Hucek

Zachary Amsden wrote:
> Andrew Morton wrote:
>> Doh.  Too many Zachs.
>>
>>
>> Begin forwarded message:
>>
>> Date: Sat, 4 Mar 2006 18:43:19 -0800
>> From: Andrew Morton <akpm@osdl.org>
>> To: Edgar Hucek <hostmaster@ed-soft.at>
>> Cc: linux-kernel@vger.kernel.org, "Zach, Yoav" <yoav.zach@intel.com>,
>> Matt Domsch <Matt_Domsch@dell.com>
>> Subject: Re: [PATCH 1/1] EFI: Fix gdt load
>>
>>
>> Edgar Hucek <hostmaster@ed-soft.at> wrote:
>>  
>>> This patch makes the kernel bootable again on ia32 EFI systems.
>>>
>>>     
>>
>> Argh, thanks.  I'll move the per_cpu() call inside the lock, just in case
>> we happen to be running preemptibly there.
>>
>> Zach, Matt: please review, test and ack asap?
>>   
> 
> Ok, that was subtle.  It took me 10 minutes staring at this code to
> notice the extra __pa and __va in the load_gdt call.  Actually, by sheer
> coincidence, the first one was actually still correct.  Normally, this
> code would just totally blow up, but you've just identity mapped virtual
> and physical addresses.  The second one will blow up after the EFI call
> without the fix.
> 
> Unfortunately, I can't test EFI; I have no machines here that are EFI
> capable.
> 
> This code has always confused me, though.  Why do we do this crazy hack
> to begin with?  The crazy hack is not remapping the GDT in physical
> space, or simulating non-paging memory with paging enabled - that is
> completely normal.  But why do we muck with the GDT for CPU zero instead
> of the current CPU?  If the EFI code decides to reload FS or GS, we have
> now leaked the user FS or GS from CPU zero onto the current CPU, and I
> see no code here which restricts EFI to run on the BSP.  This will break
> userspace TLS programs.  Of course, I have no evidence that EFI will
> reload FS or GS, but it must be doing something with segmentation, or
> you would not have needed to reload the GDT.
> 
> Second, there is another bug in this code as well.  Why do we care if
> PSE is enabled when identity mapping virtual to physical space?  PSE has
> _nothing_ to do with this.  You are copying top level page ranges, which
> are the same size, with or without PSE.  We should be checking if PAE is
> enabled, and we shouldn't even need to check, since it will either be
> compiled in or not.  This code is scarily just quite lucky that the
> kernel is small enough to fit.
> 
> For PAE mode, PSE is always going to be enabled (I believe), so you end
> up remapping 1GB of virtual space into physical space.  For non-PAE, PSE
> may or may not be enabled, in which case, you end up remapping either
> 4MB or 8MB of the kernel virtual address space back at zero.
> 
> I don't believe 4MB is enough to make sure all of the per-cpu variables
> can be safely referenced, although I could be wrong.  So if there are
> EFI machines out there with processors installed that have no PSE
> support, and the kernel gets large enough, this code blows up again.  I
> actually think that is quite likely as EFI becomes more prevalent and
> older core processors continue to be made for the embedded market.
> 
> Zach
> 

