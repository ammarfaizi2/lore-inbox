Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVILXoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVILXoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVILXoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:44:04 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:35976 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932358AbVILXoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:44:01 -0400
From: Zach Brown <zach.brown@oracle.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>,
       Zach Brown <zach.brown@oracle.com>
Message-Id: <20050912234406.31460.93241.89411@takashi.pdx.zabbo.net>
Subject: [Patch] Add smp_mb__after_clear_bit() to unlock_kiocb()
Date: Mon, 12 Sep 2005 16:43:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add smp_mb__after_clear_bit() to unlock_kiocb()

AIO's use of wait_on_bit_lock()/wake_up_bit() forgot to add a barrier between
clearing its lock bit and calling wake_up_bit() so wake_up_bit()'s unlocked
waitqueue_active() can race.  This puts AIO's use in line with the others
and the comment above wake_up_bit().

Please apply.

Signed-off-by: Zach Brown <zach.brown@oracle.com>

Index: 2.6.13-git12-mb-lock-kiocb/fs/aio.c
===================================================================
--- 2.6.13-git12-mb-lock-kiocb.orig/fs/aio.c
+++ 2.6.13-git12-mb-lock-kiocb/fs/aio.c
@@ -562,6 +562,7 @@ static inline void lock_kiocb(struct kio
 static inline void unlock_kiocb(struct kiocb *iocb)
 {
 	kiocbClearLocked(iocb);
+	smp_mb__after_clear_bit();
 	wake_up_bit(&iocb->ki_flags, KIF_LOCKED);
 }
 
  Signed-off-by: Zach Brown <zach.brown@oracle.com>

 aio.c |    1 +
 1 files changed, 1 insertion(+)
