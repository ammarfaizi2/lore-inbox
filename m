Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbUJYPKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbUJYPKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUJYPIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:08:25 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:425 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261878AbUJYOtY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:49:24 -0400
Cc: raven@themaw.net
Subject: [PATCH 21/28] HOTPLUG: Hack to allow for call to execve
In-Reply-To: <10987157204162@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:49:10 -0400
Message-Id: <1098715750856@sun.com>
References: <10987157204162@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a hack while we don't have a proper way for code to call
execve. It simply introduces call_usermodehelper_execve(path, argv, envp)
that call the execve syscall with an errno set.

We need to figure out a proper way for code to call execve!

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 include/linux/kmod.h |    1 +
 kernel/kmod.c        |    7 +++++++
 2 files changed, 8 insertions(+)

Index: linux-2.6.9-quilt/kernel/kmod.c
===================================================================
--- linux-2.6.9-quilt.orig/kernel/kmod.c	2004-10-22 17:17:44.279732600 -0400
+++ linux-2.6.9-quilt/kernel/kmod.c	2004-10-22 17:17:44.879641400 -0400
@@ -278,6 +278,13 @@ int call_usermodehelper_cb(call_usermode
 }
 EXPORT_SYMBOL(call_usermodehelper_cb);
 
+/* This is an ugly hack while the __KERNEL_SYSCALLS__ cleanup occurs */
+int call_usermodehelper_execve(char *path, char *argv[], char *envp[])
+{
+	return execve(path, argv, envp);
+}
+EXPORT_SYMBOL(call_usermodehelper_execve);
+
 static int call_usermodehelper_simple(void *cbdata)
 {
 	struct simple_usermodehelper_info *info = cbdata;
Index: linux-2.6.9-quilt/include/linux/kmod.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/kmod.h	2004-10-22 17:17:44.279732600 -0400
+++ linux-2.6.9-quilt/include/linux/kmod.h	2004-10-22 17:17:44.879641400 -0400
@@ -36,6 +36,7 @@ static inline int request_module(const c
 #define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
 typedef int (*call_usermodehelper_cb_t)(void *cbdata);
 extern int call_usermodehelper_cb(call_usermodehelper_cb_t cb, void *cbdata, int wait);
+extern int call_usermodehelper_execve(char *path, char *argv[], char *envp[]);
 extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 
 #ifdef CONFIG_HOTPLUG

