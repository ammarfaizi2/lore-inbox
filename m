Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSJMAPY>; Sat, 12 Oct 2002 20:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSJMAOc>; Sat, 12 Oct 2002 20:14:32 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:54537 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261386AbSJMAOF>; Sat, 12 Oct 2002 20:14:05 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] removes posix option of fat (3/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Oct 2002 09:19:49 +0900
Message-ID: <877kgnb36i.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This removes the posix option of vfat. The current posix options works
only as an alias of name_check=s.

Please apply.


 Documentation/filesystems/vfat.txt |    8 --------
 fs/fat/inode.c                     |    8 +++-----
 include/linux/msdos_fs_sb.h        |    1 -
 3 files changed, 3 insertions(+), 14 deletions(-)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urNp fat_vfat_opt_shift/Documentation/filesystems/vfat.txt fat_kill_posixfs/Documentation/filesystems/vfat.txt
--- fat_vfat_opt_shift/Documentation/filesystems/vfat.txt	2002-10-12 13:22:08.000000000 +0900
+++ fat_kill_posixfs/Documentation/filesystems/vfat.txt	2002-10-13 07:39:16.000000000 +0900
@@ -31,10 +31,6 @@ uni_xlate=<bool> -- Translate unhandled 
 		 illegal on the vfat filesystem.  The escape sequence
 		 that gets used is ':' and the four digits of hexadecimal
 		 unicode.
-posix=<bool>  -- Allow names of same letters, different case such as
-                 'LongFileName' and 'longfilename' to coexist.  This has some
-                 problems currently because 8.3 conflicts are not handled
-                 correctly for POSIX filesystem compliance.
 nonumtail=<bool> -- When creating 8.3 aliases, normally the alias will
                  end in '~1' or tilde followed by some number.  If this
                  option is set, then if the filename is 
@@ -66,10 +62,6 @@ TODO
   a get next directory entry approach.  The only thing left that uses
   raw scanning is the directory renaming code.
 
-* Fix the POSIX filesystem support to work in 8.3 space.  This involves
-  renaming aliases if a conflict occurs between a new filename and
-  an old alias.  This is quite a mess.
-
 
 POSSIBLE PROBLEMS
 ----------------------------------------------------------------------
diff -urNp fat_vfat_opt_shift/fs/fat/inode.c fat_kill_posixfs/fs/fat/inode.c
--- fat_vfat_opt_shift/fs/fat/inode.c	2002-10-13 07:30:59.000000000 +0900
+++ fat_kill_posixfs/fs/fat/inode.c	2002-10-13 07:39:16.000000000 +0900
@@ -236,7 +236,7 @@ static int parse_options(char *options, 
 	opts->name_check = 'n';
 	opts->conversion = 'b';
 	opts->quiet = opts->showexec = opts->sys_immutable = opts->dotsOK =  0;
-	opts->utf8 = opts->unicode_xlate = opts->posixfs = 0;
+	opts->utf8 = opts->unicode_xlate = 0;
 	opts->numtail = 1;
 	opts->nocase = 0;
 	*debug = 0;
@@ -383,8 +383,8 @@ static int parse_options(char *options, 
 			if (ret) opts->unicode_xlate = val;
 		}
 		else if (is_vfat && !strcmp(this_char,"posix")) {
-			ret = simple_getbool(value, &val);
-			if (ret) opts->posixfs = val;
+			printk("FAT: posix option is obsolete, "
+			       "not supported now\n");
 		}
 		else if (is_vfat && !strcmp(this_char,"nonumtail")) {
 			ret = simple_getbool(value, &val);
@@ -417,8 +417,6 @@ static int parse_options(char *options, 
 			break;
 	}
 out:
-	if (opts->posixfs)
-		opts->name_check = 's';
 	if (opts->unicode_xlate)
 		opts->utf8 = 0;
 	
diff -urNp fat_vfat_opt_shift/include/linux/msdos_fs_sb.h fat_kill_posixfs/include/linux/msdos_fs_sb.h
--- fat_vfat_opt_shift/include/linux/msdos_fs_sb.h	2002-10-12 13:22:08.000000000 +0900
+++ fat_kill_posixfs/include/linux/msdos_fs_sb.h	2002-10-13 07:39:16.000000000 +0900
@@ -22,7 +22,6 @@ struct fat_mount_options {
 		 isvfat:1,        /* 0=no vfat long filename support, 1=vfat support */
 		 utf8:1,	  /* Use of UTF8 character set (Default) */
 		 unicode_xlate:1, /* create escape sequences for unhandled Unicode */
-		 posixfs:1,       /* Allow names like makefile and Makefile to coexist */
 		 numtail:1,       /* Does first alias have a numeric '~1' type tail? */
 		 atari:1,         /* Use Atari GEMDOS variation of MS-DOS fs */
 		 nocase:1;	  /* Does this need case conversion? 0=need case conversion*/
