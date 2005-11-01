Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVKAFtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVKAFtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVKAFtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:49:19 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:54154 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750976AbVKAFtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:49:18 -0500
Date: Mon, 31 Oct 2005 21:49:31 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, oleg@tv-sign.ru, dipankar@in.ibm.com,
       suzannew@cs.pdx.edu, akpm@osdl.org
Subject: [PATCH] Fixes for RCU handling of sighand_struct
Message-ID: <20051101054931.GA4399@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Some fixes to RCU usage for sighand_struct, adding a couple of needed
rcu_assign_pointer() calls.

Signed-off-by: <paulmck@us.ibm.com>

---

diff -urpNa linux-2.6.14-rc5-rt5/fs/exec.c linux-2.6.14-rc5-rt5-sighandRCUfix/fs/exec.c
--- linux-2.6.14-rc5-rt5/fs/exec.c	2005-10-24 05:59:08.000000000 -0700
+++ linux-2.6.14-rc5-rt5-sighandRCUfix/fs/exec.c	2005-10-31 15:38:02.000000000 -0800
@@ -777,7 +777,7 @@ no_thread_group:
 		spin_lock(&oldsighand->siglock);
 		spin_lock(&newsighand->siglock);
 
-		current->sighand = newsighand;
+		rcu_assign_pointer(current->sighand, newsighand);
 		recalc_sigpending();
 
 		spin_unlock(&newsighand->siglock);
diff -urpNa linux-2.6.14-rc5-rt5/kernel/fork.c linux-2.6.14-rc5-rt5-sighandRCUfix/kernel/fork.c
--- linux-2.6.14-rc5-rt5/kernel/fork.c	2005-10-24 05:59:08.000000000 -0700
+++ linux-2.6.14-rc5-rt5-sighandRCUfix/kernel/fork.c	2005-10-31 15:35:14.000000000 -0800
@@ -816,7 +816,7 @@ static inline int copy_sighand(unsigned 
 		return 0;
 	}
 	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
-	tsk->sighand = sig;
+	rcu_assign_pointer(tsk->sighand, sig);
 	if (!sig)
 		return -ENOMEM;
 	spin_lock_init(&sig->siglock);
