Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbTIQTVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbTIQTVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:21:39 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:39640 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262928AbTIQTVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:21:08 -0400
Subject: Re: [CFT] [1/15] table-driven filesystems option parsing
From: Will Dyson <will_dyson@pobox.com>
To: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20030905115615.283cab00.rddunlap@osdl.org>
References: <20030905115615.283cab00.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1063826464.17972.897.camel@thalience>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Sep 2003 15:21:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-05 at 14:56, Randy.Dunlap wrote:

> Current (full) patch is at
> http://developer.osdl.org/rddunlap/patches/linux-260t4g-fsoptions.patch
> 
> These patches apply to 2.6.0-test4 or -current (Sept. 5/2003).
> 
> I have tested ext3, ext3, fat, isofs, jfs, & proc.
> 
> I'd appreciate others testing all of these, please, especially
> the ones that I can't test (adfs, affs, hfs, hpfs, ufd, ufs,
> autofs[4]).

As a filesystem maintainer, I like the idea of this patch! However, I
think it could use some comments on useage in the header file. There are
already too many filesystem interfaces where the only documentation on
how to use them is the way that existing filesystems use them.

Below is a patch to convert befs to use parser.h. It kills some of my
least favorite code (yay!).

The patch is tested a certain minimal amount (booted, mounted a
filesystem with options).


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1316  -> 1.1318 
#	  fs/befs/linuxvfs.c	1.12    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/15	will@thalience.(none)	1.1317
# convert befs to use the parser.h functions to manage its mount options
# --------------------------------------------
# 03/09/17	will@thalience.(none)	1.1318
# Fix formatting and a silly {} error
# --------------------------------------------
#
diff -Nru a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
--- a/fs/befs/linuxvfs.c	Wed Sep 17 00:56:25 2003
+++ b/fs/befs/linuxvfs.c	Wed Sep 17 00:56:25 2003
@@ -13,6 +13,7 @@
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
+#include <linux/parser.h>
 
 #include "befs.h"
 #include "btree.h"
@@ -667,12 +668,26 @@
 	return -EILSEQ;
 }
 
+/**
+ * Use the 
+ *
+ */
+enum {
+	Opt_uid, Opt_gid, Opt_charset, Opt_debug,
+};
+
+static match_table_t befs_tokens = {
+	{Opt_uid, "uid=%d"},
+	{Opt_gid, "gid=%d"},
+	{Opt_charset, "iocharset=%s"},
+	{Opt_debug, "debug"}
+};
+
 static int
 parse_options(char *options, befs_mount_options * opts)
 {
-	char *this_char;
-	char *value;
-	int ret = 1;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
 
 	/* Initialize options */
 	opts->uid = 0;
@@ -683,64 +698,60 @@
 	opts->debug = 0;
 
 	if (!options)
-		return ret;
+		return 1;
 
-	while ((this_char = strsep(&options, ",")) != NULL) {
-
-		if ((value = strchr(this_char, '=')) != NULL)
-			*value++ = 0;
-
-		if (!strcmp(this_char, "uid")) {
-			if (!value || !*value) {
-				ret = 0;
-			} else {
-				opts->uid = simple_strtoul(value, &value, 0);
-				opts->use_uid = 1;
-				if (*value) {
-					printk(KERN_ERR "BEFS: Invalid uid "
-					       "option: %s\n", value);
-					ret = 0;
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token;
+		if (!*p)
+			continue;
+
+		token = match_token(p, befs_tokens, args);
+		switch (token) {
+			case Opt_uid:
+			{
+				int uid = match_int(&args[0]);
+				if (uid < 0) {
+					printk(KERN_ERR "BeFS: Invalid uid %d, "
+							"using default\n", uid);
+					break;
 				}
+				opts->uid = uid;
+				opts->use_uid = 1;
+				break;
 			}
-		} else if (!strcmp(this_char, "gid")) {
-			if (!value || !*value)
-				ret = 0;
-			else {
-				opts->gid = simple_strtoul(value, &value, 0);
-				opts->use_gid = 1;
-				if (*value) {
-					printk(KERN_ERR
-					       "BEFS: Invalid gid option: "
-					       "%s\n", value);
-					ret = 0;
+			case Opt_gid:
+			{
+				int gid = match_int(&args[0]);
+				if (gid < 0) {
+					printk(KERN_ERR "BeFS: Invalid gid %d, "
+							"using default\n", gid);
+					break;
 				}
+				opts->gid = gid;
+				opts->use_gid = 1;
+				break;
 			}
-		} else if (!strcmp(this_char, "iocharset") && value) {
-			char *p = value;
-			int len;
-
-			while (*value && *value != ',')
-				value++;
-			len = value - p;
-			if (len) {
-				char *buffer = kmalloc(len + 1, GFP_NOFS);
-				if (buffer) {
-					opts->iocharset = buffer;
-					memcpy(buffer, p, len);
-					buffer[len] = 0;
-
-				} else {
-					printk(KERN_ERR "BEFS: "
-					       "cannot allocate memory\n");
-					ret = 0;
+			case Opt_charset:
+			{
+				kfree(opts->iocharset);
+				opts->iocharset = match_strdup(&args[0]);
+				if (!opts->iocharset) {
+					printk(KERN_ERR "BeFS: allocation failure for "
+							"iocharset string\n");
+					return 0;
 				}
+				break;
 			}
-		} else if (!strcmp(this_char, "debug")) {
-			opts->debug = 1;
+			case Opt_debug:
+				opts->debug = 1;
+				break;
+			default:
+				printk(KERN_ERR "BeFS: Unrecognized mount option \"%s\" "
+						"or missing value\n", p);
+				return 0;
 		}
 	}
-
-	return ret;
+	return 1;
 }
 
 /* This function has the responsibiltiy of getting the



-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman

