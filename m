Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVDZUFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVDZUFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVDZUFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:05:11 -0400
Received: from aun.it.uu.se ([130.238.12.36]:26353 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261770AbVDZUEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:04:32 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17006.40634.550626.473965@alkaid.it.uu.se>
Date: Tue, 26 Apr 2005 22:04:10 +0200
To: akpm@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31-pre1] rwsem-spinlock linkage error
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The

Andrew Morton:
  o rwsem: Make rwsems use interrupt disabling spinlocks

change in 2.4.31-pre1 has a typo: one occurrence of spin_unlock() was
changed to spin_unlock_restore() instead of spin_unlock_irqrestore()
as was obviously the intention. Since spin_unlock_restore() doesn't
exist, this results in linkage errors on x86_64 and other archs using
CONFIG_RWSEM_GENERIC_SPINLOCK.

Trival fix below.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.4.31-pre1/lib/rwsem-spinlock.c.~1~	2005-04-26 19:12:52.000000000 +0200
+++ linux-2.4.31-pre1/lib/rwsem-spinlock.c	2005-04-26 21:16:05.000000000 +0200
@@ -269,7 +269,7 @@ void fastcall __up_read(struct rw_semaph
 	if (--sem->activity==0 && !list_empty(&sem->wait_list))
 		sem = __rwsem_wake_one_writer(sem);
 
-	spin_unlock_restore(&sem->wait_lock, flags);
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
 	rwsemtrace(sem,"Leaving __up_read");
 }
