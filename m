Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265884AbUGIVoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbUGIVoR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUGIVoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:44:17 -0400
Received: from fmr12.intel.com ([134.134.136.15]:46761 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S265884AbUGIVoP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:44:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Modular filesystem using drop_inode would need inode_lock
Date: Fri, 9 Jul 2004 14:43:32 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F019FB78F@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Modular filesystem using drop_inode would need inode_lock
thread-index: AcRl/cf94Spr2IOxQPG2tBWy73heeQ==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jul 2004 21:43:34.0317 (UTC) FILETIME=[C8CC25D0:01C465FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly a logical inconsistency at the moment (since the
only filesystem that has a "drop_inode" function defined in its
super_operations is hugetlbfs, and it is unlikely to move out of
the kernel and into a module).  But the ->drop_inode() function
is called with inode_lock held, and it is expected to drop the
lock ... which would be impossible for a module as the lock is
not exported.

Signed-off-by: <tony.luck@intel.com>



--- old/fs/inode.c	2004-07-09 14:05:16.986225857 -0700
+++ new/fs/inode.c	2004-07-09 14:05:42.198492986 -0700
@@ -81,6 +81,7 @@
  * the i_state of an inode while it is in use..
  */
 spinlock_t inode_lock = SPIN_LOCK_UNLOCKED;
+EXPORT_SYMBOL(inode_lock);
 
 /*
  * iprune_sem provides exclusion between the kswapd or
try_to_free_pages
