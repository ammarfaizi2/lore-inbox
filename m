Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUHJMJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUHJMJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUHJMJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:09:00 -0400
Received: from aun.it.uu.se ([130.238.12.36]:58512 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263714AbUHJMIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:08:48 -0400
Date: Tue, 10 Aug 2004 14:08:40 +0200 (MEST)
Message-Id: <200408101208.i7AC8ekN016218@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc4-mm1] perfctr SMP hang fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch fixes a critical SMP bug in the perfctr
inheritance fix I sent yesterday. I added a spinlock
to the perfctr state, but forgot to initialise it,
which results in a hard hang on SMP the first time
someone tries to program their perfctrs. It works
on UP, which is why I didn't detect it before :-(

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/virtual.c |    1 +
 1 files changed, 1 insertion(+)

diff -ruN linux-2.6.8-rc4-mm1/drivers/perfctr/virtual.c linux-2.6.8-rc4-mm1.perfctr-spinlock-fix/drivers/perfctr/virtual.c
--- linux-2.6.8-rc4-mm1/drivers/perfctr/virtual.c	2004-08-10 13:52:17.000000000 +0200
+++ linux-2.6.8-rc4-mm1.perfctr-spinlock-fix/drivers/perfctr/virtual.c	2004-08-10 13:53:57.644784000 +0200
@@ -156,6 +156,7 @@
 		atomic_set(&perfctr->count, 1);
 		vperfctr_init_bad_cpus_allowed(perfctr);
 		spin_lock_init(&perfctr->owner_lock);
+		spin_lock_init(&perfctr->children_lock);
 	}
 	return perfctr;
 }
