Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTLAOMD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 09:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTLAOMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 09:12:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56517 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263506AbTLAOL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 09:11:57 -0500
Date: Mon, 1 Dec 2003 15:11:44 +0100
From: Jens Axboe <axboe@suse.de>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
Message-ID: <20031201141144.GD12211@suse.de>
References: <3FCB4AFB.3090700@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCB4AFB.3090700@backtobasicsmgmt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01 2003, Kevin P. Fleming wrote:
> I've got a new system here with six SATA disks set up in a RAID-5 array 
> (no partition tables, using the whole disks). I then used LVM2 tools to 
> make the RAID array a physical volume, created a logical volume and 
> formatted that volume with an XFS filesystem.
> 
> Mounting the filesystem and copying over the 2.6 kernel source tree 
> produces this OOPS (and is pretty reproducable):
> 
> kernel BUG at fs/bio.c:177!

It's doing a put on an already freed bio, that's really bad.

> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c014db9a>]    Not tainted
> EFLAGS: 00010246
> EIP is at bio_put+0x2c/0x36
> eax: 00000000   ebx: f6221080   ecx: c1182180   edx: edcbf780
> esi: c577b998   edi: 00000002   ebp: edcbf780   esp: f78ffeb0
> ds: 007b   es: 007b   ss: 0068
> Process md0_raid5 (pid: 65, threadinfo=f78fe000 task=f7924080)
> Stack: c71e2640 c021d88d edcbf780 00000000 00000001 c1182180 00000009 
> 0001000
>        edcbf780 00000000 00000000 00000000 c014e2fc edcbf780 00000000 
> 00000000
>        f23a0ff0 f23a0ff0 edcbf7c0 c02ca51d edcbf780 00000000 00000000 
> 00000000
> Call Trace:
>  [<c021d88d>] bio_end_io_pagebuf+0x9a/0x138
>  [<c014e2fc>] bio_endio+0x59/0x7e
>  [<c02ca51d>] clone_endio+0x82/0xb5
>  [<c02c0dc3>] handle_stripe+0x8f2/0xec0
>  [<c02c17d1>] raid5d+0x71/0x105
>  [<c02c898c>] md_thread+0xde/0x15c
>  [<c011984b>] default_wake_function+0x0/0x12
>  [<c02c88ae>] md_thread+0x0/0x15c
>  [<c0107049>] kernel_thread_helper+0x5/0xb

Odds are it's a raid5 bug.

> Hardware is a 2.6CGHz P4, 1G of RAM (4G highmem enabled), SMP kernel but 
> no preemption. Kernel config is at:

Are you using ide or libata as the backing for the sata drives?

-- 
Jens Axboe

