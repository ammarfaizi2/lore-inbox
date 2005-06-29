Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVF2RgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVF2RgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVF2Rdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:33:36 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:11272 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262292AbVF2RV2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:21:28 -0400
X-IronPort-AV: i="3.94,150,1118034000"; 
   d="scan'208"; a="279629428:sNHT106745784"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Wed, 29 Jun 2005 12:20:53 -0500
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B4074345@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcV5LZSvZcDXcMWnSP+dBB5CHpL4AAC8JMigACuTd4A=
From: <Stuart_Hayes@Dell.com>
To: <Stuart_Hayes@Dell.com>, <ak@suse.de>
Cc: <riel@redhat.com>, <andrea@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jun 2005 17:20:54.0401 (UTC) FILETIME=[E7CD0F10:01C57CCE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 
>> That should be already fixed.
> 
> It doesn't appear to be fixed (in the i386 arch).  The
> change_page_attr()/split_large_page() code will still still set all
> the 4K PTEs to PAGE_KERNEL (setting the _PAGE_NX bit) when a large
> page needs to be split.   
> 
> This wouldn't be a problem for the bulk of the kernel memory, but
> there are pages in the lower 4MB of memory that's free, and are part
> of large executable pages that also contain kernel code.  If
> change_page_attr() is called on these, it will set the _PAGE_NX bit
> on the whole 2MB region that was covered by the large page, causing a
> large chunk of kernel code to be non-executable.     
> 
> I can only think of a few ways to fix this:
> 
> (1) Make sure that any free pages that share a large-page-aligned
> area with kernel code are not executable.  This would cause a big
> part of the kernel code to be in small pages, which might have an
> effect on performance.   
> 
> (2) Make sure that there aren't any free pages in the
> large-page-aligned areas that contain kernel executable code, by
> reserving it somehow.  This seems kind of wasteful of
> memory--ZONE_DMA memory, at that.   
> 
> or (3) Allow the free pages in the 2MB large pages that also contain
> kernel code to be executable, but somehow fix change_page_attr() so
> it doesn't set the _PAGE_NX bit on the whole 2MB large page region
> when called.  This would require one of the changes that I suggested
> earlier, like ignoring the NX bit in the "prot" that's passed to
> change_page_attr(), or just accepting the fact that calling
> change_page_attr() on a large executable page will not be reverted
> back to a large page if the calling function uses
> change_page_attr(page,PAGE_KERNEL) when it is done.  Or changing the
> interface, so that there's a change_page_attr() and an
> unchange_page_attr() that automatically reverts the page back to
> whatever the previous attributes were.           
> 
> Am I missing something?
> 

(Fixed Andrea's email address)

This is definitely broken in 2.6.12.  I wrote a test module that does
__get_free_pages(GFP_DMA,0) until it sees that the page it gets is
executable (it got about 30 pages before it got one that's executable),
and then it does a change_page_attr(page,PAGE_KERNEL_NOCACHE) on the
page.  Shortly thereafter the system reboots--presumably it got a triple
fault because the exception handler was no longer executable, or
something like that.

My personal opinion of the best way to fix this would be option 3
above--just rewrite change_page_attr() so that the 511 other little
pages that are created inheret the _PAGE_NX bit from the large page that
was split--but make sure that it doesn't revert these PTEs back into a
large page if change_page_attr(page,PAGE_KERNEL) is called, since the
other pages in this 2MB area aren't PAGE_KERNEL.

Option 1 seems more correct to me, but not necessarily worth the
performance cost.

What do you think?

