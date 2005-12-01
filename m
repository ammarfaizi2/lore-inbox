Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751729AbVLAVLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbVLAVLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbVLAVLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:11:21 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:65343 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1751728AbVLAVLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:11:20 -0500
Date: Thu, 1 Dec 2005 15:11:19 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
Message-ID: <20051201211119.GA11437@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org> <20051201121826.GF19694@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051201121826.GF19694@charite.de>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.13 
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 01 Dec 2005 21:11:20.0205 (UTC) FILETIME=[C6A693D0:01C5F6BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 01:18:27PM +0100, Ralf.Hildebrandt@charite.de wrote:
> * Linus Torvalds <torvalds@osdl.org>:
> 
> > [ Btw, some drivers will now complain loudly about their nasty mis-use of 
> >   page remapping, and that migh look scary, but it should all be good, and 
> >   we'd love to see the detailed output of dmesg on such machines. ]
> 
> Here's one - smite me for using the nvidia driver:
> 
> Xorg does an incomplete pfn remapping [<c013eb8c>] incomplete_pfn_remap+0x6b/0xca
>  [<f94fc956>] nv_kern_mmap+0x47d/0x4cb [nvidia]
>  [<c01415e1>] do_mmap_pgoff+0x3cf/0x6ee
>  [<c0107dea>] sys_mmap2+0x66/0xaf
>  [<c0102c25>] syscall_call+0x7/0xb

from looking at the new code, it looks like this is due to how we mmap
our dma pages. due to opengl using large (multiple megabyte) push
buffers, we allocate individual physically discontiguous pages, then
mmap them in one call. we end up iterating over all of the pages with
individual calls to remap_pfn_range.

it appears this new warning doesn't like that and will complain,
unless VM_INCOMPLETE is set. when, if ever, is it valid to set
VM_INCOMPLETE? I'm guessing that the answer is to rely on the nopage
handler to map these pages individually. but I'm not clear how
dropping back and forth between user/kernel mode for each page between
each call to remap_pfn_page would be more efficient than just calling
remap_pfn_page for each page while we're already in kernel space.

Thanks,
Terence

> 
> repeated 4 times.
> 
> -- 
> Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
> Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
> Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
> IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
