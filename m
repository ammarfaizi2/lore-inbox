Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVESV1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVESV1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVESV1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:27:23 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:20868 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261256AbVESV1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:27:17 -0400
X-ORBL: [63.205.185.30]
Date: Thu, 19 May 2005 14:27:03 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Joshua Baker-LePain <jlb17@duke.edu>
Cc: Gregory Brauer <greg@wildbrain.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, Jakob Oestergaard <jakob@unthought.net>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
Message-ID: <43e211ed9b147428f39b5739644d1125.IBX@taniwha.stupidest.org>
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org> <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org> <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu> <428BA8E4.2040108@wildbrain.com> <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu> <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 05:00:22PM -0400, Joshua Baker-LePain wrote:

> May 19 16:47:10 norbert kernel: xfs_da_do_buf: bno 8388608
> May 19 16:47:10 norbert kernel: dir: inode 2162706
> May 19 16:47:10 norbert kernel: Filesystem "md0": XFS internal error xfs_da_do_buf(1) at line 2176 of file fs/xfs/xfs_da_btree.c.  Caller 0xf8c90148
> May 19 16:47:10 norbert kernel:  [<f8c8fd5b>] xfs_da_do_buf+0x357/0x70d [xfs]

This isn't what was reported before.  Maybe check inode 2162706 on
disk using xfs_db and make sure it looks OK?

As pointed out it is a really long call-chain --- I'm guessing it's OK
but it could still be a stack overflow problem as with 8K stacks you
don't have separate IRQ stacks.

If you like you could apply the following patch and *enable*
CONFIG_4KSTACKS.  In this case is badly named as you will really have
8K process stacks and 4K irq stacks after applying this.


Index: cw-current/include/asm-i386/thread_info.h
===================================================================
--- cw-current.orig/include/asm-i386/thread_info.h	2004-12-15 14:35:00.296402459 -0800
+++ cw-current/include/asm-i386/thread_info.h	2004-12-15 14:38:20.129259160 -0800
@@ -54,12 +54,12 @@
 
 #define PREEMPT_ACTIVE		0x10000000
 #ifdef CONFIG_4KSTACKS
-#define THREAD_SIZE            (4096)
+#define THREAD_SIZE            (8192)
 #else
 #define THREAD_SIZE		(8192)
 #endif
 
-#define STACK_WARN             (THREAD_SIZE/8)
+#define STACK_WARN             (THREAD_SIZE/2)
 /*
  * macros/functions for gaining access to the thread information structure
  *
