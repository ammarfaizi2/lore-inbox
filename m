Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281707AbRLOCLR>; Fri, 14 Dec 2001 21:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281717AbRLOCLI>; Fri, 14 Dec 2001 21:11:08 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:28867 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S281707AbRLOCK6>; Fri, 14 Dec 2001 21:10:58 -0500
Message-ID: <C8C7DD4157F2D411AC7000A0C96B1522016C37D8@fmsmsx58.fm.intel.com>
From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
To: "'Benjamin LaHaise'" <bcrl@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: zap_page_range in a module
Date: Fri, 14 Dec 2001 18:10:52 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, Dec 14, 2001 at 01:26:29PM -0800, Sottek, Matthew J wrote:
>> currently can only work when compiled into the kernel because I need 
>> zap_page_rage(). Is there an acceptable way for me to get equivalent
>> functionality in a module so that this will be more useful to the
>> general public?

>The vm does zap_page_range for you if you're implementing an
>mmap operation, 

It only does zap_page_range() when the memory map is being
removed right?

>otherwise vmalloc/vfree/vremap will take care of the details for
>you.  How is your code using zap_page_range?  It really shouldn't be.

I will try to explain in it again in another way.

I have a 64k sliding "window" into a 1MB region. You can only access
64k at a time then you have to switch the "bank" to access the next
64k. Address 0xa0000-0xaffff is the 64k window. The actual 1MB of
memory is above the top of memory and not directly addressable by the
CPU, you have to go through the banks.

My driver implements the mmap file operation and does NOT do a
remap_page_range(). I also install a zero_page fault handler.

The client application then memory maps a 1MB region on the device
file. When the client tries to access the first page, my fault
handler is called and I remap_page_range() the 64k window
and set the hardware such that the first 64k of memory is what
can be viewed through the window.

When the client gets to 64k + 1 my fault handler is triggered again.
At this time I change the window to view the second 64k and do
another remap_page_range() of the window to the second 64k in the
vma.  HERE is the problem. I need to get rid of the area so that
when the client reads from the first page my fault handler is
triggered again. zap_page_range() works, but only from within the
kernel.

This seems like something that would have lots of uses, so I assume
there is a way to do it that I just haven't discovered.
Is there no driver doing something like this to give mutual exclusion
to a memory mapped resource?

-Matt

