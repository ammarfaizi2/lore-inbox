Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbULGPCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbULGPCV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbULGPBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:01:35 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:46317 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261825AbULGPA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:00:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Dec 2004 15:37:11 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uml devel <user-mode-linux-devel@lists.sourceforge.net>,
       Jeff Dike <jdike@addtoit.com>,
       Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [patch] uml: fix umldir init order
Message-ID: <20041207143711.GA23612@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup initialization order when creating the $HOME/.uml/<umid>
directory and the files therein, also make the error messages
more useful.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/kernel/umid.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

Index: uml-2.6.9-rc2/arch/um/kernel/umid.c
===================================================================
--- uml-2.6.9-rc2.orig/arch/um/kernel/umid.c	2004-09-16 16:34:52.644479658 +0200
+++ uml-2.6.9-rc2/arch/um/kernel/umid.c	2004-09-16 16:37:09.347268895 +0200
@@ -92,8 +92,8 @@ static int __init create_pid_file(void)
 	fd = os_open_file(file, of_create(of_excl(of_rdwr(OPENFLAGS()))), 
 			  0644);
 	if(fd < 0){
-		printf("Open of machine pid file \"%s\" failed - "
-		       "err = %d\n", file, -fd);
+		printf("Open of machine pid file \"%s\" failed: %s\n",
+		       file, strerror(-fd));
 		return 0;
 	}
 
@@ -247,7 +247,7 @@ static int __init make_uml_dir(void)
 	strcpy(uml_dir, dir);
 	
 	if((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)){
-	        printf("Failed to mkdir %s - errno = %i\n", uml_dir, errno);
+	        printf("Failed to mkdir %s: %s\n", uml_dir, strerror(errno));
 		return(-1);
 	}
 	return 0;
@@ -264,8 +264,8 @@ static int __init make_umid(int (*printe
 		strcat(tmp, "XXXXXX");
 		fd = mkstemp(tmp);
 		if(fd < 0){
-			(*printer)("make_umid - mkstemp failed, errno = %d\n",
-				   errno);
+			(*printer)("make_umid - mkstemp(%s) failed: %s\n",
+				   tmp,strerror(errno));
 			return(1);
 		}
 
@@ -303,15 +303,14 @@ __uml_setup("uml_dir=", set_uml_dir,
 "    The location to place the pid and umid files.\n\n"
 );
 
-__uml_postsetup(make_uml_dir);
-
 static int __init make_umid_setup(void)
 {
-	return(make_umid(printf));
+	/* one function with the ordering we need ... */
+	make_uml_dir();
+	make_umid(printf);
+	return create_pid_file();
 }
-
 __uml_postsetup(make_umid_setup);
-__uml_postsetup(create_pid_file);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.

-- 
#define printk(args...) fprintf(stderr, ## args)
