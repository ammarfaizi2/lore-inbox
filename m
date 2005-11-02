Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVKBDQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVKBDQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 22:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVKBDQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 22:16:06 -0500
Received: from ozlabs.org ([203.10.76.45]:45546 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751162AbVKBDQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 22:16:05 -0500
Date: Wed, 2 Nov 2005 14:15:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: "Paul 'Rusty' Russell" <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: FUTEX_WAKE_OP weirdness
Message-ID: <20051102031553.GC10682@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Paul 'Rusty' Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus/Andrew, please apply.

The code for FUTEX_WAKE_OP calls an arch callback,
futex_atomic_op_inuser().  That callback can return an error code, but
currently the caller assumes any error is EFAULT, and will try various
things to resolve the fault before eventually giving up with EFAULT
(regardless of the original error code).  This is not a theoretical
case - arch callbacks currently return -ENOSYS if the opcode they are
given is bogus.

This patch alters the code to detect non-EFAULT errors and return them
directly to the user.

Of course, whether -ENOSYS is the correct return value for the bogus
opcode case, or whether EINVAL would be more appropriate is another
question.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/kernel/futex.c
===================================================================
--- working-2.6.orig/kernel/futex.c	2005-10-31 15:45:01.000000000 +1100
+++ working-2.6/kernel/futex.c	2005-11-02 14:02:08.000000000 +1100
@@ -365,6 +365,11 @@
 		if (bh1 != bh2)
 			spin_unlock(&bh2->lock);
 
+		if (unlikely(op_ret != -EFAULT)) {
+			ret = op_ret;
+			goto out;
+		}
+
 		/* futex_atomic_op_inuser needs to both read and write
 		 * *(int __user *)uaddr2, but we can't modify it
 		 * non-atomically.  Therefore, if get_user below is not


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
