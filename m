Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVEKPXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVEKPXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEKPXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:23:18 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:12459 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261248AbVEKPVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:21:07 -0400
Message-ID: <428222CF.3070002@sw.ru>
Date: Wed, 11 May 2005 19:20:47 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, pavel@ucw.cz
Subject: [PATCH] Software suspend and recalc sigpending bug fix
Content-Type: multipart/mixed;
 boundary="------------070607090403040800090808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607090403040800090808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes recalc_sigpending() to work correctly
with tasks which are being freezed. The problem is that
freeze_processes() sets PF_FREEZE and TIF_SIGPENDING
flags on tasks, but recalc_sigpending() called from
e.g. sys_rt_sigtimedwait or any other kernel place
will clear TIF_SIGPENDING due to no pending signals queued
and the tasks won't be freezed until it recieves a real signal
or freezed_processes() fail due to timeout.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>
Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

--------------070607090403040800090808
Content-Type: text/plain;
 name="diff-mainstream-freezesigrecalc-20050429"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-mainstream-freezesigrecalc-20050429"

--- ./kernel/signal.c.freezesigrec	2005-05-10 16:10:40.000000000 +0400
+++ ./kernel/signal.c	2005-05-10 18:10:08.000000000 +0400
@@ -212,6 +212,7 @@ static inline int has_pending_signals(si
 fastcall void recalc_sigpending_tsk(struct task_struct *t)
 {
 	if (t->signal->group_stop_count > 0 ||
+	    (t->flags&PF_FREEZE) ||
 	    PENDING(&t->pending, &t->blocked) ||
 	    PENDING(&t->signal->shared_pending, &t->blocked))
 		set_tsk_thread_flag(t, TIF_SIGPENDING);

--------------070607090403040800090808--

