Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVC3UKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVC3UKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVC3UKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:10:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:57587 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262459AbVC3UJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:09:56 -0500
Subject: [PATCH] Set MS_ACTIVE in isofs_fill_super()
From: Russ Weight <rweight@us.ibm.com>
Reply-To: rweight@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Mar 2005 12:09:52 -0800
Message-Id: <1112213392.25362.65.camel@russw.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets the MS_ACTIVE bit in isofs_fill_super() prior to calling
iget() or iput(). This eliminates a race condition between mount
(for isofs) and kswapd that results in a system panic.

Signed-off-by: Russ Weight <rweight@us.ibm.com>

--- linux-2.6.12-rc1/fs/isofs/inode.c	2005-03-17 17:34:36.000000000
-0800
+++ linux-2.6.12-rc1-isofsfix/fs/isofs/inode.c	2005-03-22
15:29:51.945607217 -0800
@@ -820,6 +820,7 @@
 	 * the s_rock flag. Once we have the final s_rock value,
 	 * we then decide whether to use the Joliet descriptor.
 	 */
+	s->s_flags |= MS_ACTIVE;
 	inode = isofs_iget(s, sbi->s_firstdatazone, 0);
 
 	/*
@@ -909,6 +910,7 @@
 		kfree(opt.iocharset);
 	kfree(sbi);
 	s->s_fs_info = NULL;
+	s->s_flags &= ~MS_ACTIVE;
 	return -EINVAL;
 }
 

