Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUHBEDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUHBEDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 00:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUHBEDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 00:03:55 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:29829 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266243AbUHBEDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 00:03:53 -0400
Date: Mon, 2 Aug 2004 14:58:27 +1000
From: Nathan Scott <nathans@sgi.com>
To: Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS: Oops in 2.4.26 and 2.4.27-rc4
Message-ID: <20040802045827.GA21646@frodo>
References: <20040801165946.GA1045@email.archlab.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801165946.GA1045@email.archlab.tuwien.ac.at>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 06:59:46PM +0200, Cahya Wirawan wrote:
> Hi,

Hi there,

> ...
> 2.4.26 and 2.4.27-rc4 get an Oops again. The server will not always
> crash, but it gets always an Oops at the same test (diotest4), and it is

Thanks for reporting it, here is the fix.

cheers.

-- 
Nathan


--- fs/xfs/linux-2.4/xfs_lrw.c.orig	2004-08-02 12:57:02.000000000 +1000
+++ fs/xfs/linux-2.4/xfs_lrw.c	2004-08-02 13:00:03.000000000 +1000
@@ -283,6 +283,8 @@
 	XFS_STATS_INC(xs_read_calls);
 
 	if (unlikely(ioflags & IO_ISDIRECT)) {
+		if ((ssize_t)size < 0)
+			return -XFS_ERROR(EINVAL);
 		if (((__psint_t)buf & BBMASK) ||
 		    (*offset & mp->m_blockmask) ||
 		    (size & mp->m_blockmask)) {
@@ -325,7 +327,8 @@
 	if (unlikely(ioflags & IO_ISDIRECT)) {
 		xfs_rw_enter_trace(XFS_DIORD_ENTER, &ip->i_iocore,
 					buf, size, *offset, ioflags);
-		ret = do_generic_direct_read(file, buf, size, offset);
+		ret = (*offset < ip->i_d.di_size) ?
+			do_generic_direct_read(file, buf, size, offset) : 0;
 		UPDATE_ATIME(file->f_dentry->d_inode);
 	} else {
 		xfs_rw_enter_trace(XFS_READ_ENTER, &ip->i_iocore,
