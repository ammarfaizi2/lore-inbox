Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVAQF0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVAQF0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 00:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVAQF0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 00:26:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:50580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262694AbVAQF0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 00:26:10 -0500
Date: Sun, 16 Jan 2005 21:25:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Caputo <ccaputo@alt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bdev_lock deadlock in 2.6.10-ac8 / e1000 / rfc2385 patch
Message-Id: <20050116212549.0decf159.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0501161644490.22840-100000@nacho.alt.net>
References: <Pine.LNX.4.44.0412171503510.22212-100000@nacho.alt.net>
	<Pine.LNX.4.44.0501161644490.22840-100000@nacho.alt.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Caputo <ccaputo@alt.net> wrote:
>
> I've been seeing bdev_lock based deadlock's since 2.6.9.  Here's a latest
>  one with 2.6.10-ac8.  Not sure if the problem is related to the e1000
>  driver (with NAPI) or the rfc2385 patches or what.  Anyone else seeing
>  this?
> 
>  Chris
> 
>  --
>  2.6.10-ac8 + rfc2385 md5 patch:
> 
>  <Jan/16 10:55 pm>SysRq : Show Regs
>  <Jan/16 10:55 pm>Pid: 820, comm:                   sh
>  <Jan/16 10:55 pm>EIP: 0060:[<c0309276>] CPU: 0
>  <Jan/16 10:55 pm>EIP is at _spin_lock+0x36/0x90
>  <Jan/16 10:55 pm> EFLAGS: 00000246    Not tainted  (2.6.10-ac8)
>  <Jan/16 10:55 pm>EAX: 00000000 EBX: 00000000 ECX: c0355300 EDX: c0414000
>  <Jan/16 10:55 pm>ESI: c03a1600 EDI: ffffffff EBP: c0414fc4 DS: 007b ES: 007b
>  <Jan/16 10:55 pm>CR0: 8005003b CR2: b7fd6f68 CR3: 02463000 CR4: 000006d0
> 
>  >>EIP; c0309276 <_spin_lock+36/90>   <=====
> 
>  >>ECX; c0355300 <contig_page_data+0/e00>
>  >>EDX; c0414000 <softirq_stack+0/4000>
>  >>ESI; c03a1600 <bdev_lock+0/80>
>  >>EDI; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>  >>EBP; c0414fc4 <softirq_stack+fc4/4000>
> 
>  <Jan/16 10:55 pm> [<c02dc0f0>] defense_timer_handler+0x0/0x40
>  <Jan/16 10:55 pm> [<c015bbed>] nr_blockdev_pages+0xd/0x60
>  <Jan/16 10:55 pm>
>  <Jan/16 10:55 pm> [<c013a601>] si_meminfo+0x21/0x40
>  <Jan/16 10:55 pm> [<c02dbe97>] update_defense_level+0x17/0x270

You should be able to fix this with

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/broken-out/cancel_rearming_delayed_work.patch

and

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/broken-out/ipvs-deadlock-fix.patch

I haven't pushed these along because I'm not very happy with the
cancel_rearming_delayed_work.patch concept.

But I forget why ;) It seems a bit livelocky.  Let me think about it a bit
more.
