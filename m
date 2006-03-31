Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWCaJSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWCaJSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 04:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWCaJSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 04:18:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:32951 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751284AbWCaJSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 04:18:22 -0500
X-Authenticated: #14349625
Subject: [2.6.16-mm2 patch] don't awaken RT tasks on expired array
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 11:18:49 +0200
Message-Id: <1143796729.7524.14.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RT tasks are being awakened on the expired array when expired_starving()
is true, whereas they really should be excluded.  Fix below.

	
Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/kernel/sched.c.org	2006-03-31 09:56:37.000000000 +0200
+++ linux-2.6.16-mm2/kernel/sched.c	2006-03-31 10:01:54.000000000 +0200
@@ -820,7 +820,7 @@
 {
 	prio_array_t *target = rq->active;
 
-	if (unlikely(batch_task(p) || expired_starving(rq)))
+	if (unlikely(batch_task(p) || (expired_starving(rq) && !rt_task(p))))
 		target = rq->expired;
 	enqueue_task(p, target);
 	inc_nr_running(p, rq);


