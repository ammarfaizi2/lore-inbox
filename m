Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWDZQqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWDZQqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDZQqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:46:31 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:14996 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750768AbWDZQqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:46:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SS3uPAYqAu7fvNq8Qltn669BTol0JO73SfPaoSFpL1uPTkrCBboCItddWaBy3DfE+PiG+CM3d1VBeZcxATyYZdVMNzFh/dsIJLCol12F9Jj2ptQh4SS8TcRbCUH+09w96sTanKrToHhriQjz129nZdU41xKeaZgdF9fB9biFvf0=  ;
Message-ID: <444F4B0B.20609@yahoo.com.au>
Date: Wed, 26 Apr 2006 20:27:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Abu-Nassar <djanssen1@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Using remap_pfn_range causes system hang on app close in 2.6.15
 & up
References: <BAY101-F118C89513BC38408E90CDAF4BF0@phx.gbl>
In-Reply-To: <BAY101-F118C89513BC38408E90CDAF4BF0@phx.gbl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Abu-Nassar wrote:
> Hello,
> 
> I posted this query a couple of weeks ago regarding a problem with 
> remap_pfn_range.  I was able to resolve the issue and I thought I would 
> post my findings in case it helps someone else or results in a kernel 
> fix.  I will try to keep this short.
> 
> In a nutshell, my driver support user APIs that maps system RAM or a PCI 
> BAR space to user space.  What I did not mention in my original post is 
> that my driver performed a sort of custom protocol when mmap() is 
> called.  Since mmap() really only provides a limited amount of space 
> (the offset field) that I can use to pass additional information to my 
> driver, I had implemented a custom protocol, which works as follows:
> 
> 1.  API calls mmap to obtain a user virtual address
> 2.  Drivers mmap routine stores the VMA in an internal list and returns ok.
> 3.  API then issues a custom IOCTL to driver to complete mapping with 
> additional info
> 4.  Driver retrieves VMA from internal list and performs mapping with 
> io/remap_pfn_range, depending upon whether it's to system RAM or a PCI BAR.
> 
> The mappings always work fine, but starting with 2.6.15, the system 
> freeezes when the file descriptor is closed.  I tried numerous tests and 
> compared my code with existing drivers, such as /dev/mem.  Here is what 
> I found:
> 
> The fix involved moving my calls to io/remap_pfn_range into my 
> Dispatch_mmap() routine.  Once I did this, the system no longer 
> crashed.  I still implement sending some custom information to the 
> driver, but now I use special values in the offset field, remembering 
> that the offset is eventually shifted by PAGE_SIZE by the time it 
> reaches the driver.  My driver code essentially did not change.  In 
> effect, all I really did was move it to the driver's mmap() routine.
> 
> I should mention that my original protocol has worked fine in kernels 
> 2.2, 2.4, and up to 2.6.14.  Some change to the VM subsystem in 2.6.15 
> broke my original code.  I don't believe there should be an issue with 
> calling remap_pfn_range outside of the driver's mmap() routine, but I am 
> not a kernel developer, so I could be wrong in my assumption.  One of my 
> customers posed this question to Nick Piggin, and he seemed to think 
> there should not be a problem with this.

Well, I think I said it shouldn't oops like this... I don't think it
is particularly robust WRT error cases or concurrent page faults
(between mmap and ioctl).

As we established earlier with a debug patch, the reason for the oops
is that VM_PFNMAP has been cleared from your vma->vm_flags for some
reason. This is causing the unmap code to mistakenly try to remove
reverse maps and refcounts from the struct pages.

I don't know why VM_PFNMAP should be getting cleared. But if it
remains set then the oops should go away.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
