Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVKQXhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVKQXhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVKQXhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:37:38 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35296
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965119AbVKQXhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:37:37 -0500
Date: Thu, 17 Nov 2005 15:36:52 -0800 (PST)
Message-Id: <20051117.153652.07424965.davem@davemloft.net>
To: hugh@veritas.com
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] unpaged: private write VM_RESERVED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0511171929210.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511171929210.4563@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Thu, 17 Nov 2005 19:30:04 +0000 (GMT)

> The PageReserved removal in 2.6.15-rc1 issued a "deprecated" message
> when you tried to mmap or mprotect MAP_PRIVATE PROT_WRITE a VM_RESERVED,
> and failed with -EACCES: because do_wp_page lacks the refinement to COW
> pages in those areas, nor do we expect to find anonymous pages in them;
> and it seemed just bloat to add code for handling such a peculiar case.
> But immediately it caused vbetool and ddcprobe (using lrmi) to fail.
> 
> So revert the "deprecated" messages, letting mmap and mprotect succeed.
> But leave do_wp_page's BUG_ON(vma->vm_flags & VM_RESERVED) in place
> until we've added the code to do it right: so this particular patch is
> only good if the app doesn't really need to write to that private area.
> 
> Dave Jones has changed vbetool & ddcprobe to use MAP_SHARED or PROT_READ
> just as well, but we don't want to force people to update their tools.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

lrmi makes two mmaps of interest on "/dev/mem":

1) the lowest page, which includes the interrupt vectors and
   the BIOS data area

   the BIOS code it executes does need to write to that BIOS
   data area, so PROT_WRITE is necessary, but more on this...

2) the ROM image from 0xa0000 -> 0x100000, no PROT_WRITE necessary

But the thing about #1, which needs the PROT_WRITE, is that it does
not want anonymous pages for that stuff, it's mapping the real
physical memory at those addresses, and indeed /dev/mem is going to
setup all the damn page tables already regardless of whether
MAP_SHARED or MAP_PRIVATE is set, and logically indeed MAP_SHARED is
the thing which should be specified here because this mapping is
not "private" to the application in any sense.

That is, /dev/mem mmap()'s do the remap_pfn_range() for the whole area
being mmap()'d (which is where the VM_RESERVED comes from), and
therefore no COW page faults should ever occur for such areas.  Faults
can occur for protection violations or memory errors, but that's it.

I would even argue that MAP_PRIVATE on things like /dev/mem should be
flagged with at least a kernel log message if not an outright -EINVAL
as well.
