Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946117AbWJaXKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946117AbWJaXKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946137AbWJaXKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:10:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946117AbWJaXKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:10:19 -0500
Message-Id: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
Subject: [patch 1/1] schedule removal of FUTEX_FD
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, drepper@redhat.com, mingo@elte.hu, rusty@rustcorp.com.au,
       tglx@linutronix.de
From: akpm@osdl.org
Date: Tue, 31 Oct 2006 15:09:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Apparently FUTEX_FD is unfixably racy and nothing uses it (or if it does, it
shouldn't).

Add a warning printk, give any remaining users six months to migrate off it.

Cc: Ulrich Drepper <drepper@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/futex.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN kernel/futex.c~schedule-removal-of-futex_fd kernel/futex.c
--- a/kernel/futex.c~schedule-removal-of-futex_fd
+++ a/kernel/futex.c
@@ -1507,6 +1507,14 @@ static int futex_fd(u32 __user *uaddr, i
 	struct futex_q *q;
 	struct file *filp;
 	int ret, err;
+	static int warn_count;
+
+	if (warn_count < 10) {
+		printk(KERN_WARNING "Process `%s' used FUTEX_FD, which "
+		    	"will be removed from the kernel in June 2007\n",
+			current->comm);
+		warn_count++;
+	}
 
 	ret = -EINVAL;
 	if (!valid_signal(signal))
_
