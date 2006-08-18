Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWHRLqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWHRLqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWHRLqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:46:12 -0400
Received: from mail.gmx.de ([213.165.64.20]:47580 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030226AbWHRLqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:46:09 -0400
X-Authenticated: #5039886
Date: Fri, 18 Aug 2006 13:46:07 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Fix ____call_usermodehelper errors being silently ignored
Message-ID: <20060818114607.GA17429@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If ____call_usermodehelper fails, we're not interested in the child
process' exit value, but the real error, so let's stop wait_for_helper
from overwriting it in that case.

Issue discovered by Benedikt Böhm while working on a Linux-VServer
usermode helper.

Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>

--

diff --git a/kernel/kmod.c b/kernel/kmod.c
index 1d32def..eab8f31 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -176,6 +176,8 @@ static int wait_for_helper(void *data)
 	if (pid < 0) {
 		sub_info->retval = pid;
 	} else {
+		int ret;
+
 		/*
 		 * Normally it is bogus to call wait4() from in-kernel because
 		 * wait4() wants to write the exit code to a userspace address.
@@ -185,7 +187,15 @@ static int wait_for_helper(void *data)
 		 *
 		 * Thus the __user pointer cast is valid here.
 		 */
-		sys_wait4(pid, (int __user *) &sub_info->retval, 0, NULL);
+		sys_wait4(pid, (int __user *)&ret, 0, NULL);
+
+		/*
+		 * If ret is 0, either ____call_usermodehelper failed and the
+		 * real error code is already in sub_info->retval or
+		 * sub_info->retval is 0 anyway, so don't mess with it then.
+		 */
+		if (ret)
+			sub_info->retval = ret;
 	}
 
 	complete(sub_info->complete);
