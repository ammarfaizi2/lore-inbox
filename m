Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTHWCxB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 22:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTHWCxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 22:53:01 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:32640 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S264186AbTHWCw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 22:52:56 -0400
Date: Sat, 23 Aug 2003 11:54:48 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: linux-kernel@vger.kernel.org
Subject: Race condition in 2.4 tasklet handling
Message-ID: <20030823025448.GA32547@atj.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 It's a similar to race condition spotted in i386 interrupt code.  The
race exists between tasklet_[hi_]action() and tasklet_disable().
Again, memory-ordered synchronization is used between
tasklet_struct.count and tasklet_struct.state.

 tasklet_disable() is find because there's an smp_mb() at the end of
tasklet_disable_nosync(); however, in tasklet_action(), there is no
mb() between tasklet_trylock(t) and atomic_read(&t->count).  This
won't cause any trouble on architectures which orders memory accesses
around atomic operations such (including x86), but on architectures
which don't, a tasklet can be executing on another cpu on return from
tasklet_disable().

 Adding smp_mb__after_test_and_set_bit() at the end of
tasklet_trylock() should remedy the situation.  As
smp_mb__{before|after}_test_and_set_bit() don't exist yet, I'm
attaching a patch which adds smp_mb__after_clear_bit().  The patch is
against 2.4.21.

P.S. Please comment on the addition of
smp_mb__{before|after}_test_and_set_bit().

P.P.S. One thing I don't really understand is the uses of smp_mb() at
the end of tasklet_disable() and smp_mb__before_atomic_dec() inside
tasklet_enable().  Can anybody tell me what those are for?

--
tejun

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.taskletrace"

# This is a BitKeeper generated patch for the following project:
# Project Name: linux
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.3     -> 1.4    
#	include/linux/interrupt.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/23	tj@atj.dyndns.org	1.4
# - tasklet race fix.
# --------------------------------------------
#
diff -Nru a/include/linux/interrupt.h b/include/linux/interrupt.h
--- a/include/linux/interrupt.h	Sat Aug 23 11:52:03 2003
+++ b/include/linux/interrupt.h	Sat Aug 23 11:52:03 2003
@@ -134,7 +134,10 @@
 #ifdef CONFIG_SMP
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
-	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
+	int ret;
+	ret = !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
+	smp_mb__after_clear_bit();
+	return ret;
 }
 
 static inline void tasklet_unlock(struct tasklet_struct *t)

--tKW2IUtsqtDRztdT--
