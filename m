Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290824AbSBFVtY>; Wed, 6 Feb 2002 16:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290825AbSBFVtP>; Wed, 6 Feb 2002 16:49:15 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:55693 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S290824AbSBFVtE>; Wed, 6 Feb 2002 16:49:04 -0500
Importance: Normal
Subject: Re: The IBM order relaxation patch
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF5FF19417.595BC760-ONC1256B58.00762715@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Wed, 6 Feb 2002 22:50:29 +0100
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 06/02/2002 22:50:32
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> This patch is very s/390 specific and breaks all other architectures.
>  <<they meant "zSeries specific", surely --zaitcev>>

B.t.w. Martin found a way to make the patch less intrusive so
that it won't break other archs any more ...

>It's a stupid question, but: why can we not simply
>wait until a desired unfragmented memory area is available,
>with a GPF flag? What they describe does not happen in an
>interrupt context, so we can sleep.

Because nobody even *tries* to free adjacent pages to build up
a free order-2 area.  You could wait really long ...

This looks hard to fix with the current mm layer.  Maybe Rik's
rmap method could help here, because with reverse mappings we
can at least try to free adjacent areas (because we then at least
*know* who's using the pages).

>And another one: why not to increase a kernel-visible or "soft"
>page size to 16KB for zSeries? It's a 64 bits platform. There
>will be some increase in fragmentation, but nobody measured it.
>Perhaps it's not going to be severe. It may even improve paging
>efficiency.

Because then we can mmap() to user space only on 16KB boundaries.
This is a problem in particular for the 31-bit emulation layer,
as 31-bit binaries are laid out on 4KB boundaries by the linker,
so you really need to be able to mmap() on 4KB boundaries.

One way to fix this could be to allow user space mappings on a
different granularity than the 'page size' for the allocator.
(Is this what PAGE_SIZE vs. PAGE_CACHE_SIZE had been intended
for, maybe?  It doesn't work at the moment in any case.)


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

