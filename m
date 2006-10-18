Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422866AbWJRUPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422866AbWJRUPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422837AbWJRUP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:15:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:45983 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422869AbWJRUPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:15:20 -0400
Message-ID: <45368B58.1000808@fr.ibm.com>
Date: Wed, 18 Oct 2006 22:15:20 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>
Subject: Re: [PATCH] add process_session() helper routine
References: <45349658.9060805@fr.ibm.com> <20061017145142.518e4046.akpm@osdl.org>
In-Reply-To: <20061017145142.518e4046.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> We should rename signal_struct.session to something else
> (session_dont_use_me_directly) so that any code which accidentally fails to
> use the wrapper will reliably fail to build.

yes. I think we should do that when the code is complete.

> That means that we'll also need a helper function to set this field.

Below is an experiment with an anonymous union and ((deprecated)) to catch
usage of such attributes. Just an idea.

C.


---
 include/linux/init_task.h |    3 ++-
 include/linux/sched.h     |    9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

Index: 2.6.19-rc2-mm1/include/linux/sched.h
===================================================================
--- 2.6.19-rc2-mm1.orig/include/linux/sched.h
+++ 2.6.19-rc2-mm1/include/linux/sched.h
@@ -437,7 +437,12 @@ struct signal_struct {
        /* job control IDs */
        pid_t pgrp;
        pid_t tty_old_pgrp;
-       pid_t session;
+
+       union {
+               pid_t session __attribute ((deprecated));
+               pid_t __session;
+       };
+
        /* boolean value for session group leader */
        int leader;

@@ -1070,7 +1075,7 @@ static inline pid_t process_group(struct

 static inline pid_t process_session(struct task_struct *tsk)
 {
-       return tsk->signal->session;
+       return tsk->signal->__session;
 }

 static inline struct pid *task_pid(struct task_struct *task)
Index: 2.6.19-rc2-mm1/include/linux/init_task.h
===================================================================
--- 2.6.19-rc2-mm1.orig/include/linux/init_task.h
+++ 2.6.19-rc2-mm1/include/linux/init_task.h
@@ -68,7 +68,8 @@
        .cpu_timers     = INIT_CPU_TIMERS(sig.cpu_timers),              \
        .rlim           = INIT_RLIMITS,                                 \
        .pgrp           = 1,                                            \
-       .session        = 1,                                            \
+       .tty_old_pgrp   = 0,                                            \
+       { .session      = 1},                                           \
 }

 extern struct nsproxy init_nsproxy;

