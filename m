Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWHCDfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWHCDfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWHCDfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:35:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:23710 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932191AbWHCDfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:35:31 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC, PATCH -rt] futex_atomic_cmpxchg_inatomic usage
Date: Wed, 2 Aug 2006 20:35:25 -0700
User-Agent: KMail/1.9.1
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <nielsen.esben@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608022035.26542.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing futex.c re Esben's rt_mutex_next_owner() serialization
posting, I had a question regarding the use of

futex_atomic_cmpxchg_inatomic()

In all but two places in futex.c we wrap that call with 
(inc|dec)_preempt_count() calls.  Nothing stood out to me that would
account for the difference.  Can some comment on why we don't have to
wrap the call in those two places (see patch for locations).  Just in 
case this happens to be a bug, I've included a patch to fix it.


Index: 2.6.17-rt8/kernel/futex.c
===================================================================
--- 2.6.17-rt8.orig/kernel/futex.c	2006-08-02 20:29:08.000000000 -0700
+++ 2.6.17-rt8/kernel/futex.c	2006-08-02 20:29:42.000000000 -0700
@@ -1303,8 +1303,10 @@
 		ret = get_user(uval, uaddr);
 		while (!ret) {
 			newval = (uval & FUTEX_OWNER_DIED) | newtid;
+			inc_preempt_count();
 			curval = futex_atomic_cmpxchg_inatomic(uaddr,
 							       uval, newval);
+			dec_preempt_count();
 			if (curval == -EFAULT)
 				ret = -EFAULT;
 			if (curval == uval)
@@ -1684,8 +1686,11 @@
 		 * thread-death.) The rest of the cleanup is done in
 		 * userspace.
 		 */
+		inc_preempt_count();
 		nval = futex_atomic_cmpxchg_inatomic(uaddr, uval,
 						     uval | FUTEX_OWNER_DIED);
+		dec_preempt_count();
+
 		if (nval == -EFAULT)
 			return -1;
-- 
Thanks,
 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
