Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285430AbRLNRfJ>; Fri, 14 Dec 2001 12:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285433AbRLNRe7>; Fri, 14 Dec 2001 12:34:59 -0500
Received: from hera.cwi.nl ([192.16.191.8]:10973 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S285430AbRLNRew>;
	Fri, 14 Dec 2001 12:34:52 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 14 Dec 2001 17:34:48 GMT
Message-Id: <UTC200112141734.RAA20953.aeb@cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] kill(-1,sig)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new POSIX 1003.1-2001 is explicit about what kill(-1,sig)
is supposed to do. Maybe we should follow it.

Andries

--- signal.c~	Thu Nov 22 01:26:27 2001
+++ signal.c	Fri Dec 14 18:27:34 2001
@@ -649,8 +649,10 @@
 /*
  * kill_something_info() interprets pid in interesting ways just like kill(2).
  *
- * POSIX specifies that kill(-1,sig) is unspecified, but what we have
- * is probably wrong.  Should make it like BSD or SYSV.
+ * POSIX (2001) specifies "If pid is -1, sig shall be sent to all processes
+ * (excluding an unspecified set of system processes) for which the process
+ * has permission to send that signal."
+ * So, probably the process should also signal itself.
  */
 
 static int kill_something_info(int sig, struct siginfo *info, int pid)
@@ -663,7 +665,7 @@
 
 		read_lock(&tasklist_lock);
 		for_each_task(p) {
-			if (p->pid > 1 && p != current) {
+			if (p->pid > 1) {
 				int err = send_sig_info(sig, info, p);
 				++count;
 				if (err != -EPERM)
