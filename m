Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSJCBhR>; Wed, 2 Oct 2002 21:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbSJCBhR>; Wed, 2 Oct 2002 21:37:17 -0400
Received: from packet.digeo.com ([12.110.80.53]:56733 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261544AbSJCBhQ>;
	Wed, 2 Oct 2002 21:37:16 -0400
Message-ID: <3D9BA086.76B60194@digeo.com>
Date: Wed, 02 Oct 2002 18:42:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.5.40, flush_tlb_mm
References: <Pine.LNX.4.44.0210021957140.14293-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2002 01:42:34.0949 (UTC) FILETIME=[25A06F50:01C26A7E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> Hi,
>         Please keep my CC on any replies (i'm currently experiencing
> DNS problems and hence do not get lkml)
> 
> Dorking around in mozilla did this, the machine had completely locked up
> so this was from the serial;
> 
> Unable to handle kernel paging request at virtual address 5a5a5ad6
>  printing eip:
> c0115f2f
> *pde = 00000000
> Oops: 0000
> 
> CPU:    0
> EIP:    0060:[<c0115f2f>]    Not tainted
> EFLAGS: 00010202
> EIP is at flush_tlb_mm+0x1f/0x90
> eax: c1ce01a0   ebx: 5a5a5a5a   ecx: 00000000   edx: fffffffe
> esi: 00400000   edi: c759d418   ebp: 00100000   esp: c2749f04
> ds: 0068   es: 0068   ss: 0068
> Process mozilla-bin (pid: 1396, threadinfo=c2748000 task=c1ce01a0)
> Stack: c759d418 c01418ab 5a5a5a5a c759d418 c142d810 c0141a1a c142d810 c195263c
>        c012c577 00000001 00000000 c1ce01a0 41500000 00100073 00000002 c195263c
>        c0141c62 c195263c 41800000 41500000 00000025 00000025 c2fda834 00000073
> Call Trace:
>  [<c01418ab>]change_protection+0x1bb/0x210
>  [<c0141a1a>]mprotect_attempt_merge+0x11a/0x1d0
>  [<c012c577>]update_process_times+0x27/0x30
>  [<c0141c62>]mprotect_fixup+0x192/0x1b0
>  [<c0141de7>]sys_mprotect+0x167/0x2f0
>  [<c010bd67>]do_IRQ+0x1e7/0x200
>  [<c0109477>]syscall_call+0x7/0xb

You need Hugh's patch.  Was sent to Linus yesterday...



Patch from Hugh Dickins

Our earlier fix for mprotect_fixup was broken - passing an
already-freed VMA to change_protection().



 mm/mprotect.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- 2.5.40/mm/mprotect.c~hugh-mprotect-fix	Tue Oct  1 23:43:14 2002
+++ 2.5.40-akpm/mm/mprotect.c	Tue Oct  1 23:43:14 2002
@@ -186,8 +186,10 @@ mprotect_fixup(struct vm_area_struct *vm
 		/*
 		 * Try to merge with the previous vma.
 		 */
-		if (mprotect_attempt_merge(vma, *pprev, end, newflags))
+		if (mprotect_attempt_merge(vma, *pprev, end, newflags)) {
+			vma = *pprev;
 			goto success;
+		}
 	} else {
 		error = split_vma(mm, vma, start, 1);
 		if (error)

.
