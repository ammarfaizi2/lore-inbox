Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbUJYXgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUJYXgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 19:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUJYXdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 19:33:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7868 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262040AbUJYX2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 19:28:37 -0400
Subject: Re: [Ext2-devel] Re: [PATCH 2/3] ext3 reservation allow turn off
	for specifed file
From: Mingming Cao <cmm@us.ibm.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Ray Lee <ray-lk@madrabbit.org>, Andrew Morton <akpm@osdl.org>,
       sct@redhat.com, pbadari@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <1098736389.9692.7243.camel@w-ming2.beaverton.ibm.com>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	<1097856114.4591.28.camel@localhost.localdomain>
	<1097858401.1968.148.camel@sisko.scot.redhat.com>
	<1097872144.4591.54.camel@localhost.localdomain>
	<1097878826.1968.162.camel@sisko.scot.redhat.com> <109787 
	<1098147705.8803.1084.camel@w-ming2.beaverton.ibm.com> 
	<1098294941.18850.4.camel@orca.madrabbit.org> 
	<1098736389.9692.7243.camel@w-ming2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2004 16:05:44 -0700
Message-Id: <1098745548.9754.7427.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 13:33, Mingming Cao wrote:
> On Wed, 2004-10-20 at 10:55, Ray Lee wrote:
> > On Mon, 2004-10-18 at 18:01 -0700, Mingming Cao wrote:
> > > On Mon, 2004-10-18 at 16:42, Andrew Morton wrote:
> > > > Applications currently pass a seeky-access hint into the kernel via
> > > > posix_fadvise(POSIX_FADV_RANDOM).  It would be nice to hook into that
> > 
> > [...]
> > 
> > > Just thought seeky random write application could use the existing ioctl
> > > to let the kernel know it does not need reservation at all. Isn't that
> > > more straightforward?
> > 
> > Going the ioctl route seems to imply that userspace would have to do a
> > posix_fadvise() call and the ioctl, as opposed to just the fadvise. No?
> > I'm betting the fadvise call is a little more portable as well.
> 
> Agreed. How about this: add a check in ext3_prepare_write(), if user passed seeky-access hint through posix_fadvise(via check for file->f_ra.ra_pages == 0), if so, close the reservation window.  But we still need previous patch to handle window size 0(no reservation) in reservation code.

The previous patch could re-open the reservation in the case user then
switch back to POSIX_FADV_NORMAL or POSIZ_FADV_SEQUENTAIL. Updated
version included. We set the window size to -1 if the user pass the
POSIX_FADV_RANDOM, instead of 0, to differentiate the case when user
really want to close the window by ioctl.  We could re-open the window
only when user pass the POSIX_FADV_SEQUENTAIL (or POSIX_FADV_NORMAL
hint) and the window was closed because of previous seeky access hint.

Currently the readahead is turned off if the userspace passed a seeky access hint to kernel by POSIX_FADVISE. It would be nice to turn off the block allocation reservation as well for seeky random write.


---

 linux-2.6.9-rc4-mm1-ming/fs/ext3/balloc.c |    2 +-
 linux-2.6.9-rc4-mm1-ming/fs/ext3/inode.c  |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff -puN fs/ext3/inode.c~ext3_turn_off_reservation_by_fadvise fs/ext3/inode.c
--- linux-2.6.9-rc4-mm1/fs/ext3/inode.c~ext3_turn_off_reservation_by_fadvise	2004-10-25 18:25:44.135751800 -0700
+++ linux-2.6.9-rc4-mm1-ming/fs/ext3/inode.c	2004-10-25 21:43:16.194964928 -0700
@@ -1001,6 +1001,7 @@ static int ext3_prepare_write(struct fil
 	int ret, needed_blocks = ext3_writepage_trans_blocks(inode);
 	handle_t *handle;
 	int retries = 0;
+	int windowsz = 0;
 
 retry:
 	handle = ext3_journal_start(inode, needed_blocks);
@@ -1008,6 +1009,22 @@ retry:
 		ret = PTR_ERR(handle);
 		goto out;
 	}
+
+	/*
+	 * if user passed a seeky-access hint to kernel,
+	 * through POSIX_FADV_RANDOM,(file->r_ra.ra_pages is cleared)
+	 * turn off reservation for block allocation correspondingly.
+	 *
+	 * Otherwise, if user switch back to POSIX_FADV_SEQUENTIAL or
+	 * POSIX_FADV_NORMAL, re-open the reservation window.
+	 */
+	windowsz = atomic_read(&EXT3_I(inode)->i_rsv_window.rsv_goal_size);
+	if ((windowsz > 0) && (!file->f_ra.ra_pages))
+		atomic_set(&EXT3_I(inode)->i_rsv_window.rsv_goal_size, -1);
+	if ((windowsz == -1) && file->f_ra.ra_pages)
+		atomic_set(&EXT3_I(inode)->i_rsv_window.rsv_goal_size,
+					EXT3_DEFAULT_RESERVE_BLOCKS);
+
 	ret = block_prepare_write(page, from, to, ext3_get_block);
 	if (ret)
 		goto prepare_write_failed;
diff -puN fs/ext3/balloc.c~ext3_turn_off_reservation_by_fadvise fs/ext3/balloc.c
--- linux-2.6.9-rc4-mm1/fs/ext3/balloc.c~ext3_turn_off_reservation_by_fadvise	2004-10-25 21:23:05.152071432 -0700
+++ linux-2.6.9-rc4-mm1-ming/fs/ext3/balloc.c	2004-10-25 21:24:48.136415432 -0700
@@ -1154,7 +1154,7 @@ int ext3_new_block(handle_t *handle, str
 	struct ext3_sb_info *sbi;
 	struct reserve_window_node *my_rsv = NULL;
 	struct reserve_window_node *rsv = &EXT3_I(inode)->i_rsv_window;
-	unsigned short windowsz = 0;
+	int windowsz = 0;
 #ifdef EXT3FS_DEBUG
 	static int goal_hits, goal_attempts;
 #endif

_

