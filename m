Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVLLFH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVLLFH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 00:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVLLFHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 00:07:25 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28602
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751104AbVLLFHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 00:07:25 -0500
Date: Sun, 11 Dec 2005 21:07:52 -0800 (PST)
Message-Id: <20051211.210752.83944980.davem@davemloft.net>
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512110020050.4809@lai.local.lan>
References: <Pine.LNX.4.64.0512102350310.4739@lai.local.lan>
	<20051210.150034.67577008.davem@davemloft.net>
	<Pine.LNX.4.64.0512110020050.4809@lai.local.lan>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Sun, 11 Dec 2005 00:22:22 +0100 (CET)

> sbusfb_mmap: start[71800000] size[410000] off[4000000]
> sbusfb_mmap: page[0] map_size[2000]
> sbusfb_mmap: map_size is now 2000
> IO[X:6712]: 
> remap_pfn_range(s[71800000]e[71c10000],f[71800000],pfn[1fc0060],sz[2000],prot[80000000000006b0])
> sbusfb_mmap: page[2000] map_size[2000]
> sbusfb_mmap: map_size is now 2000
> IO[X:6712]: 
> remap_pfn_range(s[71800000]e[71c10000],f[71802000],pfn[1fc0060],sz[2000],prot[80000000000006b0])

This is the trace we needed.

That last line is impossible, the debugging of the last 3 lines shows
that:

1) "page" is equal to 0x2000
2) "map_size" is equal to 0x2000

Furthermore, the first line shows that:

3) "vma->vm_start" is 0x71800000

The io_remap_pfn_range() call in drivers/video/sbuslib.c is:

		r = io_remap_pfn_range(vma,
					vma->vm_start + page,
					MK_IOSPACE_PFN(iospace,
						map_offset >> PAGE_SHIFT),
					map_size,
					vma->vm_page_prot);

This means, it passes in "vma->vm_start + page" in as the start
address.

Yet the last line, printed by the tracing code in io_remap_pfn_range()
is getting 0x71800000, when it should be 0x71802000.

I strongly believe your kernel is being miscompiled by whatever
gcc is being used to build your kernels.
