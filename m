Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVDHJXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVDHJXm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 05:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVDHJXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 05:23:42 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:16720
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262759AbVDHJXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 05:23:22 -0400
Date: Fri, 8 Apr 2005 11:23:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050408073431.GA5463@ds9.ch>
Message-ID: <Pine.LNX.4.62.0504081119050.29212@anakin>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408073431.GA5463@ds9.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Marcel Lanz wrote:
> git on sarge
> 
> --- git-0.02/Makefile.orig      2005-04-07 23:06:19.000000000 +0200
> +++ git-0.02/Makefile   2005-04-08 09:24:28.472672224 +0200
> @@ -8,7 +8,7 @@ all: $(PROG)
>  install: $(PROG)
>         install $(PROG) $(HOME)/bin/
>  
> -LIBS= -lssl
> +LIBS= -lssl -lz
>  
>  init-db: init-db.o
>  

I found a few more `issues' after adding `-O3 -Wall'.
Most are cosmetic, but the missing return value in remove_file_from_cache() is
a real bug. Hmm, upon closer look the caller uses its return value in a weird
way, so another bug may be hiding in add_file_to_cache().

Caveat: everything is untested, besides compilation ;-)

diff -purN git-0.02.orig/Makefile git-0.02/Makefile
--- git-0.02.orig/Makefile	2005-04-07 23:06:19.000000000 +0200
+++ git-0.02/Makefile	2005-04-08 11:02:02.000000000 +0200
@@ -1,4 +1,4 @@
-CFLAGS=-g
+CFLAGS=-g -O3 -Wall
 CC=gcc
 
 PROG=update-cache show-diff init-db write-tree read-tree commit-tree cat-file
@@ -8,7 +8,7 @@ all: $(PROG)
 install: $(PROG)
 	install $(PROG) $(HOME)/bin/
 
-LIBS= -lssl
+LIBS= -lssl -lz
 
 init-db: init-db.o
 
diff -purN git-0.02.orig/cat-file.c git-0.02/cat-file.c
--- git-0.02.orig/cat-file.c	2005-04-07 23:15:17.000000000 +0200
+++ git-0.02/cat-file.c	2005-04-08 11:07:28.000000000 +0200
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 
+#include <string.h>
+
 int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
@@ -25,4 +27,5 @@ int main(int argc, char **argv)
 	if (write(fd, buf, size) != size)
 		strcpy(type, "bad");
 	printf("%s: %s\n", template, type);
+	exit(0);
 }
diff -purN git-0.02.orig/commit-tree.c git-0.02/commit-tree.c
--- git-0.02.orig/commit-tree.c	2005-04-07 23:15:17.000000000 +0200
+++ git-0.02/commit-tree.c	2005-04-08 11:06:08.000000000 +0200
@@ -6,6 +6,7 @@
 #include "cache.h"
 
 #include <pwd.h>
+#include <string.h>
 #include <time.h>
 
 #define BLOCKING (1ul << 14)
diff -purN git-0.02.orig/init-db.c git-0.02/init-db.c
--- git-0.02.orig/init-db.c	2005-04-07 23:15:17.000000000 +0200
+++ git-0.02/init-db.c	2005-04-08 11:07:33.000000000 +0200
@@ -5,10 +5,12 @@
  */
 #include "cache.h"
 
+#include <string.h>
+
 int main(int argc, char **argv)
 {
 	char *sha1_dir = getenv(DB_ENVIRONMENT), *path;
-	int len, i, fd;
+	int len, i;
 
 	if (mkdir(".dircache", 0700) < 0) {
 		perror("unable to create .dircache");
@@ -25,7 +27,7 @@ int main(int argc, char **argv)
 	if (sha1_dir) {
 		struct stat st;
 		if (!stat(sha1_dir, &st) < 0 && S_ISDIR(st.st_mode))
-			return;
+			exit(1);
 		fprintf(stderr, "DB_ENVIRONMENT set to bad directory %s: ", sha1_dir);
 	}
 
diff -purN git-0.02.orig/read-cache.c git-0.02/read-cache.c
--- git-0.02.orig/read-cache.c	2005-04-07 23:23:43.000000000 +0200
+++ git-0.02/read-cache.c	2005-04-08 11:07:37.000000000 +0200
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 
+#include <string.h>
+
 const char *sha1_file_directory = NULL;
 struct cache_entry **active_cache = NULL;
 unsigned int active_nr = 0, active_alloc = 0;
@@ -89,7 +91,7 @@ void * read_sha1_file(unsigned char *sha
 	z_stream stream;
 	char buffer[8192];
 	struct stat st;
-	int i, fd, ret, bytes;
+	int fd, ret, bytes;
 	void *map, *buf;
 	char *filename = sha1_file_name(sha1);
 
@@ -173,7 +175,7 @@ int write_sha1_file(char *buf, unsigned 
 int write_sha1_buffer(unsigned char *sha1, void *buf, unsigned int size)
 {
 	char *filename = sha1_file_name(sha1);
-	int i, fd;
+	int fd;
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
 	if (fd < 0)
diff -purN git-0.02.orig/read-tree.c git-0.02/read-tree.c
--- git-0.02.orig/read-tree.c	2005-04-08 04:58:44.000000000 +0200
+++ git-0.02/read-tree.c	2005-04-08 11:07:41.000000000 +0200
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 
+#include <string.h>
+
 static void create_directories(const char *path)
 {
 	int len = strlen(path);
@@ -72,7 +74,6 @@ static int unpack(unsigned char *sha1)
 
 int main(int argc, char **argv)
 {
-	int fd;
 	unsigned char sha1[20];
 
 	if (argc != 2)
diff -purN git-0.02.orig/show-diff.c git-0.02/show-diff.c
--- git-0.02.orig/show-diff.c	2005-04-07 23:15:17.000000000 +0200
+++ git-0.02/show-diff.c	2005-04-08 11:07:44.000000000 +0200
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 
+#include <string.h>
+
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
 #define OWNER_CHANGED	0x0004
@@ -60,7 +62,6 @@ int main(int argc, char **argv)
 		struct stat st;
 		struct cache_entry *ce = active_cache[i];
 		int n, changed;
-		unsigned int mode;
 		unsigned long size;
 		char type[20];
 		void *new;
diff -purN git-0.02.orig/update-cache.c git-0.02/update-cache.c
--- git-0.02.orig/update-cache.c	2005-04-07 23:15:17.000000000 +0200
+++ git-0.02/update-cache.c	2005-04-08 11:08:55.000000000 +0200
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 
+#include <string.h>
+
 static int cache_name_compare(const char *name1, int len1, const char *name2, int len2)
 {
 	int len = len1 < len2 ? len1 : len2;
@@ -50,6 +52,7 @@ static int remove_file_from_cache(char *
 		if (pos < active_nr)
 			memmove(active_cache + pos, active_cache + pos + 1, (active_nr - pos - 1) * sizeof(struct cache_entry *));
 	}
+	return 0;
 }
 
 static int add_cache_entry(struct cache_entry *ce)
@@ -250,4 +253,5 @@ int main(int argc, char **argv)
 		return 0;
 out:
 	unlink(".dircache/index.lock");
+	exit(0);
 }
diff -purN git-0.02.orig/write-tree.c git-0.02/write-tree.c
--- git-0.02.orig/write-tree.c	2005-04-07 23:15:17.000000000 +0200
+++ git-0.02/write-tree.c	2005-04-08 11:07:51.000000000 +0200
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 
+#include <string.h>
+
 static int check_valid_sha1(unsigned char *sha1)
 {
 	char *filename = sha1_file_name(sha1);
@@ -31,7 +33,7 @@ static int prepend_integer(char *buffer,
 
 int main(int argc, char **argv)
 {
-	unsigned long size, offset, val;
+	unsigned long size, offset;
 	int i, entries = read_cache();
 	char *buffer;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
