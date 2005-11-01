Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVKAPG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVKAPG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVKAPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:06:28 -0500
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:6581 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750841AbVKAPG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:06:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=IHBIOskHxOoIzd4Z+lU6nLmLqSAvHD0D0gpsrJEi8kKV/xPZDJyWVw+qPO6/bpdWo6gCDYGUVvKT6gyEKqC+2E7y+v6NPNfMwiqaTQ86fujf85m8MYF/MMcdZ74cJzNADdmBKfZlDI+FBkXovoNk5q8QLU7CcggQkofVv7tPc0s=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 9/10] UML - Big memory fixes
Date: Tue, 1 Nov 2005 16:11:04 +0100
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200510310439.j9V4dgqP000878@ccure.user-mode-linux.org>
In-Reply-To: <200510310439.j9V4dgqP000878@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511011611.09532.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 05:39, Jeff Dike wrote:
> A number of fixes to improve behavior when large physical memory sizes
> are specified:
>     libc files need -D_FILE_OFFSET_BITS=64 because there are unavoidable
> uses of non-64 interfaces in libc
>     some %d need to be %u
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Jeff, please always make patch and ChangeLog match. Yes, it matters - when it 
doesn't happen there's always something bad going on.

> Index: linux-2.6.14/arch/um/kernel/mem.c
> ===================================================================
> --- linux-2.6.14.orig/arch/um/kernel/mem.c	2005-10-28 12:58:12.000000000
> -0400 +++ linux-2.6.14/arch/um/kernel/mem.c	2005-10-30 19:29:04.000000000
> -0500 @@ -235,7 +235,7 @@ void paging_init(void)
>  	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++)
>  		zones_size[i] = 0;
>  	zones_size[0] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
> -	zones_size[2] = highmem >> PAGE_SHIFT;
> +	zones_size[3] = highmem >> PAGE_SHIFT;
>  	free_area_init(zones_size);

What's this? It's IMHO invalid. free_area_init() intereprets these values with 
include/linux/mmzone.h: ZONE_* constants.

Why those are not used here it's a nice question.

I think this came up because there's (in -mm) Andi Kleen created a new zone 
(ZONE_DMA32) for devices using 32-bit only DMA - but it seems it's not in 
mainline).  (I don't know if that patch is in -mm actually, but I guess it 
from this patch content).

Actually, since MAX_NR_ZONES is 3, and we are assigning to zones_size[3],
we're corrupting data:

        unsigned long zones_size[MAX_NR_ZONES], vaddr;

Don't drop the patch however, I'm fixing all this up.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
