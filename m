Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTJFQ6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTJFQ6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:58:43 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:64270 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262410AbTJFQ4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:56:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix unrecognized option of fat (3/6)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 07 Oct 2003 01:56:32 +0900
Message-ID: <87ad8epanz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

vfat doesn't recognize the msdos option. Also msdos doesn't recognize
vfat option.

And this separates fat/vfat/msdos option structures. I think this
looks more good as document.

Please apply.

 linux-2.6.0-test6-hirofumi/fs/fat/inode.c |  114 +++++++++++++-----------------
 1 files changed, 52 insertions(+), 62 deletions(-)

diff -puN fs/fat/inode.c~fat_unrecognized fs/fat/inode.c
--- linux-2.6.0-test6/fs/fat/inode.c~fat_unrecognized	2003-10-07 01:51:34.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/fat/inode.c	2003-10-07 01:51:34.000000000 +0900
@@ -267,7 +267,7 @@ enum {
 	Opt_nonumtail_on, Opt_nonumtail_yes, Opt_nonumtail_true, Opt_nonumtail_opt,
 };
 
-static match_table_t FAT_tokens = {
+static match_table_t fat_tokens = {
 	{Opt_check_r, "check=relaxed"},
 	{Opt_check_s, "check=strict"},
 	{Opt_check_n, "check=normal"},
@@ -280,10 +280,6 @@ static match_table_t FAT_tokens = {
 	{Opt_conv_b, "conv=b"},
 	{Opt_conv_t, "conv=t"},
 	{Opt_conv_a, "conv=a"},
-	{Opt_nodots, "nodots"},
-	{Opt_nodots, "dotsOK=no"},
-	{Opt_dots, "dotsOK=yes"},
-	{Opt_dots, "dots"},
 	{Opt_uid, "uid=%d"},
 	{Opt_gid, "gid=%d"},
 	{Opt_umask, "umask=%o"},
@@ -291,11 +287,26 @@ static match_table_t FAT_tokens = {
 	{Opt_fmask, "fmask=%o"},
 	{Opt_fat, "fat=%d"},
 	{Opt_codepage, "codepage=%d"},
-	{Opt_charset, "iocharset=%s"},
 	{Opt_blocksize, "blocksize=%d"},
 	{Opt_nocase, "nocase"},
 	{Opt_cvf_format, "cvf_format=%20s"},
 	{Opt_cvf_options, "cvf_options=%100s"},
+	{Opt_quiet, "quiet"},
+	{Opt_showexec, "showexec"},
+	{Opt_debug, "debug"},
+	{Opt_immutable, "sys_immutable"},
+	{Opt_posix, "posix"},
+	{Opt_err, NULL}
+};
+static match_table_t msdos_tokens = {
+	{Opt_nodots, "nodots"},
+	{Opt_nodots, "dotsOK=no"},
+	{Opt_dots, "dotsOK=yes"},
+	{Opt_dots, "dots"},
+	{Opt_err, NULL}
+};
+static match_table_t vfat_tokens = {
+	{Opt_charset, "iocharset=%s"},
 	{Opt_shortname_lower, "shortname=lower"},
 	{Opt_shortname_win95, "shortname=win95"},
 	{Opt_shortname_winnt, "shortname=winnt"},
@@ -321,11 +332,6 @@ static match_table_t FAT_tokens = {
 	{Opt_nonumtail_yes, "nonumtail=yes"},
 	{Opt_nonumtail_true, "nonumtail=true"},
 	{Opt_nonumtail_opt, "nonumtail"},
-	{Opt_quiet, "quiet"},
-	{Opt_showexec, "showexec"},
-	{Opt_debug, "debug"},
-	{Opt_immutable, "sys_immutable"},
-	{Opt_posix, "posix"},
 	{Opt_err, NULL}
 };
 
@@ -362,7 +368,13 @@ static int parse_options(char *options, 
 		if (!*p)
 			continue;
 
-		token = match_token(p, FAT_tokens, args);
+		token = match_token(p, fat_tokens, args);
+		if (token == Opt_err) {
+			if (is_vfat)
+				token = match_token(p, vfat_tokens, args);
+			else
+				token = match_token(p, msdos_tokens, args);
+		}
 		switch (token) {
 		case Opt_check_s:
 			opts->name_check = 's';
@@ -373,14 +385,6 @@ static int parse_options(char *options, 
 		case Opt_check_n:
  				opts->name_check = 'n';
 			break;
-		case Opt_dots:		/* msdos specific */
-			if (!is_vfat)
-				opts->dotsOK = 1;
-			break;
-		case Opt_nodots:	/* msdos specific */
-			if (!is_vfat)
-				opts->dotsOK = 0;
-			break;
 		case Opt_nocase:
 			if (!is_vfat)
 				opts->nocase = 1;
@@ -435,85 +439,71 @@ static int parse_options(char *options, 
  					opts->codepage);
 			break;
 
+		/* msdos specific */
+		case Opt_dots:
+			opts->dotsOK = 1;
+			break;
+		case Opt_nodots:
+			opts->dotsOK = 0;
+			break;
+
 		/* vfat specific */
 		case Opt_charset:
-			if (is_vfat) {
-				kfree(opts->iocharset);
-				opts->iocharset = match_strdup(&args[0]);
-				if (!opts->iocharset)
-					return 0;
-				printk("MSDOS FS: IO charset %s\n",
-					opts->iocharset);
-			}
+			kfree(opts->iocharset);
+			opts->iocharset = match_strdup(&args[0]);
+			if (!opts->iocharset)
+				return 0;
+			printk("MSDOS FS: IO charset %s\n",
+			       opts->iocharset);
 			break;
 		case Opt_shortname_lower:
-			if (is_vfat) {
-				opts->shortname = VFAT_SFN_DISPLAY_LOWER
-						| VFAT_SFN_CREATE_WIN95;
-			}
+			opts->shortname = VFAT_SFN_DISPLAY_LOWER
+					| VFAT_SFN_CREATE_WIN95;
 			break;
 		case Opt_shortname_win95:
-			if (is_vfat) {
-				opts->shortname = VFAT_SFN_DISPLAY_WIN95
-						| VFAT_SFN_CREATE_WIN95;
-			}
+			opts->shortname = VFAT_SFN_DISPLAY_WIN95
+					| VFAT_SFN_CREATE_WIN95;
 			break;
 		case Opt_shortname_winnt:
-			if (is_vfat) {
-				opts->shortname = VFAT_SFN_DISPLAY_WINNT
-						| VFAT_SFN_CREATE_WINNT;
-			}
+			opts->shortname = VFAT_SFN_DISPLAY_WINNT
+					| VFAT_SFN_CREATE_WINNT;
 			break;
 		case Opt_shortname_mixed:
-			if (is_vfat) {
-				opts->shortname = VFAT_SFN_DISPLAY_WINNT
-						| VFAT_SFN_CREATE_WIN95;
-			}
+			opts->shortname = VFAT_SFN_DISPLAY_WINNT
+					| VFAT_SFN_CREATE_WIN95;
 			break;
 		case Opt_utf8_off:	/* 0 or no or false */
 		case Opt_utf8_no:
 		case Opt_utf8_false:
-			if (is_vfat) {
-				opts->utf8 = 0;
-			}
+			opts->utf8 = 0;
 			break;
 		case Opt_utf8_on:	/* empty or 1 or yes or true */
 		case Opt_utf8_opt:
 		case Opt_utf8_yes:
 		case Opt_utf8_true:
-			if (is_vfat) {
-				opts->utf8 = 1;
-			}
+			opts->utf8 = 1;
 			break;
 		case Opt_uni_xl_off:	/* 0 or no or false */
 		case Opt_uni_xl_no:
 		case Opt_uni_xl_false:
-			if (is_vfat) {
-				opts->unicode_xlate = 0;
-			}
+			opts->unicode_xlate = 0;
 			break;
 		case Opt_uni_xl_on:	/* empty or 1 or yes or true */
 		case Opt_uni_xl_yes:
 		case Opt_uni_xl_true:
 		case Opt_uni_xl_opt:
-			if (is_vfat) {
-				opts->unicode_xlate = 1;
-			}
+			opts->unicode_xlate = 1;
 			break;
 		case Opt_nonumtail_off:		/* 0 or no or false */
 		case Opt_nonumtail_no:
 		case Opt_nonumtail_false:
-			if (is_vfat) {
-					opts->numtail = 1;	/* negated option */
-			}
+			opts->numtail = 1;	/* negated option */
 			break;
 		case Opt_nonumtail_on:		/* empty or 1 or yes or true */
 		case Opt_nonumtail_yes:
 		case Opt_nonumtail_true:
 		case Opt_nonumtail_opt:
-			if (is_vfat) {
-					opts->numtail = 0;	/* negated option */
-			}
+			opts->numtail = 0;	/* negated option */
 			break;
 
 		/* obsolete mount options */

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
