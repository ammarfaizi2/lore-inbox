Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVLKQHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVLKQHI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 11:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVLKQHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 11:07:08 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:4078 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750719AbVLKQHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 11:07:07 -0500
Message-ID: <439C6045.D48876F9@tv-sign.ru>
Date: Sun, 11 Dec 2005 20:22:13 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org
Cc: orenl@cs.columbia.edu, roland@redhat.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [PATCH ? 1/2] setpgid: should not accept ptraced childs
References: <200512110523.jBB5NVEr002551@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_setpgid() allows to change ->pgrp of ptraced childs.

'man setpgid' does not tell anything about that, so I consider
this behaviour is a bug.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc5/kernel/sys.c~	2005-11-22 19:35:32.000000000 +0300
+++ 2.6.15-rc5/kernel/sys.c	2005-12-11 22:40:33.000000000 +0300
@@ -1106,7 +1106,7 @@ asmlinkage long sys_setpgid(pid_t pid, p
 	if (!thread_group_leader(p))
 		goto out;
 
-	if (p->parent == current || p->real_parent == current) {
+	if (p->real_parent == current) {
 		err = -EPERM;
 		if (p->signal->session != current->signal->session)
 			goto out;
