Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbVIURt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVIURt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVIURs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:48:57 -0400
Received: from [151.97.230.9] ([151.97.230.9]:14275 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751339AbVIURsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:48:53 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 02/10] strlcat: use for uml umid.c
Date: Wed, 21 Sep 2005 19:28:15 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921172815.10219.19512.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Simplify the code by using strlcat() instead of strncat() and manual
appending.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/user.h |    4 +++-
 arch/um/kernel/umid.c  |   11 ++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/user.h b/arch/um/include/user.h
--- a/arch/um/include/user.h
+++ b/arch/um/include/user.h
@@ -14,7 +14,9 @@ extern void *um_kmalloc_atomic(int size)
 extern void kfree(void *ptr);
 extern int in_aton(char *str);
 extern int open_gdb_chan(void);
-extern int strlcpy(char *, const char *, int);
+/* These use size_t, however unsigned long is correct on both i386 and x86_64. */
+extern unsigned long strlcpy(char *, const char *, unsigned long);
+extern unsigned long strlcat(char *, const char *, unsigned long);
 extern void *um_vmalloc(int size);
 extern void vfree(void *ptr);
 
diff --git a/arch/um/kernel/umid.c b/arch/um/kernel/umid.c
--- a/arch/um/kernel/umid.c
+++ b/arch/um/kernel/umid.c
@@ -237,16 +237,13 @@ static int __init make_uml_dir(void)
 		strlcpy(dir, home, sizeof(dir));
 		uml_dir++;
 	}
+	strlcat(dir, uml_dir, sizeof(dir));
 	len = strlen(dir);
-	strncat(dir, uml_dir, sizeof(dir) - len);
-	len = strlen(dir);
-	if((len > 0) && (len < sizeof(dir) - 1) && (dir[len - 1] != '/')){
-		dir[len] = '/';
-		dir[len + 1] = '\0';
-	}
+	if (len > 0 && dir[len - 1] != '/')
+		strlcat(dir, "/", sizeof(dir));
 
 	uml_dir = malloc(strlen(dir) + 1);
-	if(uml_dir == NULL){
+	if (uml_dir == NULL) {
 		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
 		exit(1);
 	}

