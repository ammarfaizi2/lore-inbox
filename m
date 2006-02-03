Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWBCNxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWBCNxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWBCNxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:53:40 -0500
Received: from silver.veritas.com ([143.127.12.111]:41794 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750789AbWBCNxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:53:39 -0500
Date: Fri, 3 Feb 2006 13:54:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Badri Pillai <badri@ii-consult.com>
cc: Martin Drab <drab@kepler.fjfi.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM [ATI fglrx 2.6.15 put_page BUG]
In-Reply-To: <43E34662.1000704@ii-consult.com>
Message-ID: <Pine.LNX.4.61.0602031340350.11546@goblin.wat.veritas.com>
References: <43E34662.1000704@ii-consult.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Feb 2006 13:53:39.0173 (UTC) FILETIME=[3C4B1950:01C628C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Badri Pillai wrote:
> 
> Problem summary: after upgrading to from 2.6.15.1 -> 2.6.15.2
> the system dumps following trace, when trying to reboot through KDE 3.5:

I doubt it's anything new in 2.6.15.2.

> - ------------[ cut here ]------------
> kernel BUG at mm/swap.c:49!
> invalid operand: 0000 [#2]

That's #2 so there should have been an earlier one, but never mind...

> SMP
> Modules linked in: nls_utf8 ntfs snd_rtctimer ipv6 fglrx ....

ATI's fglrx is Tainting your kernel.

> EIP:    0060:[<c013fbce>]    Tainted: P    B VLI
> EFLAGS: 00013256   (2.6.15.2_DL6)

I don't know 2.6.15.2_DL6, but never mind...

> EIP is at put_page+0x4a/0x66
> Process X (pid: 1682, threadinfo=db55e000 task=c17fe570)

And further down...

>  [<c013fbce>] put_page+0x4a/0x66
>  [<c01ba078>] avc_has_perm_noaudit+0x37/0xe3
>  [<e1c93717>] drm_free+0xb7/0x150 [fglrx]
>  [<e1c93717>] drm_free+0xb7/0x150 [fglrx]
>  [<c0103273>] error_code+0x4f/0x54
>  [<e1c9007b>] FGLDRM__vm_info+0xa0/0x16b [fglrx]
>  [<e1c9007b>] FGLDRM__vm_info+0xa0/0x16b [fglrx]
>  [<c013fbce>] put_page+0x4a/0x66
>  [<c0143a8b>] zap_pte_range+0x172/0x236
>  [<c0143bf8>] unmap_page_range+0xa9/0xf8
>  [<c0143d48>] unmap_vmas+0x101/0x1e2
>  [<c0147606>] unmap_region+0x92/0xf8
>  [<c0147877>] do_munmap+0xd9/0xef
>  [<c01478dd>] sys_munmap+0x50/0x68
>  [<c0102717>] sysenter_past_esp+0x54/0x75

Yes, fglrx definitely looks implicated.  ATI were carefully coding
around an anomaly in our page count handling, then 2.6.15 removed
that anomaly, so their wrapper code needs an additional #ifdef on
Linux kernel version.  I'll forward you offline what Martin Drab
posted a few weeks back.

Hugh
