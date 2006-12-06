Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758884AbWLFAvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758884AbWLFAvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758889AbWLFAvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:51:16 -0500
Received: from twin.jikos.cz ([213.151.79.26]:44388 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758884AbWLFAvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:51:15 -0500
Date: Wed, 6 Dec 2006 01:51:01 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] let WARN_ON() output the condition
Message-ID: <Pine.LNX.4.64.0612060149220.28502@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] let WARN_ON() output the condition

It is possible, in some cases, that the output of WARN_ON() is ambiguous 
and can't be properly used to identify the exact condition which caused 
the warning to trigger. This happens whenever there is a macro that 
contains multiple WARN_ONs inside. Notable example is spin_lock_mutex(). 
If any of the two WARN_ONs trigger, we are not able to say which one was 
the cause (as we get only line number, which however belongs to the place 
where the macro was expanded).

This patch lets WARN_ON() to output also the condition and fixes the 
DEBUG_LOCKS_WARN_ON() macro to pass the condition properly to WARN_ON. The 
possible drawback could be when someone passes a condition which has 
sideeffects. Then it would be evaluated twice, instead of current one 
evaluation. On the other hand, when anyone passes expression with 
sideeffects to WARN_ON(), he is asking for problems anyway.

Patch against 2.6.19-rc6-mm2.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

 include/asm-generic/bug.h   |    4 ++--
 include/linux/debug_locks.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index a06eecd..af7574e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -35,8 +35,8 @@ #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) ({						\
 	typeof(condition) __ret_warn_on = (condition);			\
 	if (unlikely(__ret_warn_on)) {					\
-		printk("WARNING at %s:%d %s()\n", __FILE__,	\
-			__LINE__, __FUNCTION__);			\
+		printk("WARNING (%s) at %s:%d %s()\n", #condition,	\
+			__FILE__,__LINE__, __FUNCTION__);		\
 		dump_stack();						\
 	}								\
 	unlikely(__ret_warn_on);					\
diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 952bee7..1c2b682 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -25,7 +25,7 @@ ({									\
 									\
 	if (unlikely(c)) {						\
 		if (debug_locks_off())					\
-			WARN_ON(1);					\
+			WARN_ON(c);					\
 		__ret = 1;						\
 	}								\
 	__ret;								\
