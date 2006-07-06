Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWGFV4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWGFV4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWGFV4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:56:54 -0400
Received: from www.osadl.org ([213.239.205.134]:32651 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750786AbWGFV4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:56:53 -0400
Subject: [PATCH] pi-futex: Validate futex type instead of oopsing
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jakub Jelinek <jakub@redhat.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 23:59:34 +0200
Message-Id: <1152223174.24611.176.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calling futex_lock_pi is called with a reference to a non PI futex and
waiters exist already, lookup_pi_state() oopses due to pi_state == NULL.
Check this condition and return -EINVAL to userspace.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/kernel/futex.c b/kernel/futex.c
index 1dc98e4..cf0c8e2 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -476,6 +476,12 @@ lookup_pi_state(u32 uval, struct futex_h
 			 * the refcount and return its pi_state:
 			 */
 			pi_state = this->pi_state;
+			/*
+			 * Userspace might have messed up non PI and PI futexes
+			 */
+			if (unlikely(!pi_state))
+				return -EINVAL;
+
 			atomic_inc(&pi_state->refcount);
 			me->pi_state = pi_state;
 


