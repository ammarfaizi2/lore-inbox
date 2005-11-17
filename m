Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVKQUqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVKQUqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVKQUqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:46:19 -0500
Received: from isilmar.linta.de ([213.239.214.66]:24743 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S964853AbVKQUqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:46:18 -0500
Date: Thu, 17 Nov 2005 21:46:17 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] unpaged: private write VM_RESERVED
Message-ID: <20051117204617.GA10925@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com> <Pine.LNX.4.61.0511171929210.4563@goblin.wat.veritas.com> <20051117194102.GE5772@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117194102.GE5772@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Nov 17, 2005 at 02:41:02PM -0500, Dave Jones wrote:
> On Thu, Nov 17, 2005 at 07:30:04PM +0000, Hugh Dickins wrote:
>  > The PageReserved removal in 2.6.15-rc1 issued a "deprecated" message
>  > when you tried to mmap or mprotect MAP_PRIVATE PROT_WRITE a VM_RESERVED,
>  > and failed with -EACCES: because do_wp_page lacks the refinement to COW
>  > pages in those areas, nor do we expect to find anonymous pages in them;
>  > and it seemed just bloat to add code for handling such a peculiar case.
>  > But immediately it caused vbetool and ddcprobe (using lrmi) to fail.
>  > 
>  > So revert the "deprecated" messages, letting mmap and mprotect succeed.
>  > But leave do_wp_page's BUG_ON(vma->vm_flags & VM_RESERVED) in place
>  > until we've added the code to do it right: so this particular patch is
>  > only good if the app doesn't really need to write to that private area.
>  > 
>  > Dave Jones has changed vbetool & ddcprobe to use MAP_SHARED or PROT_READ
>  > just as well, but we don't want to force people to update their tools.
> 
> Actually Dave Miller did the detective work on that one, I just
> rebuilt some packages, and spread the good word :)

My Samsung X05 requires vbetool to resume from suspend-to-ram properly. Up
to 2.6.14, vbetool-0.3 worked fine; the PageReserved patch broke this (as
reported). Also the new package by Dave {Miller,Jones} didn't help and does
not help, even with these new 11 patches. Using the unmodified, original
vbetool-0.3, though, does work as expected, and I can resume back into X
again.

kernel			vbetool-0.3	vbetool-0.3+lrmi-patch
--------------------------------------------------------------
2.6.14			+		?
2.6.15-rc1		-		-
2.6.15-rc1+patches	+		-



However -- and this is the first time I'm experiencing this bug, I now got
this in my dmesg right after the last resume from sleep.


[4294994.302000] Restarting tasks... done
[4295188.230000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb020)
[4295188.230000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[4295188.230000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[4295188.230000] Backtrace:
[4295188.230000]  [<c0103b59>] dump_stack+0x15/0x17
[4295188.230000]  [<c0138f99>] bad_page+0x5b/0x92
[4295188.230000]  [<c013967b>] free_hot_cold_page+0x5c/0xfe
[4295188.230000]  [<c0139727>] free_hot_page+0xa/0xc
[4295188.230000]  [<c013eff0>] __page_cache_release+0x8f/0x94
[4295188.230000]  [<c013ecd3>] put_page+0x5b/0x5d
[4295188.230000]  [<c0148d69>] free_page_and_swap_cache+0x2c/0x2f
[4295188.230000]  [<c0142609>] zap_pte_range+0x1a1/0x214
[4295188.230000]  [<c014271a>] unmap_page_range+0x9e/0xe8
[4295188.230000]  [<c0142827>] unmap_vmas+0xc3/0x199
[4295188.230000]  [<c0145cf7>] unmap_region+0x77/0xf2
[4295188.230000]  [<c0145f91>] do_munmap+0xdd/0xf3
[4295188.230000]  [<c0145ff6>] sys_munmap+0x4f/0x68
[4295188.230000]  [<c0102cab>] sysenter_past_esp+0x54/0x75
[4295188.230000] Trying to fix it up, but a reboot is needed
[4295188.230000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb040)
[4295188.230000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[4295188.230000] Backtrace:
[4295188.230000]  [<c0103b59>] dump_stack+0x15/0x17
[4295188.230000]  [<c0138f99>] bad_page+0x5b/0x92
[4295188.230000]  [<c013967b>] free_hot_cold_page+0x5c/0xfe
[4295188.230000]  [<c0139727>] free_hot_page+0xa/0xc
[4295188.230000]  [<c013eff0>] __page_cache_release+0x8f/0x94
[4295188.230000]  [<c013ecd3>] put_page+0x5b/0x5d
[4295188.230000]  [<c0148d69>] free_page_and_swap_cache+0x2c/0x2f
[4295188.230000]  [<c0142609>] zap_pte_range+0x1a1/0x214
[4295188.230000]  [<c014271a>] unmap_page_range+0x9e/0xe8
[4295188.230000]  [<c0142827>] unmap_vmas+0xc3/0x199
[4295188.230000]  [<c0145cf7>] unmap_region+0x77/0xf2
[4295188.230000]  [<c0145f91>] do_munmap+0xdd/0xf3
[4295188.230000]  [<c0145ff6>] sys_munmap+0x4f/0x68
[4295188.230000]  [<c0102cab>] sysenter_past_esp+0x54/0x75
[4295188.230000] Trying to fix it up, but a reboot is needed
[4295188.230000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb060)
[4295188.230000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[4295188.230000] Backtrace:
[4295188.230000]  [<c0103b59>] dump_stack+0x15/0x17
[4295188.230000]  [<c0138f99>] bad_page+0x5b/0x92
[4295188.230000]  [<c013967b>] free_hot_cold_page+0x5c/0xfe
[4295188.230000]  [<c0139727>] free_hot_page+0xa/0xc
[4295188.230000]  [<c013eff0>] __page_cache_release+0x8f/0x94
[4295188.231000]  [<c013ecd3>] put_page+0x5b/0x5d

... and so on. Don't know whether this is related... and it isn't
reproducible.


	Dominik
