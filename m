Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbTIETQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265838AbTIETPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:15:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:23953 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265772AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 11:58:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [11/15] isofs options parsing
Message-Id: <20030905115852.19197ada.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/isofs/inode.c linux-260-test4-fs/fs/isofs/inode.c
--- linux-260-test4-pv/fs/isofs/inode.c	2003-08-22 17:01:28.000000000 -0700
+++ linux-260-test4-fs/fs/isofs/inode.c	2003-09-03 14:02:05.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
+#include <linux/parser.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
@@ -328,9 +329,51 @@ isofs_dentry_cmpi_ms(struct dentry *dent
 }
 #endif
 
+enum {
+	Opt_block, Opt_check_r, Opt_check_s, Opt_cruft, Opt_gid, Opt_ignore,
+	Opt_iocharset, Opt_map_a, Opt_map_n, Opt_map_o, Opt_mode, Opt_nojoliet,
+	Opt_norock, Opt_sb, Opt_session, Opt_uid, Opt_unhide, Opt_utf8, Opt_err,
+	Opt_nocompress,
+};
+
+static match_table_t tokens = {
+	{Opt_norock, "norock"},
+	{Opt_nojoliet, "nojoliet"},
+	{Opt_unhide, "unhide"},
+	{Opt_cruft, "cruft"},
+	{Opt_utf8, "utf8"},
+	{Opt_iocharset, "iocharset=%s"},
+	{Opt_map_a, "map=acorn"},
+	{Opt_map_a, "map=a"},
+	{Opt_map_n, "map=normal"},
+	{Opt_map_n, "map=n"},
+	{Opt_map_o, "map=off"},
+	{Opt_map_o, "map=o"},
+	{Opt_session, "session=%u"},
+	{Opt_sb, "sbsector=%u"},
+	{Opt_check_r, "check=relaxed"},
+	{Opt_check_r, "check=r"},
+	{Opt_check_s, "check=strict"},
+	{Opt_check_s, "check=s"},
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_mode, "mode=%u"},
+	{Opt_block, "block=%u"},
+	{Opt_ignore, "conv=binary"},
+	{Opt_ignore, "conv=b"},
+	{Opt_ignore, "conv=text"},
+	{Opt_ignore, "conv=t"},
+	{Opt_ignore, "conv=mtext"},
+	{Opt_ignore, "conv=m"},
+	{Opt_ignore, "conv=auto"},
+	{Opt_ignore, "conv=a"},
+	{Opt_nocompress, "nocompress"},
+	{Opt_err, NULL}
+};
+
 static int parse_options(char *options, struct iso9660_options * popt)
 {
-	char *this_char,*value;
+	char *p;
 
 	popt->map = 'n';
 	popt->rock = 'y';
@@ -350,112 +393,89 @@ static int parse_options(char *options, 
 	popt->utf8 = 0;
 	popt->session=-1;
 	popt->sbsector=-1;
-	if (!options) return 1;
-	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
+	if (!options)
+		return 1;
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token;
+		substring_t args[MAX_OPT_ARGS];
+		unsigned n;
+
+		if (!*p)
 			continue;
-	        if (strncmp(this_char,"norock",6) == 0) {
-		  popt->rock = 'n';
-		  continue;
-		}
-	        if (strncmp(this_char,"nojoliet",8) == 0) {
-		  popt->joliet = 'n';
-		  continue;
-		}
-	        if (strncmp(this_char,"unhide",6) == 0) {
-		  popt->unhide = 'y';
-		  continue;
-		}
-	        if (strncmp(this_char,"cruft",5) == 0) {
-		  popt->cruft = 'y';
-		  continue;
-		}
-	        if (strncmp(this_char,"utf8",4) == 0) {
-		  popt->utf8 = 1;
-		  continue;
-		}
-	        if (strncmp(this_char,"nocompress",10) == 0) {
-		  popt->nocompress = 1;
-		  continue;
-		}
-		if ((value = strchr(this_char,'=')) != NULL)
-			*value++ = 0;
 
+		token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_norock:
+				popt->rock = 'n';
+				break;
+			case Opt_nojoliet:
+				popt->joliet = 'n';
+				break;
+			case Opt_unhide:
+				popt->unhide = 'y';
+				break;
+			case Opt_cruft:
+				popt->cruft = 'y';
+				break;
+			case Opt_utf8:
+				popt->utf8 = 1;
+				break;
 #ifdef CONFIG_JOLIET
-		if (!strcmp(this_char,"iocharset") && value) {
-			popt->iocharset = value;
-			while (*value && *value != ',')
-				value++;
-			if (value == popt->iocharset)
-				return 0;
-			*value = 0;
-		} else
+			case Opt_iocharset:
+				popt->iocharset = match_strdup(&args[0]);
+				break;
 #endif
-		if (!strcmp(this_char,"map") && value) {
-			if (value[0] && !value[1] && strchr("ano",*value))
-				popt->map = *value;
-			else if (!strcmp(value,"off")) popt->map = 'o';
-			else if (!strcmp(value,"normal")) popt->map = 'n';
-			else if (!strcmp(value,"acorn")) popt->map = 'a';
-			else return 0;
-		}
-		if (!strcmp(this_char,"session") && value) {
-			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-			if(ivalue < 0 || ivalue >99) return 0;
-			popt->session=ivalue+1;
-		}
-		if (!strcmp(this_char,"sbsector") && value) {
-			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-			if(ivalue < 0 || ivalue >660*512) return 0;
-			popt->sbsector=ivalue;
-		}
-		else if (!strcmp(this_char,"check") && value) {
-			if (value[0] && !value[1] && strchr("rs",*value))
-				popt->check = *value;
-			else if (!strcmp(value,"relaxed")) popt->check = 'r';
-			else if (!strcmp(value,"strict")) popt->check = 's';
-			else return 0;
-		}
-		else if (!strcmp(this_char,"conv") && value) {
-			/* no conversion is done anymore;
-			   we still accept the same mount options,
-			   but ignore them */
-			if (value[0] && !value[1] && strchr("btma",*value)) ;
-			else if (!strcmp(value,"binary")) ;
-			else if (!strcmp(value,"text")) ;
-			else if (!strcmp(value,"mtext")) ;
-			else if (!strcmp(value,"auto")) ;
-			else return 0;
-		}
-		else if (value &&
-			 (!strcmp(this_char,"block") ||
-			  !strcmp(this_char,"mode") ||
-			  !strcmp(this_char,"uid") ||
-			  !strcmp(this_char,"gid"))) {
-		  char * vpnt = value;
-		  unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-		  if (*vpnt) return 0;
-		  switch(*this_char) {
-		  case 'b':
-		    if (   ivalue != 512
-			&& ivalue != 1024
-			&& ivalue != 2048) return 0;
-		    popt->blocksize = ivalue;
-		    break;
-		  case 'u':
-		    popt->uid = ivalue;
-		    break;
-		  case 'g':
-		    popt->gid = ivalue;
-		    break;
-		  case 'm':
-		    popt->mode = ivalue;
-		    break;
-		  }
+			case Opt_map_a:
+				popt->map = 'a';
+				break;
+			case Opt_map_o:
+				popt->map = 'o';
+				break;
+			case Opt_map_n:
+				popt->map = 'n';
+				break;
+			case Opt_session:
+				n = match_int(&args[0]);
+				if (n > 99)
+					return 0;
+				popt->session = n + 1;
+				break;
+			case Opt_sb:
+				n = match_int(&args[0]);
+				if (n > 660 * 512)
+					return 0;
+				popt->sbsector = n;
+				break;
+			case Opt_check_r:
+				popt->check = 'r';
+				break;
+			case Opt_check_s:
+				popt->check = 's';
+				break;
+			case Opt_ignore:
+				break;
+			case Opt_uid:
+				popt->uid = match_int(&args[0]);
+				break;
+			case Opt_gid:
+				popt->gid = match_int(&args[0]);
+				break;
+			case Opt_mode:
+				popt->mode = match_int(&args[0]);
+				break;
+			case Opt_block:
+				n = match_int(&args[0]);
+				if (n != 512 && n != 1024 && n != 2048)
+					return 0;
+				popt->blocksize = n;
+				break;
+			case Opt_nocompress:
+				popt->nocompress = 1;
+				break;
+			default:
+				return 0;
 		}
-		else return 1;
 	}
 	return 1;
 }
@@ -842,6 +862,9 @@ root_found:
 	if (opt.check == 'r') table++;
 	s->s_root->d_op = &isofs_dentry_ops[table];
 
+	if (opt.iocharset)
+		kfree(opt.iocharset);
+
 	return 0;
 
 	/*
@@ -879,6 +902,8 @@ out_unknown_format:
 out_freebh:
 	brelse(bh);
 out_freesbi:
+	if (opt.iocharset)
+		kfree(opt.iocharset);
 	kfree(sbi);
 	s->s_fs_info = NULL;
 	return -EINVAL;


--
~Randy
