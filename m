Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWADU75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWADU75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWADU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:59:56 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:51614 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750911AbWADU7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:59:55 -0500
Message-Id: <200601042152.k04Lq0nc009242@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/9] UML - add mconsole_reply variant with length param
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jan 2006 16:52:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed for the console output patch, since we have a
possibly non-NULL-terminated string there.  So, the new interface
takes a string and a length, and the old interface calls strlen on
its string and calls the new interface with the length.

There's also a bit of whitespace cleanup.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_user.c	2005-11-30 12:48:57.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_user.c	2005-12-28 23:22:37.000000000 -0500
@@ -122,12 +122,12 @@ int mconsole_get_request(int fd, struct 
 	return(1);
 }
 
-int mconsole_reply(struct mc_request *req, char *str, int err, int more)
+int mconsole_reply_len(struct mc_request *req, const char *str, int total,
+		       int err, int more)
 {
 	struct mconsole_reply reply;
-	int total, len, n;
+	int len, n;
 
-	total = strlen(str);
 	do {
 		reply.err = err;
 
@@ -155,6 +155,12 @@ int mconsole_reply(struct mc_request *re
 	return(0);
 }
 
+int mconsole_reply(struct mc_request *req, const char *str, int err, int more)
+{
+	return mconsole_reply_len(req, str, strlen(str), err, more);
+}
+
+
 int mconsole_unlink_socket(void)
 {
 	unlink(mconsole_socket_name);
Index: linux-2.6.15/arch/um/include/mconsole.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/mconsole.h	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/include/mconsole.h	2005-12-29 11:52:19.000000000 -0500
@@ -32,7 +32,7 @@ struct mconsole_reply {
 
 struct mconsole_notify {
 	u32 magic;
-	u32 version;	
+	u32 version;
 	enum { MCONSOLE_SOCKET, MCONSOLE_PANIC, MCONSOLE_HANG,
 	       MCONSOLE_USER_NOTIFY } type;
 	u32 len;
@@ -66,7 +66,9 @@ struct mc_request
 extern char mconsole_socket_name[];
 
 extern int mconsole_unlink_socket(void);
-extern int mconsole_reply(struct mc_request *req, char *reply, int err,
+extern int mconsole_reply_len(struct mc_request *req, const char *reply,
+			      int len, int err, int more);
+extern int mconsole_reply(struct mc_request *req, const char *str, int err,
 			  int more);
 
 extern void mconsole_version(struct mc_request *req);
@@ -84,7 +86,7 @@ extern void mconsole_proc(struct mc_requ
 extern void mconsole_stack(struct mc_request *req);
 
 extern int mconsole_get_request(int fd, struct mc_request *req);
-extern int mconsole_notify(char *sock_name, int type, const void *data, 
+extern int mconsole_notify(char *sock_name, int type, const void *data,
 			   int len);
 extern char *mconsole_notify_socket(void);
 extern void lock_notify(void);

