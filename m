Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265873AbTIETSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbTIETRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:17:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:26001 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265769AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 12:01:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [15/15] ufs options parsing
Message-Id: <20030905120106.5617196d.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/ufs/super.c linux-260-test4-fs/fs/ufs/super.c
--- linux-260-test4-pv/fs/ufs/super.c	2003-08-22 16:50:21.000000000 -0700
+++ linux-260-test4-fs/fs/ufs/super.c	2003-09-03 14:24:00.000000000 -0700
@@ -79,6 +79,7 @@
 #include <linux/string.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
+#include <linux/parser.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
@@ -250,65 +251,100 @@ void ufs_warning (struct super_block * s
 		sb->s_id, function, error_buf);
 }
 
+enum {
+	Opt_type_old, Opt_type_sunx86, Opt_type_sun, Opt_type_44bsd,
+	Opt_type_hp, Opt_type_nextstepcd, Opt_type_nextstep,
+	Opt_type_openstep, Opt_onerror_panic, Opt_onerror_lock,
+	Opt_onerror_umount, Opt_onerror_repair, Opt_err
+};
+
+static match_table_t tokens = {
+	{Opt_type_old, "ufstype=old"},
+	{Opt_type_sunx86, "ufstype=sunx86"},
+	{Opt_type_sun, "ufstype=sun"},
+	{Opt_type_44bsd, "ufstype=44bsd"},
+	{Opt_type_hp, "ufstype=hp"},
+	{Opt_type_nextstepcd, "ufstype=nextstep-cd"},
+	{Opt_type_nextstep, "ufstype=nextstep"},
+	{Opt_type_openstep, "ufstype=openstep"},
+	{Opt_onerror_panic, "onerror=panic"},
+	{Opt_onerror_lock, "onerror=lock"},
+	{Opt_onerror_umount, "onerror=umount"},
+	{Opt_onerror_repair, "onerror=repair"},
+	{Opt_err, NULL}
+};
+
 static int ufs_parse_options (char * options, unsigned * mount_options)
 {
-	char * this_char;
-	char * value;
+	char * p;
 	
 	UFSD(("ENTER\n"))
 	
 	if (!options)
 		return 1;
 
-	while ((this_char = strsep (&options, ",")) != NULL) {
-		if (!*this_char)
+	while ((p = strsep(&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		if (!*p)
 			continue;
-		if ((value = strchr (this_char, '=')) != NULL)
-			*value++ = 0;
-		if (!strcmp (this_char, "ufstype")) {
-			ufs_clear_opt (*mount_options, UFSTYPE);
-			if (!strcmp (value, "old"))
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_type_old:
+				ufs_clear_opt (*mount_options, UFSTYPE);
 				ufs_set_opt (*mount_options, UFSTYPE_OLD);
-			else if (!strcmp (value, "sun"))
+				break;
+			case Opt_type_sunx86:
+				ufs_clear_opt (*mount_options, UFSTYPE);
+				ufs_set_opt (*mount_options, UFSTYPE_SUNx86);
+				break;
+			case Opt_type_sun:
+				ufs_clear_opt (*mount_options, UFSTYPE);
 				ufs_set_opt (*mount_options, UFSTYPE_SUN);
-			else if (!strcmp (value, "44bsd"))
+				break;
+			case Opt_type_44bsd:
+				ufs_clear_opt (*mount_options, UFSTYPE);
 				ufs_set_opt (*mount_options, UFSTYPE_44BSD);
-			else if (!strcmp (value, "nextstep"))
-				ufs_set_opt (*mount_options, UFSTYPE_NEXTSTEP);
-			else if (!strcmp (value, "nextstep-cd"))
+				break;
+			case Opt_type_hp:
+				ufs_clear_opt (*mount_options, UFSTYPE);
+				ufs_set_opt (*mount_options, UFSTYPE_HP);
+				break;
+			case Opt_type_nextstepcd:
+				ufs_clear_opt (*mount_options, UFSTYPE);
 				ufs_set_opt (*mount_options, UFSTYPE_NEXTSTEP_CD);
-			else if (!strcmp (value, "openstep"))
+				break;
+			case Opt_type_nextstep:
+				ufs_clear_opt (*mount_options, UFSTYPE);
+				ufs_set_opt (*mount_options, UFSTYPE_NEXTSTEP);
+				break;
+			case Opt_type_openstep:
+				ufs_clear_opt (*mount_options, UFSTYPE);
 				ufs_set_opt (*mount_options, UFSTYPE_OPENSTEP);
-			else if (!strcmp (value, "sunx86"))
-				ufs_set_opt (*mount_options, UFSTYPE_SUNx86);
-			else if (!strcmp (value, "hp"))
-				ufs_set_opt (*mount_options, UFSTYPE_HP);
-			else {
-				printk ("UFS-fs: Invalid type option: %s\n", value);
-				return 0;
-			}
-		}
-		else if (!strcmp (this_char, "onerror")) {
-			ufs_clear_opt (*mount_options, ONERROR);
-			if (!strcmp (value, "panic"))
+				break;
+			case Opt_onerror_panic:
+				ufs_clear_opt (*mount_options, ONERROR);
 				ufs_set_opt (*mount_options, ONERROR_PANIC);
-			else if (!strcmp (value, "lock"))
+				break;
+			case Opt_onerror_lock:
+				ufs_clear_opt (*mount_options, ONERROR);
 				ufs_set_opt (*mount_options, ONERROR_LOCK);
-			else if (!strcmp (value, "umount"))
+				break;
+			case Opt_onerror_umount:
+				ufs_clear_opt (*mount_options, ONERROR);
 				ufs_set_opt (*mount_options, ONERROR_UMOUNT);
-			else if (!strcmp (value, "repair")) {
+				break;
+			case Opt_onerror_repair:
 				printk("UFS-fs: Unable to do repair on error, "
-					"will lock lock instead \n");
+					"will lock lock instead\n");
+				ufs_clear_opt (*mount_options, ONERROR);
 				ufs_set_opt (*mount_options, ONERROR_REPAIR);
-			}
-			else {
-				printk ("UFS-fs: Invalid action onerror: %s\n", value);
+				break;
+			default:
+				printk("UFS-fs: Invalid option: \"%s\" "
+						"or missing value\n", p);
 				return 0;
-			}
-		}
-		else {
-			printk("UFS-fs: Invalid option: %s\n", this_char);
-			return 0;
 		}
 	}
 	return 1;


--
~Randy
