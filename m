Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSLBXwc>; Mon, 2 Dec 2002 18:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbSLBXwc>; Mon, 2 Dec 2002 18:52:32 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:39873 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265373AbSLBXwb> convert rfc822-to-8bit; Mon, 2 Dec 2002 18:52:31 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Date: Tue, 3 Dec 2002 00:59:32 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Andrea Arcangeli <andrea@suse.de>,
       Andrew Clayton <andrew@sol-1.demon.co.uk>,
       Javier Marcet <jmarcet@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212030059.32018.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

> > ok, now it's clear what the problem is. there are inuse-dirty inodes
> > that triggers a deadlock in the schedule-capable
> > try_to_sync_unused_inodes of 2.4.20rc2aa1 (that avoided me to backout an
> > otherwise corrupt lowlatency fix). It can trigger only in UP,
> > in SMP the other cpu can always run kupdate that will flush all dirty
> > inodes, so it would lockup one cpu as worse for 2.5 sec, this is
> > probably why I couldn't reproduce it, I assume all of you reproducing
> > the deadlock were running on an UP machine (doesn't matter if the kernel
> Correct (for me anyways). 
ok, deadlock is gone, instead I have EXT3-fs corruption (non data=journal 
mode, just ordered) like this:


Dec  3 00:25:39 codeman kernel: EXT3-fs error (device ide0(3,9)): 
ext3_free_blocks: Freeing blocks not in datazone - block = 1530182
, count = 1
Dec  3 00:25:39 codeman kernel: Aborting journal on device ide0(3,9).
Dec  3 00:25:39 codeman kernel: ext3_free_blocks: aborting transaction: 
Journal has aborted in __ext3_journal_get_undo_access<2>EXT3
-fs error (device ide0(3,9)) in ext3_free_blocks: Journal has aborted
Dec  3 00:25:39 codeman kernel: ext3_reserve_inode_write: aborting 
transaction: Journal has aborted in __ext3_journal_get_write_acce
ss<2>EXT3-fs error (device ide0(3,9)) in ext3_reserve_inode_write: Journal has 
aborted
Dec  3 00:25:39 codeman kernel: EXT3-fs error (device ide0(3,9)) in 
ext3_truncate: Journal has aborted
Dec  3 00:25:39 codeman kernel: ext3_reserve_inode_write: aborting 
transaction: Journal has aborted in __ext3_journal_get_write_acce
ss<2>EXT3-fs error (device ide0(3,9)) in ext3_reserve_inode_write: Journal has 
aborted
Dec  3 00:25:39 codeman kernel: EXT3-fs error (device ide0(3,9)) in 
ext3_orphan_del: Journal has aborted
Dec  3 00:25:39 codeman kernel: ext3_reserve_inode_write: aborting 
transaction: Journal has aborted in __ext3_journal_get_write_acce
ss<2>EXT3-fs error (device ide0(3,9)) in ext3_reserve_inode_write: Journal has 
aborted
Dec  3 00:25:39 codeman kernel: EXT3-fs error (device ide0(3,9)) in 
ext3_delete_inode: Journal has aborted
Dec  3 00:25:39 codeman kernel: ext3_abort called.
Dec  3 00:25:39 codeman kernel: EXT3-fs abort (device ide0(3,9)): 
ext3_journal_start: Detected aborted journal
Dec  3 00:25:39 codeman kernel: Remounting filesystem read-only
Dec  3 00:25:39 codeman kernel: EXT3-fs error (device ide0(3,9)) in 
start_transaction: Journal has aborted

BTW: UP, non-SMP.

ciao, Marc
