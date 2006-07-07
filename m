Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWGGAjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWGGAjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWGGAeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:34:12 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:52675 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751112AbWGGAdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:49 -0400
Message-Id: <200607070033.k670XrGr008742@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 17/19] UML - Add some EINTR protection
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some more uses of the CATCH_EINTR wrapper.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/drivers/net_user.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/net_user.c	2006-07-05 20:54:02.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/net_user.c	2006-07-05 21:04:12.000000000 -0400
@@ -105,9 +105,7 @@ int net_recvfrom(int fd, void *buf, int 
 {
 	int n;
 
-	while(((n = recvfrom(fd,  buf,  len, 0, NULL, NULL)) < 0) && 
-	      (errno == EINTR)) ;
-
+	CATCH_EINTR(n = recvfrom(fd,  buf,  len, 0, NULL, NULL));
 	if(n < 0){
 		if(errno == EAGAIN)
 			return 0;
@@ -135,7 +133,7 @@ int net_send(int fd, void *buf, int len)
 {
 	int n;
 
-	while(((n = send(fd, buf, len, 0)) < 0) && (errno == EINTR)) ;
+	CATCH_EINTR(n = send(fd, buf, len, 0));
 	if(n < 0){
 		if(errno == EAGAIN)
 			return 0;
@@ -150,8 +148,8 @@ int net_sendto(int fd, void *buf, int le
 {
 	int n;
 
-	while(((n = sendto(fd, buf, len, 0, (struct sockaddr *) to,
-			   sock_len)) < 0) && (errno == EINTR)) ;
+	CATCH_EINTR(n = sendto(fd, buf, len, 0, (struct sockaddr *) to,
+			       sock_len));
 	if(n < 0){
 		if(errno == EAGAIN)
 			return 0;
Index: linux-2.6.17/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/file.c	2006-07-05 21:04:02.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/file.c	2006-07-05 21:04:12.000000000 -0400
@@ -18,6 +18,7 @@
 #include "os.h"
 #include "user.h"
 #include "kern_util.h"
+#include "user_util.h"
 
 static void copy_stat(struct uml_stat *dst, struct stat64 *src)
 {
@@ -42,10 +43,7 @@ int os_stat_fd(const int fd, struct uml_
 	struct stat64 sbuf;
 	int err;
 
-	do {
-		err = fstat64(fd, &sbuf);
-	} while((err < 0) && (errno == EINTR)) ;
-
+	CATCH_EINTR(err = fstat64(fd, &sbuf));
 	if(err < 0)
 		return -errno;
 

