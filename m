Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269756AbUJALP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269756AbUJALP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 07:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269759AbUJALP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 07:15:29 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:4769 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S269756AbUJALPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 07:15:19 -0400
Message-ID: <415D3DD7.57221E60@tv-sign.ru>
Date: Fri, 01 Oct 2004 15:21:59 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/2] detach_pid(): eliminate one find_pid() call
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Now there is no point in calling costly find_pid(type)
if __detach_pid(type) returned non zero value.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.9-rc3/kernel/pid.c~	Fri Oct  1 13:29:14 2004
+++ 2.6.9-rc3/kernel/pid.c	Fri Oct  1 15:12:32 2004
@@ -206,15 +206,16 @@ static fastcall int __detach_pid(task_t 
 
 void fastcall detach_pid(task_t *task, enum pid_type type)
 {
-	int nr;
+	int tmp, nr;
 
 	nr = __detach_pid(task, type);
 	if (!nr)
 		return;
 
-	for (type = 0; type < PIDTYPE_MAX; ++type)
-		if (find_pid(type, nr))
+	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
+		if (tmp != type && find_pid(tmp, nr))
 			return;
+
 	free_pidmap(nr);
 }
