Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269289AbUIYJO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269289AbUIYJO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 05:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269290AbUIYJO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 05:14:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8969 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269289AbUIYJOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 05:14:03 -0400
Date: Sat, 25 Sep 2004 10:13:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Add wait_event_timeout()
Message-ID: <20040925091359.GA4431@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be one case missing from the wait_event() family -
the uninterruptible timeout wait.  The following patch adds this.

This wait is particularly useful when (eg) you wish to pass work off
to an interrupt handler to perform, but also want to know if the
hardware has decided to go gaga under you.  You don't want to sit
around waiting for something that'll never happen - you want to go
and wack the gremlin which caused the failure and retry.

--- linux/include/linux/wait.h.orig	2004-09-21 13:07:07.000000000 +0100
+++ linux/include/linux/wait.h	2004-09-25 09:33:19.000000000 +0100
@@ -156,6 +156,29 @@
 	__wait_event(wq, condition);					\
 } while (0)
 
+#define __wait_event_timeout(wq, condition, ret)			\
+do {									\
+	DEFINE_WAIT(__wait);						\
+									\
+	for (;;) {							\
+		prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);	\
+		if (condition)						\
+			break;						\
+		ret = schedule_timeout(ret);				\
+		if (!ret)						\
+			break;						\
+	}								\
+	finish_wait(&wq, &__wait);					\
+} while (0)
+
+#define wait_event_timeout(wq, condition, timeout)			\
+({									\
+	long __ret = timeout;						\
+	if (!(condition)) 						\
+		__wait_event_timeout(wq, condition, __ret);		\
+	__ret;								\
+})
+
 #define __wait_event_interruptible(wq, condition, ret)			\
 do {									\
 	DEFINE_WAIT(__wait);						\

