Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWDZSsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWDZSsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWDZSsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:48:03 -0400
Received: from bay101-f13.bay101.hotmail.com ([64.4.56.23]:17477 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S964808AbWDZSsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:48:01 -0400
Message-ID: <BAY101-F13D9FEC07E274B8565DD3BF4BC0@phx.gbl>
X-Originating-IP: [67.107.31.65]
X-Originating-Email: [djanssen1@hotmail.com]
In-Reply-To: <444F4B0B.20609@yahoo.com.au>
From: "Sam Abu-Nassar" <djanssen1@hotmail.com>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org, karl.kiniger@med.ge.com
Subject: Re: Using remap_pfn_range causes system hang on app close in 2.6.15 & up
Date: Wed, 26 Apr 2006 18:47:59 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 26 Apr 2006 18:48:00.0669 (UTC) FILETIME=[F13D04D0:01C66961]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Sam Abu-Nassar wrote:
>>Hello,
>>
>>I posted this query a couple of weeks ago regarding a problem with 
>>remap_pfn_range.  I was able to resolve the issue and I thought I would 
>>post my findings in case it helps someone else or results in a kernel fix. 
>>  I will try to keep this short.
>>
>>In a nutshell, my driver support user APIs that maps system RAM or a PCI 
>>BAR space to user space.  What I did not mention in my original post is 
>>that my driver performed a sort of custom protocol when mmap() is called.  
>>Since mmap() really only provides a limited amount of space (the offset 
>>field) that I can use to pass additional information to my driver, I had 
>>implemented a custom protocol, which works as follows:
>>
>>1.  API calls mmap to obtain a user virtual address
>>2.  Drivers mmap routine stores the VMA in an internal list and returns 
>>ok.
>>3.  API then issues a custom IOCTL to driver to complete mapping with 
>>additional info
>>4.  Driver retrieves VMA from internal list and performs mapping with 
>>io/remap_pfn_range, depending upon whether it's to system RAM or a PCI 
>>BAR.
>>
>>The mappings always work fine, but starting with 2.6.15, the system 
>>freeezes when the file descriptor is closed.  I tried numerous tests and 
>>compared my code with existing drivers, such as /dev/mem.  Here is what I 
>>found:
>>
>>The fix involved moving my calls to io/remap_pfn_range into my 
>>Dispatch_mmap() routine.  Once I did this, the system no longer crashed.  
>>I still implement sending some custom information to the driver, but now I 
>>use special values in the offset field, remembering that the offset is 
>>eventually shifted by PAGE_SIZE by the time it reaches the driver.  My 
>>driver code essentially did not change.  In effect, all I really did was 
>>move it to the driver's mmap() routine.
>>
>>I should mention that my original protocol has worked fine in kernels 2.2, 
>>2.4, and up to 2.6.14.  Some change to the VM subsystem in 2.6.15 broke my 
>>original code.  I don't believe there should be an issue with calling 
>>remap_pfn_range outside of the driver's mmap() routine, but I am not a 
>>kernel developer, so I could be wrong in my assumption.  One of my 
>>customers posed this question to Nick Piggin, and he seemed to think there 
>>should not be a problem with this.
>
>Nick Piggin wrote:
>Well, I think I said it shouldn't oops like this... I don't think it
>is particularly robust WRT error cases or concurrent page faults
>(between mmap and ioctl).
>
>As we established earlier with a debug patch, the reason for the oops
>is that VM_PFNMAP has been cleared from your vma->vm_flags for some
>reason. This is causing the unmap code to mistakenly try to remove
>reverse maps and refcounts from the struct pages.
>
>I don't know why VM_PFNMAP should be getting cleared. But if it
>remains set then the oops should go away.


As one of my tests, I manually added the VM_PFNMAP flag before calling 
remap_pfn_range().  This did not resolve the issue.  Also, I checked the 
kernel source (vanilla Fedora Core 5) and VM_PFNMAP is always added inside 
remap_pfn_range() anyway, along with VM_IO & VM_RESERVED.

Note that the kernel oops I posted only happened rarely.  Most of the time, 
the system completely froze immediately when the file descriptor was closed 
and I didn't get any oops message.


