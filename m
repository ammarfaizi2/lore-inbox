Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWJVNUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWJVNUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 09:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWJVNUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 09:20:47 -0400
Received: from mx1.suse.de ([195.135.220.2]:43220 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750778AbWJVNUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 09:20:46 -0400
From: Andi Kleen <ak@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4 (updated) II
Date: Sun, 22 Oct 2006 15:19:20 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <45397D22.4030200@shaw.ca> <p73ejt1m5gj.fsf_-_@verdi.suse.de> <453B1946.3070201@shaw.ca>
In-Reply-To: <453B1946.3070201@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610221519.20721.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 09:09, Robert Hancock wrote:
> Andi Kleen wrote:
> > Andi Kleen <ak@suse.de> writes:
> > 
> >> I tested it on a NF4-Professional system with 8GB RAM and a single 
> >> SATA disk. It first did nicely in LTP and some other tests,
> >> but during a bonnie++ run it eventually blocked with all
> >> IO hanging forever. No output either. I did a full backtrace
> >> and it just showed the processes waiting for a IO wakeup.
> > 
> > Hmm, to follow myself up: after a few more minutes the machine recovered
> > and i could log in again (overall the stall was at least 5+ minutes
> > though)
> > 
> > Not sure whom to blame, the IO driver might be actually innocent
> > and it just be one of the usual known but unfixed IO starvation problems.
> > 
> > -Andi
> 
> Hmm.. The system hanging up for 5 minutes 

I've actually seen that before on different systems. Sometimes
under some IO loads writes can be really starved for that long
and they block the calling process. Normally it only happened
when a very slow IO device (like slow USB storage) was involved

e.g. typical trace:

sshd          D ffff810001072b20     0 11554   3381         11556 11127 (NOTLB)
 ffff810114dffb08 0000000000000086 5353535353535353 5353535353535353
 5353535353535353 000000000000057e ffff81014b344af0 ffff81014b404770
 000001ede41c7140 ffff81014b344cc8 5353535300000001 5353535353535353
Call Trace:
 [<ffffffff802e8cc2>] start_this_handle+0x2f4/0x37b
 [<ffffffff802e8e16>] journal_start+0xcd/0x105
 [<ffff81014b11e800>]
DWARF2 unwinder stuck at 0xffff81014b11e800
Leftover inexact backtrace:
 [<ffffffff802da5f5>] ext3_dirty_inode+0x28/0x7b
 [<ffffffff80291bbb>] __mark_inode_dirty+0x2c/0x17d
 [<ffffffff80256611>] do_generic_mapping_read+0x3b0/0x3c2
 [<ffffffff80255415>] file_read_actor+0x0/0xd6
 [<ffffffff80256d8b>] generic_file_aio_read+0x164/0x1b8
 [<ffffffff80278774>] do_sync_read+0xc9/0x10c
 [<ffffffff80241ecc>] autoremove_wake_function+0x0/0x2e
 [<ffffffff80531aef>] cond_resched+0x34/0x3b
 [<ffffffff80258f27>] __alloc_pages+0x5e/0x2ae
 [<ffffffff8027365a>] cache_alloc_refill+0xf1/0x1f8
 [<ffffffff80278ade>] vfs_read+0xa8/0x14e
 [<ffffffff8027bbbd>] kernel_read+0x38/0x4c
 [<ffffffff8027d6d4>] do_execve+0x105/0x1f9
 [<ffffffff80207bc9>] sys_execve+0x33/0x8b
 [<ffffffff80209857>] stub_execve+0x67/0xb0


I've got quite a lot of processes in journal_start -> start_this_handle.
I suppose they're waiting for the transaction to finish.

> and then recovering seems  
> rather odd, as far as I know the timeouts in libata are all quite a bit 
> shorter than that. Was there anything unusual in dmesg? 

Nothing in dmesg except for the sysrqs I triggered.

> If the IO  
> commands weren't completing at the driver level then I would expect the 
> error handling to kick in in some fashion..

And print something, yes.

I assume it wasn't the driver for now.

Thanks for your work.

-Andi

 
