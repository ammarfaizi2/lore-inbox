Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265426AbUF2Ek2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbUF2Ek2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUF2Ek1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:40:27 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:63439 "HELO
	spl35.corp.google.com") by vger.kernel.org with SMTP
	id S265426AbUF2EkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:40:13 -0400
Message-ID: <6599ad830406282140a6310fe@mail.google.com>
Date: Mon, 28 Jun 2004 21:40:10 -0700
From: Paul Menage <menage@google.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Race in iput()?
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is the following sequence of events possible? If so, that would seem
to be a bug.

- inode on non-MS_ACTIVE superblock is on unused list (fs being unmounted?)
- prune_icache() starts processing inode, so sets I_LOCK
- in another thread, someone calls iget() then iput() on inode 
- inode is dirty, so iput() calls write_inode_now() 
- write_inode_now() calls sync_one()
- sync_one() calls __iget() and bumps inode ref count back up to 1
- sync_one() calls __wait_on_inode() and sleeps
- in original thread, prune_icache() finishes with inode and clears I_LOCK
- sync_one() wakes up and calls iput()
- iput() decrements ref count to 0 again and frees inode (no wait this time)
- sync_one() and callers now hold a pointer to a freed inode

Alternatively, try_to_sync_unused_inodes() could be racing rather than
prune_icache().

We've seen a crash that could be explained by this race being hit, if
it is possible.

Paul
