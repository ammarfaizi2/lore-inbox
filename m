Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316781AbSEaUki>; Fri, 31 May 2002 16:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316782AbSEaUkh>; Fri, 31 May 2002 16:40:37 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:55563 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316781AbSEaUkf>;
	Fri, 31 May 2002 16:40:35 -0400
Date: Fri, 31 May 2002 22:41:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: [PATCH] kbuild: Remove 2048 symbol limit in tkparse
Message-ID: <20020531224151.A13857@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tkparse limit the number of symbols to 2048.
This patch makes the array dynamic avoiding this problem in the future.
The problem showed up in one of the powerpc tree's.

Credit for this patch goes to Keith Owens, I just extracted it from kbuild-2.5.

	Sam

--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="no2048.diff"

--- tkparse.h.orig	Fri May 31 22:03:24 2002
+++ tkparse.h	Fri May 31 21:42:03 2002
@@ -115,7 +115,7 @@
     char	global_written;
 };
 
-extern struct variable vartable[];
+extern struct variable *vartable;
 extern int max_varnum;
 
 /*
--- tkparse.c.orig	Fri May 31 22:03:14 2002
+++ tkparse.c	Fri May 31 21:42:03 2002
@@ -74,12 +74,12 @@
 
 
 /*
- * Find index of a specyfic variable in the symbol table.
+ * Find index of a specific variable in the symbol table.
  * Create a new entry if it does not exist yet.
  */
-#define VARTABLE_SIZE 4096
-struct variable vartable[VARTABLE_SIZE];
+struct variable *vartable;
 int max_varnum = 0;
+static int vartable_size = 0;
 
 int get_varnum( char * name )
 {
@@ -88,8 +88,13 @@
     for ( i = 1; i <= max_varnum; i++ )
 	if ( strcmp( vartable[i].name, name ) == 0 )
 	    return i;
-    if (max_varnum > VARTABLE_SIZE-1)
-	syntax_error( "Too many variables defined." );
+    while (max_varnum+1 >= vartable_size) {
+	vartable = realloc(vartable, (vartable_size += 1000)*sizeof(*vartable));
+	if (!vartable) {
+	    fprintf(stderr, "tkparse realloc vartable failed\n");
+	    exit(1);
+	}
+    }
     vartable[++max_varnum].name = malloc( strlen( name )+1 );
     strcpy( vartable[max_varnum].name, name );
     return max_varnum;
@@ -818,5 +823,6 @@
     do_source        ( "-"         );
     fix_conditionals ( config_list );
     dump_tk_script   ( config_list );
+    free(vartable);
     return 0;
 }

--gE7i1rD7pdK0Ng3j--
