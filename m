Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSJ2QyB>; Tue, 29 Oct 2002 11:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbSJ2QyB>; Tue, 29 Oct 2002 11:54:01 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:15630 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S262130AbSJ2Qxy> convert rfc822-to-8bit; Tue, 29 Oct 2002 11:53:54 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove the conv option of fat (1/3)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 30 Oct 2002 01:59:53 +0900
Message-ID: <87fzupb2pi.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This removes the conv option. This option does nothing, now.
(This patch from René Scharfe)

[Andrew, thanks for useful tools]

Please apply.

 fs/fat/inode.c              |   14 ++------------
 fs/fat/misc.c               |   38 --------------------------------------
 include/linux/msdos_fs.h    |    1 -
 include/linux/msdos_fs_sb.h |    1 -
 4 files changed, 2 insertions(+), 52 deletions(-)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- fat-2.5.44/fs/fat/inode.c~fat_kill_conv	2002-10-24 00:13:54.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/inode.c	2002-10-24 00:13:54.000000000 +0900
@@ -255,8 +255,6 @@ static int fat_show_options(struct seq_f
 	}
 	if (opts->name_check != 'n')
 		seq_printf(m, ",check=%c", opts->name_check);
-	if (opts->conversion != 'b')
-		seq_printf(m, ",conv=%c", opts->conversion);
 	if (opts->quiet)
 		seq_puts(m, ",quiet");
 	if (opts->showexec)
@@ -299,7 +297,6 @@ static int parse_options(char *options, 
 	else
 		opts->shortname = 0;
 	opts->name_check = 'n';
-	opts->conversion = 'b';
 	opts->quiet = opts->showexec = opts->sys_immutable = opts->dotsOK =  0;
 	opts->utf8 = opts->unicode_xlate = 0;
 	opts->numtail = 1;
@@ -326,16 +323,9 @@ static int parse_options(char *options, 
 			else ret = 0;
 		}
 		else if (!strcmp(this_char,"conv") && value) {
-			if (value[0] && !value[1] && strchr("bta",*value))
-				opts->conversion = *value;
-			else if (!strcmp(value,"binary"))
-				opts->conversion = 'b';
-			else if (!strcmp(value,"text"))
-				opts->conversion = 't';
-			else if (!strcmp(value,"auto"))
-				opts->conversion = 'a';
-			else ret = 0;
+			printk("FAT: conv option is obsolete, "
+			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"nocase")) {
 			if (!is_vfat)
--- fat-2.5.44/fs/fat/misc.c~fat_kill_conv	2002-10-24 00:13:54.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/misc.c	2002-10-24 00:13:54.000000000 +0900
@@ -17,18 +17,6 @@
 #endif
 #define Printk(x)	printk x
 
-/* Well-known binary file extensions - of course there are many more */
-
-static char ascii_extensions[] =
-  "TXT" "ME " "HTM" "1ST" "LOG" "   " 	/* text files */
-  "C  " "H  " "CPP" "LIS" "PAS" "FOR"  /* programming languages */
-  "F  " "MAK" "INC" "BAS" 		/* programming languages */
-  "BAT" "SH "				/* program code :) */
-  "INI"					/* config files */
-  "PBM" "PGM" "DXF"			/* graphics */
-  "TEX";				/* TeX */
-
-
 /*
  * fat_fs_panic reports a severe file system problem and sets the file system
  * read-only. The file system can be made writable again by remounting it.
@@ -55,33 +43,7 @@ void fat_fs_panic(struct super_block *s,
 		printk("    File system has been set read-only\n");
 }
 
-
-/*
- * fat_is_binary selects optional text conversion based on the conversion mode
- * and the extension part of the file name.
- */
-
-int fat_is_binary(char conversion,char *extension)
-{
-	char *walk;
-
-	switch (conversion) {
-		case 'b':
-			return 1;
-		case 't':
-			return 0;
-		case 'a':
-			for (walk = ascii_extensions; *walk; walk += 3)
-				if (!strncmp(extension,walk,3)) return 0;
-			return 1;	/* default binary conversion */
-		default:
-			printk("Invalid conversion mode - defaulting to "
-			    "binary.\n");
-			return 1;
-	}
-}
-
 void lock_fat(struct super_block *sb)
 {
 	down(&(MSDOS_SB(sb)->fat_lock));
--- fat-2.5.44/include/linux/msdos_fs.h~fat_kill_conv	2002-10-24 00:13:54.000000000 +0900
+++ fat-2.5.44-hirofumi/include/linux/msdos_fs.h	2002-10-24 00:13:54.000000000 +0900
@@ -299,8 +299,7 @@ extern int fat_notify_change(struct dent
 
 /* fat/misc.c */
 extern void fat_fs_panic(struct super_block *s, const char *fmt, ...);
-extern int fat_is_binary(char conversion, char *extension);
 extern void lock_fat(struct super_block *sb);
 extern void unlock_fat(struct super_block *sb);
 extern void fat_clusters_flush(struct super_block *sb);
--- fat-2.5.44/include/linux/msdos_fs_sb.h~fat_kill_conv	2002-10-24 00:13:54.000000000 +0900
+++ fat-2.5.44-hirofumi/include/linux/msdos_fs_sb.h	2002-10-24 00:13:54.000000000 +0900
@@ -15,7 +15,6 @@ struct fat_mount_options {
 	char *iocharset;          /* Charset used for filename input/display */
 	unsigned short shortname; /* flags for shortname display/create rule */
 	unsigned char name_check; /* r = relaxed, n = normal, s = strict */
-	unsigned char conversion; /* b = binary, t = text, a = auto */
 	unsigned quiet:1,         /* set = fake successful chmods and chowns */
 		 showexec:1,      /* set = only set x bit for com/exe/bat */
 		 sys_immutable:1, /* set = system files are immutable */
