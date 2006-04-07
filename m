Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWDGOfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWDGOfL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWDGOc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:28 -0400
Received: from [151.97.230.9] ([151.97.230.9]:34268 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932344AbWDGOcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:23 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 14/17] uml: fix big stack user
Date: Fri, 07 Apr 2006 16:31:22 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143122.19201.48879.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Switch this proc from storing 4k of data (a whole path) on the stack to keeping
it on the heap.

Maybe it's not called in process context but only in early boot context (where
in UML you have a normal process stack on the host) but just to be safe, fix it.

While at it some little readability simplifications.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/mem.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 6ab372d..71bb90a 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -53,33 +53,36 @@ static void __init find_tempdir(void)
  */
 int make_tempfile(const char *template, char **out_tempname, int do_unlink)
 {
-	char tempname[MAXPATHLEN];
+	char *tempname;
 	int fd;
 
+	tempname = malloc(MAXPATHLEN);
+
 	find_tempdir();
-	if (*template != '/')
+	if (template[0] != '/')
 		strcpy(tempname, tempdir);
 	else
-		*tempname = 0;
+		tempname[0] = '\0';
 	strcat(tempname, template);
 	fd = mkstemp(tempname);
 	if(fd < 0){
 		fprintf(stderr, "open - cannot create %s: %s\n", tempname,
 			strerror(errno));
-		return -1;
+		goto out;
 	}
 	if(do_unlink && (unlink(tempname) < 0)){
 		perror("unlink");
-		return -1;
+		goto out;
 	}
 	if(out_tempname){
-		*out_tempname = strdup(tempname);
-		if(*out_tempname == NULL){
-			perror("strdup");
-			return -1;
-		}
+		*out_tempname = tempname;
+	} else {
+		free(tempname);
 	}
 	return(fd);
+out:
+	free(tempname);
+	return -1;
 }
 
 #define TEMPNAME_TEMPLATE "vm_file-XXXXXX"
