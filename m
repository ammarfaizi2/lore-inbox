Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTESPAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 11:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTESPAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 11:00:34 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:24209 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S262497AbTESPAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 11:00:30 -0400
Date: Mon, 19 May 2003 17:13:12 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
Message-ID: <20030519151312.GN32559@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <200305191216.h4JCGONj015081@harpo.it.uu.se> <20030519123119.GA20385@Synopsys.COM> <20030519144130.GM32559@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519144130.GM32559@Synopsys.COM>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen, Mon, May 19, 2003 16:41:30 +0200:
> Alex Riesen, Mon, May 19, 2003 14:31:19 +0200:
> > > >EIP is at fix_processor_context+0x5f/0x100
> > > >Process kapmd (pid: 4, threadinfo=c5f0e000 task=c5fbc640)
> > > 
> > > After receiving Alex' .config and gcc version (3.2.3), I've been
> > > able to decipher this. current->mm is NULL in the kapmd task. The call
> > > 
> > > 	load_LDT(&current->mm->context);	/* This does lldt */
> > > 
> > > in fix_processor_context() computes the address of context as
> > > (current->mm)+0x7c, which is 0x7c. load_LDT_nolock() dereferences
> > > 0x7c+0x14 (void *segments = pc->ldt) and the oops follows.
> > > 
> > > As to _why_ kapmd's current->mm is NULL, I don't know. It isn't
> > > when I test APM suspend in 2.5.69-bk. A lot of code dereferences
> > > current->mm without checking, so I guess current->mm==NULL is a bug.
> > > 
> > 
> > i just go and try it with the latest -bk.
> > 
> 
> no change. Still oopses.
> 
> Is it safe to trace this path with printks? I'm about to put them in,
> but a good advice could probably come before the compilation finishes.
> 

current->mm is NULL even before save_processor_state.

The unlucky wakeup afterwards made the system unstable:

Unable to handle kernel NULL pointer dereference at virtual address 000003ff
 printing eip:
c0180015
*pde = 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c0180015>]    Not tainted
EFLAGS: 00010297
EIP is at ext3_get_inode_loc+0xf5/0x180
eax: 000003ff   ebx: 00000300   ecx: c5ae8604   edx: c12ee9a0
esi: c5ebb200   edi: 00000260   ebp: c5af1c90   esp: c5af1c78
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 171, threadinfo=c5af0000 task=c5bf38c0)
Stack: 00000016 00000013 00026007 00000000 c58cc3c4 c5af1cc4 c5af1cb0 c0180b1d 
       c5ae8604 c5af1cc3 c5af1cc4 c5af1cc4 c5ae8604 c58cc3c4 c5af1ce0 c0180bba 
       c58cc3c4 c5ae8604 c5af1cc4 c5af1ce0 c018ab09 c5ee1a80 c58cc3c4 c58cc3c4 
Call Trace:
 [<c0180b1d>] ext3_reserve_inode_write+0x1d/0xa0
 [<c0180bba>] ext3_mark_inode_dirty+0x1a/0x40
 [<c018ab09>] journal_start+0x89/0xb0
 [<c0180c97>] ext3_dirty_inode+0xb7/0xc0
 [<c01688a7>] __mark_inode_dirty+0xf7/0x100
 [<c0162e78>] inode_update_time+0x68/0xa0
 [<c0132567>] generic_file_aio_write_nolock+0x207/0xac0
 [<c020573b>] __kfree_skb+0x7b/0xf0
 [<c0252841>] unix_dgram_recvmsg+0x141/0x1f0
 [<c0132e8d>] generic_file_write_nolock+0x6d/0x90
 [<c0203333>] sys_recvfrom+0x83/0xe0
 [<c0130b4d>] unlock_page+0xd/0x50
 [<c013d023>] do_wp_page+0x3c3/0x420
 [<c015bc2a>] poll_freewait+0x3a/0x50
 [<c013307d>] generic_file_writev+0x3d/0x60
 [<c014aeb3>] do_readv_writev+0x143/0x270
 [<c014aa10>] do_sync_write+0x0/0xb0
 [<c014b07b>] vfs_writev+0x4b/0x50
 [<c014b0fe>] sys_writev+0x2e/0x50
 [<c0109187>] syscall_call+0x7/0xb

Code: 89 10 8b 4a 18 01 cb 89 58 04 8b 55 ec 89 50 08 31 c0 e9 58 

and some more, more or less like that. This was the first.

