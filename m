Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264300AbRFGDgf>; Wed, 6 Jun 2001 23:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264306AbRFGDgZ>; Wed, 6 Jun 2001 23:36:25 -0400
Received: from mailout2-0.nyroc.rr.com ([24.92.226.121]:21671 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S264300AbRFGDgO>; Wed, 6 Jun 2001 23:36:14 -0400
Message-ID: <044a01c0ef04$61559440$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.fk487iv.1d2ksb0@ifi.uio.no> <fa.f3ckgov.ti0mb3@ifi.uio.no>
Subject: Re: forcibly unmap pages in driver?
Date: Wed, 6 Jun 2001 23:46:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an update to my situation... I've implemented my idea of clearing the
associated PTE's when I need to free the DMA buffer, then re-filling them in
nopage(). This seems to work fine; if the user process tries anything fishy,
it gets a SIGBUS instead of accessing the old mapping.

I encountered two difficulties with the implementation:

1) zap_page_range(), flush_cache_range(), and flush_tlb_range() are not
exported to drivers. I basically copied the guts of zap_page_range() into my
driver, which seems to work OK on x86, but I know it will have trouble with
architectures that require special treatment of PTE manipulation...

2) the state of mm->mmap_sem is unknown when my file_operations->release()
function is called. If release() is called when the last FD closes, then
mm->mmap_sem is not taken. But if release() is called from do_munmap, then
mmap_sem has already been taken. So, it is risky to mess with vma's inside
of release()...

Regards,
Dan

> >> Later, the program calls the ioctl() again to set a smaller
> >> buffer size, or closes the file descriptor. At this point
> >> I'd like to shrink the buffer or free it completely. But I
> >> can't assume that the program will be nice and munmap() the
> >> region for me
>
> > Look at drivers/char/drm, for example.  At mmap time they allocate a
> > vm_ops to the address space.  With that you catch changes to the vma
> > structure initiated by a user mmap, munmap, etc.  You could also
> > dynamically map the pages in using the nopage method (optional).

