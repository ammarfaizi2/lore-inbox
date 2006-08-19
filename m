Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWHSHae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWHSHae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 03:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWHSHae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 03:30:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:42200 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932523AbWHSHad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 03:30:33 -0400
X-Authenticated: #5039886
Date: Sat, 19 Aug 2006 09:30:31 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Return real errno from execve in ____call_usermodehelper
Message-ID: <20060819073031.GA25711@atjola.homenet>
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

If execve fails in ____call_usermodehelper we treat its return value as
error code, but as execve is a syscall, we actually want -errno there.

Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>

--

diff --git a/kernel/kmod.c b/kernel/kmod.c
index 1d32def..865abc0 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -149,8 +149,10 @@ static int ____call_usermodehelper(void 
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
 	retval = -EPERM;
-	if (current->fs->root)
-		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
+	if (current->fs->root) {
+		execve(sub_info->path, sub_info->argv, sub_info->envp);
+		retval = -errno;
+	}
 
 	/* Exec failed? */
 	sub_info->retval = retval;

