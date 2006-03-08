Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWCHUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWCHUwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWCHUwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:52:54 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:55694 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932228AbWCHUwx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:52:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=msQ6CWibBd3KoNZYZ4sA2PEXlG6bCkiiD3+81Ag122v7UEsiRO3kxWzFTzocqQfmGkNPuI01M0gpJZafyKglDRk96Sn+lLJQ4D8UBA1OJmI8EqTN6VVhZlVO9od4Rgqtzlqlpp3VJM+ojEwJJkrsP9pqi1THGlCOygHENAKa3a8=
Message-ID: <728201270603081252v3cb2743dwcb18d99f132cf531@mail.gmail.com>
Date: Wed, 8 Mar 2006 14:52:52 -0600
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "linux mailing-list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] capability: Fix bug in checking capabilties in ptrace system call
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug of ptrace for PTRACE_TRACEME request. In this
case the call is made by the child process & code needs to check the
capabilty of the parent process to trace the child process but code
incorrectly makes check for the child process.

Signed-off-by: Ram Gupta <ram.gupta5@gmail.com>

--- linux-2.6.14-patch-2.6.15/security/commoncap.c.orig Wed Mar  8 13:54:06 2006
+++ linux-2.6.14-patch-2.6.15/security/commoncap.c      Wed Mar  8 13:57:07 2006
@@ -59,9 +59,13 @@ int cap_settime(struct timespec *ts, str
 int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
        /* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
-       if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
-           !capable(CAP_SYS_PTRACE))
-               return -EPERM;
+       if (!cap_issubset (child->cap_permitted, current->cap_permitted)){
+               if(!security_ops->capable(parent,CAP_SYS_PTRACE)){
+                       parent->flags |= PF_SUPERPRIV;
+               }
+               else
+                       return -EPERM;
+       }
        return 0;
 }

Regards
Ram Gupta
