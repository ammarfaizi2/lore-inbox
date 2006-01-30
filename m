Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWA3JtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWA3JtI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWA3JtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:49:07 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:57761 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932179AbWA3JtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:49:05 -0500
Message-ID: <43DDF323.4517C349@tv-sign.ru>
Date: Mon, 30 Jan 2006 14:06:11 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] pidhash: don't use zero pids
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daemonize() calls set_special_pids(1,1), while init and
kernel threads spawned from init/main.c:init() run with
0,0 special pids. This patch changes INIT_SIGNALS() so
that that they run with ->pgrp == ->session == 1 also.

This patch relies on fact that swapper's pid == 1.

Now we never use pid == 0 in kernel/pid.c.

[ Andrew, this patch obsoletes "[PATCH] pid: Don't hash pid 0.",
  filename pid-dont-hash-pid-0.patch ].

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/include/linux/init_task.h~ZEROPID	2005-11-22 19:35:52.000000000 +0300
+++ RC-1/include/linux/init_task.h	2006-01-30 15:12:46.000000000 +0300
@@ -62,6 +62,8 @@
 	.posix_timers	 = LIST_HEAD_INIT(sig.posix_timers),		\
 	.cpu_timers	= INIT_CPU_TIMERS(sig.cpu_timers),		\
 	.rlim		= INIT_RLIMITS,					\
+	.pgrp		= 1,						\
+	.session	= 1,						\
 }
 
 #define INIT_SIGHAND(sighand) {						\
