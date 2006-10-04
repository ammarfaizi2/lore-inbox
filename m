Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWJDHvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWJDHvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbWJDHvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:51:47 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:23841 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161136AbWJDHvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:51:46 -0400
Message-ID: <452367FB.8090302@sw.ru>
Date: Wed, 04 Oct 2006 11:51:23 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Stephen Tweedie <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ext4@vger.kernel.org, devel@openvz.org, cmm@us.ibm.com
CC: Kirill Korotaev <dev@openvz.org>, Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH 2.6.18] ext2: errors behaviour fix
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EXT2_ERRORS_CONTINUE should be read from the superblock as default value for
error behaviour.
parse_option() should clean the alternative options and should not change
default value taken from the superblock.

Signed-off-by:	Vasily Averin <vvs@sw.ru>
Acked-by:	Kirill Korotaev <dev@openvz.org>

--- linux-2.6.18/fs/ext2/super.c.e2erop	2006-09-20 07:42:06.000000000 +0400
+++ linux-2.6.18/fs/ext2/super.c	2006-10-03 15:50:31.000000000 +0400
@@ -365,7 +365,6 @@ static int parse_options (char * options
 {
 	char * p;
 	substring_t args[MAX_OPT_ARGS];
-	unsigned long kind = EXT2_MOUNT_ERRORS_CONT;
 	int option;

 	if (!options)
@@ -405,13 +404,19 @@ static int parse_options (char * options
 			/* *sb_block = match_int(&args[0]); */
 			break;
 		case Opt_err_panic:
-			kind = EXT2_MOUNT_ERRORS_PANIC;
+			clear_opt (sbi->s_mount_opt, ERRORS_CONT);
+			clear_opt (sbi->s_mount_opt, ERRORS_RO);
+			set_opt (sbi->s_mount_opt, ERRORS_PANIC);
 			break;
 		case Opt_err_ro:
-			kind = EXT2_MOUNT_ERRORS_RO;
+			clear_opt (sbi->s_mount_opt, ERRORS_CONT);
+			clear_opt (sbi->s_mount_opt, ERRORS_PANIC);
+			set_opt (sbi->s_mount_opt, ERRORS_RO);
 			break;
 		case Opt_err_cont:
-			kind = EXT2_MOUNT_ERRORS_CONT;
+			clear_opt (sbi->s_mount_opt, ERRORS_RO);
+			clear_opt (sbi->s_mount_opt, ERRORS_PANIC);
+			set_opt (sbi->s_mount_opt, ERRORS_CONT);
 			break;
 		case Opt_nouid32:
 			set_opt (sbi->s_mount_opt, NO_UID32);
@@ -490,7 +495,6 @@ static int parse_options (char * options
 			return 0;
 		}
 	}
-	sbi->s_mount_opt |= kind;
 	return 1;
 }

@@ -710,6 +714,8 @@ static int ext2_fill_super(struct super_
 		set_opt(sbi->s_mount_opt, ERRORS_PANIC);
 	else if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_RO)
 		set_opt(sbi->s_mount_opt, ERRORS_RO);
+	else
+		set_opt(sbi->s_mount_opt, ERRORS_CONT);

 	sbi->s_resuid = le16_to_cpu(es->s_def_resuid);
 	sbi->s_resgid = le16_to_cpu(es->s_def_resgid);


