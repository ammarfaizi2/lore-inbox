Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbUKDCgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUKDCgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUKDCgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:36:52 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:12682 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261364AbUKDCgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:36:20 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu, marcelo.tosatti@cyclades.com
Subject: [patch 2.4.28-rc1] Avoid oops in proc_delete_inode
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Nov 2004 13:35:33 +1100
Message-ID: <9663.1099535733@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under heavy load, vmstat, top and other programs that access /proc can
oops.  PROC_INODE_PROPER(inode) is sometimes false for pid entries
(usually zombies), but inode->u.generic_ip is not NULL.

Backport a fix by AL Viro from 2.5.7-pre2 to 2.4.28-rc1.

Signed-off-by: Keith Owens <kaos@sgi.com>

Index: 2.4.28-rc1/fs/proc/base.c
===================================================================
--- 2.4.28-rc1.orig/fs/proc/base.c	2004-08-08 10:10:49.000000000 +1000
+++ 2.4.28-rc1/fs/proc/base.c	2004-11-04 13:25:16.402602459 +1100
@@ -780,6 +780,7 @@ out:
 	return inode;
 
 out_unlock:
+	node->u.generic_ip = NULL;
 	iput(inode);
 	return NULL;
 }

