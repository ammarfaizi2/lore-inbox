Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269630AbUIRUsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269630AbUIRUsL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 16:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269631AbUIRUsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 16:48:10 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:21977 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S269630AbUIRUsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 16:48:01 -0400
Date: Sun, 19 Sep 2004 05:47:41 +0900 (JST)
Message-Id: <20040919.054741.01370775.okuyamak@dd.iij4u.or.jp>
To: akpm@osdl.org
Cc: kihara.seiji@lab.ntt.co.jp, sct@redhat.com, adilger@clusterfs.com,
       ext3-users@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, ospfs@lab.ntt.co.jp
Subject: Re: [PATCH] BUG on fsync/fdatasync with Ext3 data=journal
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <20040916145059.44a7e800.akpm@osdl.org>
References: <ufz5i5q4r.wl%kihara.seiji@lab.ntt.co.jp>
	<20040916145059.44a7e800.akpm@osdl.org>
X-Mailer: Mew version 4.0.65 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Morton, Seiji, and all,

>>>>> "AM" == Andrew Morton <akpm@osdl.org> writes:
AM> Yes, the I_DIRTY test is bogus because data pages are not marked dirty at
AM> write() time when the filesystem is mounted in data=journal mode.
AM> However your patch will disable the above optimisation for data=writeback
AM> and data-ordered modes as well.  I don't think that's necessary?

I don't think Mr. Morton's code have any advantages over Seiji's patch.


Please look at lines below. Line starting with AM> + are the point
Mr. Morton have added the code ( point where you removed are bit
above, and not in the lines ).


74         if (ext3_should_journal_data(inode)) {
75                 ret = ext3_force_commit(inode->i_sb);
76                 goto out;
77         }
AM> +	smp_mb();		/* prepare for lockless i_state read */
AM> +	if (!(inode->i_state & I_DIRTY))
AM> +		goto out;
AM> +
78 
79         /*
80          * The VFS has written the file data.  If the inode is unaltered
81          * then we need not start a commit.
82          */
83         if (inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC)) {
84                 struct writeback_control wbc = {
85                         .sync_mode = WB_SYNC_ALL,
86                         .nr_to_write = 0, /* sys_fsync did this */
87                 };
88                 ret = sync_inode(inode, &wbc);
89         }
90 out:
91         return ret;

Now. Please note that
       #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
is definition of macro 'I_DIRTY'. As result, Mr. Morton's patch is
saying that:

	if (!(inode->i_state & (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGE))
		goto out;
         if (inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC)) {
                 struct writeback_control wbc = {
                         .sync_mode = WB_SYNC_ALL,
                         .nr_to_write = 0, /* sys_fsync did this */
                 };
                 ret = sync_inode(inode, &wbc);
         }
out:


But this is equivalent to following code ( think carefully :-)

         if (inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC)) {
                 struct writeback_control wbc = {
                         .sync_mode = WB_SYNC_ALL,
                         .nr_to_write = 0, /* sys_fsync did this */
                 };
                 ret = sync_inode(inode, &wbc);
         }
out:

whch turns out to be what Seiji's patch was.


Hence, Mr. Morton's patch have no OPTIMIZATION over Seiji's code.
( if gcc is smart enough, Mr. Morton's code should have no effect to
binary. If not, it's overhead. ).


My worry is follows.

  Basically, Seiji's patch is better. But in that case,
  smp_mb() call right before accessing to inode->i_state will
  disappear. Is this safe.....

  I am not sure because even without Seiji's patch,
  codes at line 83 did exist. And it was working... wasn't it?

  In the case smp_mb() was simply not nessasary, Seiji's patch
  will do everything. In case smp_mb() was nessasary, we were
  lacking one right before line 83.


best regards,
---- 
Kenichi Okuyama

