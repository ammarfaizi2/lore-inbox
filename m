Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUJYUe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUJYUe7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUJYUeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:34:01 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51657 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261316AbUJYUbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:31:10 -0400
Subject: Re: [Ext2-devel] Re: [PATCH 2/3] ext3 reservation allow turn off
	for specifed file
From: Mingming Cao <cmm@us.ibm.com>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com, pbadari@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <1098294941.18850.4.camel@orca.madrabbit.org>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	<1097856114.4591.28.camel@localhost.localdomain>
	<1097858401.1968.148.camel@sisko.scot.redhat.com>
	<1097872144.4591.54.camel@localhost.localdomain>
	<1097878826.1968.162.camel@sisko.scot.redhat.com> <109787 
	<1098147705.8803.1084.camel@w-ming2.beaverton.ibm.com> 
	<1098294941.18850.4.camel@orca.madrabbit.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2004 13:33:05 -0700
Message-Id: <1098736389.9692.7243.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 10:55, Ray Lee wrote:
> On Mon, 2004-10-18 at 18:01 -0700, Mingming Cao wrote:
> > On Mon, 2004-10-18 at 16:42, Andrew Morton wrote:
> > > Applications currently pass a seeky-access hint into the kernel via
> > > posix_fadvise(POSIX_FADV_RANDOM).  It would be nice to hook into that
> 
> [...]
> 
> > Just thought seeky random write application could use the existing ioctl
> > to let the kernel know it does not need reservation at all. Isn't that
> > more straightforward?
> 
> Going the ioctl route seems to imply that userspace would have to do a
> posix_fadvise() call and the ioctl, as opposed to just the fadvise. No?
> I'm betting the fadvise call is a little more portable as well.

Agreed. How about this: add a check in ext3_prepare_write(), if user passed seeky-access hint through posix_fadvise(via check for file->f_ra.ra_pages == 0), if so, close the reservation window.  But we still need previous patch to handle window size 0(no reservation) in reservation code.

Currently the readahead is turned off if the userspace passed a seeky access hint to kernel by POSIX_FADVISE. It would be nice to turn off the block allocation reservation as well for seeky random write.


---

 linux-2.6.9-rc4-mm1-ming/fs/ext3/inode.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN fs/ext3/inode.c~ext3_turn_off_reservation_by_fadvise fs/ext3/inode.c
--- linux-2.6.9-rc4-mm1/fs/ext3/inode.c~ext3_turn_off_reservation_by_fadvise	2004-10-25 18:25:44.135751800 -0700
+++ linux-2.6.9-rc4-mm1-ming/fs/ext3/inode.c	2004-10-25 18:34:39.501363856 -0700
@@ -1008,6 +1008,15 @@ retry:
 		ret = PTR_ERR(handle);
 		goto out;
 	}
+
+	/*
+	 * if user passed a seeky-access hint to kernel,
+	 * through POSIX_FADV_RANDOM,(file->r_ra.ra_pages is cleared)
+	 * turn off reservation for block allocation correspondingly.
+	 */
+	if (!file->f_ra.ra_pages)
+		atomic_set(&EXT3_I(inode)->i_rsv_window.rsv_goal_size, 0);
+
 	ret = block_prepare_write(page, from, to, ext3_get_block);
 	if (ret)
 		goto prepare_write_failed;

_

