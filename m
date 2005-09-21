Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVIURtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVIURtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVIURtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:49:01 -0400
Received: from [151.97.230.9] ([151.97.230.9]:17859 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751342AbVIURsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:48:54 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 01/10] uml: don't remove umid files in conflict case
Date: Wed, 21 Sep 2005 19:27:38 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921172737.10219.71614.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Only remove the UML pidfile and management socket if we created them.
Currently in case two UMLs are started with the same umid, the second will
remove the first's ones.

Probably we should also panic() at that point, not sure however.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/umid.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/um/kernel/umid.c b/arch/um/kernel/umid.c
--- a/arch/um/kernel/umid.c
+++ b/arch/um/kernel/umid.c
@@ -31,6 +31,8 @@ static char *uml_dir = UML_DIR;
 /* Changed by set_umid */
 static int umid_is_random = 1;
 static int umid_inited = 0;
+/* Have we created the files? Should we remove them? */
+static int umid_owned = 0;
 
 static int make_umid(int (*printer)(const char *fmt, ...));
 
@@ -82,20 +84,21 @@ int __init umid_file_name(char *name, ch
 
 extern int tracing_pid;
 
-static int __init create_pid_file(void)
+static void __init create_pid_file(void)
 {
 	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
 	char pid[sizeof("nnnnn\0")];
 	int fd, n;
 
-	if(umid_file_name("pid", file, sizeof(file))) return 0;
+	if(umid_file_name("pid", file, sizeof(file)))
+		return;
 
 	fd = os_open_file(file, of_create(of_excl(of_rdwr(OPENFLAGS()))), 
 			  0644);
 	if(fd < 0){
 		printf("Open of machine pid file \"%s\" failed: %s\n",
 		       file, strerror(-fd));
-		return 0;
+		return;
 	}
 
 	sprintf(pid, "%d\n", os_getpid());
@@ -103,7 +106,6 @@ static int __init create_pid_file(void)
 	if(n != strlen(pid))
 		printf("Write of pid file failed - err = %d\n", -n);
 	os_close_file(fd);
-	return 0;
 }
 
 static int actually_do_remove(char *dir)
@@ -147,7 +149,8 @@ static int actually_do_remove(char *dir)
 void remove_umid_dir(void)
 {
 	char dir[strlen(uml_dir) + UMID_LEN + 1];
-	if(!umid_inited) return;
+	if (!umid_owned)
+		return;
 
 	sprintf(dir, "%s%s", uml_dir, umid);
 	actually_do_remove(dir);
@@ -155,11 +158,12 @@ void remove_umid_dir(void)
 
 char *get_umid(int only_if_set)
 {
-	if(only_if_set && umid_is_random) return(NULL);
-	return(umid);
+	if(only_if_set && umid_is_random)
+		return NULL;
+	return umid;
 }
 
-int not_dead_yet(char *dir)
+static int not_dead_yet(char *dir)
 {
 	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
 	char pid[sizeof("nnnnn\0")], *end;
@@ -193,7 +197,8 @@ int not_dead_yet(char *dir)
 		   (p == CHOOSE_MODE(tracing_pid, os_getpid())))
 			dead = 1;
 	}
-	if(!dead) return(1);
+	if(!dead)
+		return(1);
 	return(actually_do_remove(dir));
 }
 
@@ -286,6 +291,7 @@ static int __init make_umid(int (*printe
 		if(errno == EEXIST){
 			if(not_dead_yet(tmp)){
 				(*printer)("umid '%s' is in use\n", umid);
+				umid_owned = 0;
 				return(-1);
 			}
 			err = mkdir(tmp, 0777);
@@ -296,7 +302,8 @@ static int __init make_umid(int (*printe
 		return(-1);
 	}
 
-	return(0);
+	umid_owned = 1;
+	return 0;
 }
 
 __uml_setup("uml_dir=", set_uml_dir,
@@ -309,7 +316,8 @@ static int __init make_umid_setup(void)
 	/* one function with the ordering we need ... */
 	make_uml_dir();
 	make_umid(printf);
-	return create_pid_file();
+	create_pid_file();
+	return 0;
 }
 __uml_postsetup(make_umid_setup);
 

