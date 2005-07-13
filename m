Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVGMBAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVGMBAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVGMBAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:00:50 -0400
Received: from mail.suse.de ([195.135.220.2]:24498 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262408AbVGMBAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:00:48 -0400
From: Chris Mason <mason@suse.com>
To: "Rob Mueller" <robm@fastmail.fm>
Subject: Re: 2.6.12.2 dies after 24 hours
Date: Tue, 12 Jul 2005 21:00:40 -0400
User-Agent: KMail/1.8
Cc: akpm@osdl.org, "Lars Roland" <lroland@gmail.com>,
       "Bron Gondwana" <brong@fastmail.fm>, linux-kernel@vger.kernel.org,
       "Jeremy Howard" <jhoward@fastmail.fm>,
       "Vladimir Saveliev" <vs@namesys.com>
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP> <039301c58741$a4df9fb0$7c00a8c0@ROBMHP> <200507122042.11397.mason@suse.com>
In-Reply-To: <200507122042.11397.mason@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507122100.41759.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 20:42, Chris Mason wrote:

> > Sounds like a different issue. The patch Bron included before fixes (or
> > at least reduces to the point where it fixes it for us) a problem where
> > processes get stuck in D state and are unkillable. A reboot is required
> > to remove them. Apparently this is a known bug in ReiserFS (see messages
> > below). As noted, the same bug exists in ext3. There appears to have been
> > some patches to try and fix it for both reiserfs and ext3, but I'm not
> > sure if they're in the mainline kernel yet.
> >
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/2056.html
> > http://hulllug.principalhosting.net/archive/index.php/t-22774.html
>
> There is a much less complex solution that I've just recently gotten
> working in the SUSE kernel.  If reiser3/ext3 don't log the inode during
> atime updates, the problem goes away.

The sysrq is huge, and I haven't yet found the person holding the transaction 
open.  But, here's another place that starts a transaction with the mmap sem 
held, and I would guess the transaction writer is waiting on something for 
that mmap sem.

atime updates alone won't fix this one....

-chris

imapd         D F3159530     0 32412   2292         32413 32411 (NOTLB)
e1cdfdfc 00000082 00000008 f3159530 00000202 00000000 c1e5b0a0 c013b1a0
       00000034 00000202 c301b520 00000001 00004609 beca3f0b 00005566 c301b520
       c315b530 f3159530 f3159654 00000000 00000001 0000000e d9309dac 00000000
Call Trace:
 [<c013b1a0>] free_hot_cold_page+0x20/0xd0
 [<c01ac8dd>] queue_log_writer+0x5d/0x80
 [<c0114b10>] default_wake_function+0x0/0x20
 [<c01acb8a>] do_journal_begin_r+0x1ca/0x2b0
 [<c01409e0>] truncate_inode_pages+0x290/0x2b0
 [<c01ace9e>] journal_begin+0x8e/0xe0
 [<c0191061>] reiserfs_delete_inode+0x51/0xc0
 [<c01447fa>] unmap_vmas+0x14a/0x260
 [<c0191010>] reiserfs_delete_inode+0x0/0xc0
 [<c016c97d>] generic_delete_inode+0x7d/0xe0
 [<c016cb83>] iput+0x63/0x70
 [<c0169db6>] dput+0x176/0x1b0
 [<c01547cb>] __fput+0xcb/0x100
 [<c01470ff>] remove_vm_struct+0x5f/0x80
 [<c014873a>] unmap_vma_list+0x1a/0x30
 [<c0148a9f>] do_munmap+0xdf/0xf0
 [<c0148aff>] sys_munmap+0x4f/0x70
 [<c0102a15>] syscall_call+0x7/0xb

