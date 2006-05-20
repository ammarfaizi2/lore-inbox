Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWETO55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWETO55 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 10:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWETO55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 10:57:57 -0400
Received: from mx2.mail.ru ([194.67.23.122]:39460 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S964858AbWETO54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 10:57:56 -0400
Date: Sat, 20 May 2006 19:01:20 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] ufs: directory and page cache: from blocks to pages
Message-ID: <20060520150120.GA15023@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060519171833.GA28572@rain.homenetwork> <20060519110821.7d033ee4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519110821.7d033ee4.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 11:08:21AM -0700, Andrew Morton wrote:
> Does anyone know of a good way of creating UFS filesytems under Linux?  I
> had a go at porting BSD ufsutils a few years ago and nearly died.  There's
> http://ufs-linux.sourceforge.net/, but that hasn't been touched in a couple
> of years..
I used ufs-tools package from ufs-linux.sf.net.
It has some problems with compilation, 
but I didn't found any runtime problems.

Here is a small patch to make possible compilation
on modern systems, 
I sent similar patch to ufs-tools maintainer 
several months ago, but...

---

diff -uprN ufs-tools-0.1/err.c ufs-tools-0.1.mod/err.c
--- ufs-tools-0.1/err.c	1970-01-01 03:00:00.000000000 +0300
+++ ufs-tools-0.1.mod/err.c	2006-05-20 18:19:59.238202500 +0400
@@ -0,0 +1,28 @@
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include "err.h"
+
+/*----------------------------------------------------
+simulation of BSD functions 
+----------------------------------------------------*/
+void errx(int n,char *fmt, ...)
+{
+        va_list pvar;
+        va_start(pvar, fmt);
+        vfprintf(stderr,fmt,pvar);
+        va_end(pvar);
+        exit(n);
+}
+/*----------------------------------------------------*/
+void err(int n,char *fmt, ...)
+{
+        va_list pvar;
+        va_start(pvar, fmt);
+        vfprintf(stderr,fmt,pvar);
+        va_end(pvar);
+}
+
+/*------------------------------------------------------*/
+
diff -uprN ufs-tools-0.1/err.h ufs-tools-0.1.mod/err.h
--- ufs-tools-0.1/err.h	1970-01-01 03:00:00.000000000 +0300
+++ ufs-tools-0.1.mod/err.h	2006-05-20 18:38:25.483338500 +0400
@@ -0,0 +1,7 @@
+#ifndef _ERR_H_
+#define _ERR_H_
+
+extern void errx(int n,char *fmt, ...);
+extern void err(int n,char *fmt, ...);
+
+#endif/*!_ERR_H_*/
diff -uprN ufs-tools-0.1/libufs/Makefile ufs-tools-0.1.mod/libufs/Makefile
--- ufs-tools-0.1/libufs/Makefile	2004-01-12 15:30:15.000000000 +0300
+++ ufs-tools-0.1.mod/libufs/Makefile	2006-05-20 18:28:52.203510750 +0400
@@ -2,18 +2,19 @@
 
 INCLUDE="../include/"
 LIBUFS="_LIBUFS"
+CFLAGS = -fPIC -Wall -D${LIBUFS}
+
+libufs.so: block.o cgroup.o inode.o type.o sblock.o
+	cc  -shared -o $@  $^
+
+%.o: %.c
+	$(CC)  -c $(CFLAGS) -I${INCLUDE}  -o $@ $<
+
+block.o: block.c
+cgroup.o: cgroup.c
+inode.o: inode.c
+type.o: type.c
+sblock.o: sblock.c
 
-all : block cgroup inode type sblock
-	cc  -shared -o libufs.so  block.o cgroup.o inode.o type.o sblock.o
-block : block.c
-	cc -c block.c  -I${INCLUDE} -D${LIBUFS}
-cgroup : cgroup.c
-	cc -c cgroup.c  -I${INCLUDE} -D${LIBUFS}
-inode : inode.c
-	cc -c inode.c  -I${INCLUDE} -D${LIBUFS}
-type : type.c
-	cc -c type.c  -I${INCLUDE} -D${LIBUFS}
-sblock : sblock.c
-	cc -c sblock.c  -I${INCLUDE} -D${LIBUFS}
 clean :
 	rm *.o *.so
diff -uprN ufs-tools-0.1/libufs/sblock.c ufs-tools-0.1.mod/libufs/sblock.c
--- ufs-tools-0.1/libufs/sblock.c	2004-01-12 12:45:13.000000000 +0300
+++ ufs-tools-0.1.mod/libufs/sblock.c	2006-05-20 09:50:39.762206000 +0400
@@ -59,7 +59,7 @@ sbread(struct uufsd *disk)
 	superblock = superblocks[0];
 
 	for (sb = 0; (superblock = superblocks[sb]) != -1; sb++) {
-		if (bread(disk, superblock, disk->d_sb, SBLOCKSIZE) == -1) {
+		if (bread(disk, superblock/disk->d_bsize, disk->d_sb, SBLOCKSIZE) == -1) {
 			ERROR(disk, "non-existent or truncated superblock");
 			return (-1);
 		}
diff -uprN ufs-tools-0.1/Makefile ufs-tools-0.1.mod/Makefile
--- ufs-tools-0.1/Makefile	2004-01-12 12:45:13.000000000 +0300
+++ ufs-tools-0.1.mod/Makefile	2006-05-20 18:21:30.435902000 +0400
@@ -1,13 +1,21 @@
 #Makefile for building mkufs
 
 INCLUDE="include/"
-CFLGS=-g
+CFLGS=-g -Wall
 
-all : mkufs mkfs
-	cc  -o mkufs  mkufs.o mkfs.o  libufs/libufs.so
-mkufs : mkufs.c
-	cc -c mkufs.c  -I${INCLUDE} ${CFLGS}
-mkfs : mkfs.c
-	cc -c mkfs.c  -I${INCLUDE} ${CFLGS}
+%.o: %.c
+	cc -I${INCLUDE} $(CFLGS) -c $< -o $@
+
+mkufs : mkufs.o mkfs.o err.o libufs/libufs.so
+	cc  -o $@ $^
+
+mkufs.o : mkufs.c err.h
+
+mkfs.o : mkfs.c err.h
+
+err.o: err.c err.h
+
+libufs/libufs.so:
+	cd libufs && make
 clean:
-	rm *.o mkufs
+	rm *.o mkufs && cd libufs && make clean
diff -uprN ufs-tools-0.1/mkfs.c ufs-tools-0.1.mod/mkfs.c
--- ufs-tools-0.1/mkfs.c	2004-01-12 12:45:13.000000000 +0300
+++ ufs-tools-0.1.mod/mkfs.c	2006-05-20 18:21:29.483842500 +0400
@@ -46,6 +46,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <stdio.h>
+#include <time.h>
 #include <unistd.h>
 #include <sys/time.h>
 #include <sys/types.h>
@@ -64,6 +65,7 @@
 #include"ufs/disklabel.h" /* Taken from FreeBSD */
 #include"ufs/fs.h"        /* Taken from FreeBSD */
 #include"libufs/libufs.h"    /* Taken from FreeBSD */
+#include "err.h"
 #include"mkufs.h"    /* Taken from FreeBSD */
 
 
@@ -135,7 +137,7 @@ mkfs(struct partition *pp, char *fsys)
         if (Uflag)
                 sblock.fs_flags |= FS_DOSOFTDEP;
         if (Lflag)
-                strncpy(sblock.fs_volname, volumelabel, MAXVOLLEN);
+                strncpy((char *)sblock.fs_volname, (char *)volumelabel, MAXVOLLEN);
         /*
          * Validate the given file system size.
          * Verify that its last block can actually be accessed.
@@ -558,6 +560,7 @@ ilog2(int val)
                 if (1 << n == val)
                         return (n);
         errx(1, "ilog2: %d is not a power of 2\n", val);
+	return 0;
 }
 
 /*
@@ -928,7 +931,7 @@ iput(union dinode *ip, ino_t ino)
         sblock.fs_cstotal.cs_nifree--;
         fscs[0].cs_nifree--;
         if (ino >= (unsigned long)sblock.fs_ipg * sblock.fs_ncg) {
-                printf("fsinit: inode value out of range (%d).\n", ino);
+                printf("fsinit: inode value out of range (%llu).\n", (unsigned long long)ino);
                 exit(32);
         }
         d = fsbtodb(&sblock, ino_to_fsba(&sblock, ino));
@@ -1038,6 +1041,11 @@ charsperline(void)
                 columns = 80;   /* last resort */
         return (columns);
 }
+
+u_int32_t arc4random()
+{
+    return (rand());
+}
                                                                                 
 /*
  * For the regression test, return predictable random values.
@@ -1053,8 +1061,3 @@ newfs_random(void)
         return (arc4random());
 }
 
-u_int32_t arc4random()
-{
-    return (rand());
-}
-
diff -uprN ufs-tools-0.1/mkufs.c ufs-tools-0.1.mod/mkufs.c
--- ufs-tools-0.1/mkufs.c	2004-01-13 08:36:35.000000000 +0300
+++ ufs-tools-0.1.mod/mkufs.c	2006-05-20 18:21:10.030626750 +0400
@@ -13,6 +13,7 @@
 
 
 #include<stdio.h>
+#include<stdlib.h>     /* for exit */
 #include<unistd.h>     /* for getopt */
 #include<sys/types.h>  /* for open */
 #include<sys/stat.h>   /* for open */
@@ -23,6 +24,7 @@
 #include<sys/ioctl.h>      /* for ioctl  */
 #include<linux/hdreg.h>      /* for ioctl  */
 #include<stdarg.h>
+#include <ctype.h> /*for isalnum*/
 
 #define MAXBSIZE        65536   /* must be power of 2 */
 
@@ -32,6 +34,7 @@
 #include"ufs/disklabel.h" /* Taken from FreeBSD */
 #include"ufs/fs.h"        /* Taken from FreeBSD */
 #include"libufs/libufs.h"    /* Taken from FreeBSD */
+#include "err.h"
 #include"mkufs.h"    /* Taken from FreeBSD */
 
 const char * program_name = "mkufs";
@@ -94,22 +97,17 @@ int     avgfilesize = AVFILESIZ;/* expec
 int     avgfilesperdir = AFPDIR;/* expected number of files per directory */
 u_char  *volumelabel = NULL;    /* volume label for filesystem */
 struct uufsd disk;              /* libufs disk structure */
-                                                                                
-static char     device[MAXPATHLEN];
+                     
 static char     *disktype;
-static int      unlabeled;
-                                                                                
+                            
 static struct disklabel *getdisklabel(int ,char *s);
-static void rewritelabel(char *s, struct disklabel *lp);
 static void usage(void);
-static void errx(int n,char *fmt, ...);
+
                                                                                 
 
 /*---------------------------------------------------------*/
 int main(int argc, char *argv[])
-{
-
-    int   c=0,error=0;
+{    
     struct hd_geometry  hd;
 
 #ifdef ENABLE_NLS
@@ -135,13 +133,13 @@ int main(int argc, char *argv[])
                         Eflag++;
                         break;
                 case 'L':
-                        volumelabel = optarg;
+                        volumelabel = (u_char *) optarg;
                         i = -1;
                         while (isalnum(volumelabel[++i]));
                         if (volumelabel[i] != '\0') {
                                 errx(1, "bad volume label. Valid characters are alphanumerics.");
                         }
-                        if (strlen(volumelabel) >= MAXVOLLEN) {
+                        if (strlen((char *)volumelabel) >= MAXVOLLEN) {
                                 errx(1, "bad volume label. Length is longer than %d.",
                                     MAXVOLLEN);
                         }
@@ -210,7 +208,7 @@ int main(int argc, char *argv[])
                                 errx(1, "%s: bad bytes per inode", optarg);
                         break;
                 case 'l':
-                        p_label = optarg;
+                        p_label = (u_char *)optarg;
                         break;
                 case 'm':
                         if ((minfree = atoi(optarg)) < 0 || minfree > 99)
@@ -379,8 +377,7 @@ then read the disklabel off from that pa
 
 */
 struct disklabel * getdisklabel(int st,char *s)
-{
-    struct disklabel *lp;
+{    
     static struct disklabel lab;
 #define MAX_PART     10
     struct hd_geometry  h[MAX_PART];
@@ -392,7 +389,7 @@ struct disklabel * getdisklabel(int st,c
       disklabel is and read the label from there */
      if ( p_label != NULL )
      {
-        if ( (fd = open(p_label, O_RDONLY) ) < 0 )
+	     if ( (fd = open((char *)p_label, O_RDONLY) ) < 0 )
         {
              if ( errno == ENOENT) 
                               return NULL;
@@ -531,7 +528,7 @@ static void usage()
 }
 
 /*------------------------------------------------------*/
-print_label(struct disklabel lab)
+void print_label(struct disklabel lab)
 {
     int i;
     printf("d_magic= %X\n",lab.d_magic);
@@ -545,24 +542,3 @@ print_label(struct disklabel lab)
         printf("\tp_offset = %d\n",lab.d_partitions[i].p_offset);
     } 
 }
-/*----------------------------------------------------
-simulation of BSD functions 
-----------------------------------------------------*/
-void errx(int n,char *fmt, ...)
-{
-        va_list pvar;
-        va_start(pvar, fmt);
-        vfprintf(stderr,fmt,pvar);
-        va_end(pvar);
-        exit(n);
-}
-/*----------------------------------------------------*/
-void err(int n,char *fmt, ...)
-{
-        va_list pvar;
-        va_start(pvar, fmt);
-        vfprintf(stderr,fmt,pvar);
-        va_end(pvar);
-}
-
-/*------------------------------------------------------*/


-- 
/Evgeniy

