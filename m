Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbTDOQKY (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTDOQKY 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:10:24 -0400
Received: from hypatia.llnl.gov ([134.9.11.73]:50578 "EHLO hypatia.llnl.gov")
	by vger.kernel.org with ESMTP id S261756AbTDOQKV convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 12:10:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Dave Peterson <dsp@llnl.gov>
Organization: Lawrence Livermore National Laboratory
To: linux-kernel@vger.kernel.org
Subject: possible race condition in vfs code
Date: Tue, 15 Apr 2003 09:22:07 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304150922.07003.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I found a race condition in some of the inode handling
code.  Here's where I think it is:

    1.  Task A is inside kill_super().  It clears the MS_ACTIVE
        flag of the s_flags field of the super_block struct and
        calls invalidate_inodes().  In invalidate_inodes(), it
        attempts to acquire inode_lock and spins because task B,
        executing inside iput(), just decremented the reference
        count of some inode i to 0 and acquired inode_lock.

    2.  Then the "if (!inode->i_nlink)" test condition evaluates
        to false for task B so it executes the following chunk
        of code:

        01 } else {
        02         if (!list_empty(&inode->i_hash)) {
        03                 if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
        04                         list_del(&inode->i_list);
        05                         list_add(&inode->i_list, &inode_unused);
        06                 }
        07                 inodes_stat.nr_unused++;
        08                 spin_unlock(&inode_lock);
        09                 if (!sb || (sb->s_flags & MS_ACTIVE))
        10                         return;
        11                 write_inode_now(inode, 1);
        12                 spin_lock(&inode_lock);
        13                 inodes_stat.nr_unused--;
        14                 list_del_init(&inode->i_hash);
        15         }
        16         list_del_init(&inode->i_list);
        17         inode->i_state|=I_FREEING;
        18         inodes_stat.nr_inodes--;
        19         spin_unlock(&inode_lock);
        20         if (inode->i_data.nrpages)
        21                 truncate_inode_pages(&inode->i_data, 0);
        22         clear_inode(inode);
        23 }
        24 destroy_inode(inode);

        Now the test condition on line 02 evaluates to true, so
        task B adds the inode to the inode_unused list and then
        releases inode_lock on line 08.

    3.  Now A acquires inode_lock and B spins on inode_lock inside
        write_inode_now();

    4.  Task A calls invalidate_list(), transferring inode i from
        the inode_unused list to its own private throw_away list.

    5.  Task A releases inode_lock, allowing B to acquire inode_lock
        and continue executing.

    6.  A attempts to destroy inode i inside dispose_list() while B
        simultaneously attempts to destroy i, potentially causing
        all sorts of bad things to happen.

So, did I find a bug or are my eyes playing tricks on me?

-Dave Peterson
 dsp@llnl.gov

P.S.  Please CC my email address when responding to this message.

