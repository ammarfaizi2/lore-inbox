Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752040AbWCJTua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbWCJTua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWCJTua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:50:30 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:50985 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751424AbWCJTua convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:50:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nlR04RsrhTErWPuhh7WCupYuS8eBYQxldc88bc3X1UhJkMTctAsAqKN73mUGQSX1d9hogqVk/cf5Aql+Kx2y5jx0T8gXM2G6h2lVWQD867WKPrhHGfkr4L4X2EyxwOWyC6x7GSdypffTCVeVHfkzjtPq5bYBzaF5KxV5z6jYJGY=
Message-ID: <728201270603101150u20c20d86s851a2885de08e37@mail.gmail.com>
Date: Fri, 10 Mar 2006 19:50:27 +0000
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "linux mailing-list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] security: fix capability bug
Cc: "Andrew Morton" <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug of ptrace for PTRACE_TRACEME request. In this
case the call is made by the child process & code needs to check the
capabilty of the parent process to trace the child process but code
incorrectly makes check for the child process. Please apply

Signed-off-by: Ram Gupta <ram.gupta5@gmail.com>
----
-- linux-2.6.15.6-rg/security/commoncap.c.orig 2006-03-10
13:22:26.000000000 +0000
+++ linux-2.6.15.6-rg/security/commoncap.c      2006-03-10
13:26:45.000000000 +0000
@@ -59,9 +59,13 @@ int cap_settime(struct timespec *ts, str
 int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
        /* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
-       if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
-           !capable(CAP_SYS_PTRACE))
-               return -EPERM;
+       if (!cap_issubset (child->cap_permitted, parent->cap_permitted)){
+               if(!cap_capable(parent,CAP_SYS_PTRACE)){
+                       parent->flags |= PF_SUPERPRIV;
+               }
+               else
+                       return -EPERM;
+       }
        return 0;
 }

regards
Ram Gupta
