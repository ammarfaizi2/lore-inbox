Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUAOVoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbUAOVoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:44:20 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:15006 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263325AbUAOVoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:44:18 -0500
Date: Thu, 15 Jan 2004 22:44:16 +0100
From: Romain Lievin <romain@rlievin.dyndns.org>
To: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] "gconfig" removed root folder...
Message-ID: <20040115214416.GA25409@rlievin.dyndns.org>
References: <1074177405.3131.10.camel@oebilgen>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1074177405.3131.10.camel@oebilgen>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Today I downloaded 2.6.1 kernel and tried to configure it with "make
> gconfig". After all changes I selected "Save As" and clicked "/root"
> folder to save in. Then I clicked "OK", without giving a file name. I
> expected that it opens root folder and lists contents. But this magic
> configurator removed (rm -Rf) my root folder and created a file named
> "root". It was a terrible experience!..

A patch against 2.6.1 which fix this problem. Please apply...

Thanks, Romain

===========================[cut here]==========================
diff -Naur linux-2.6.1/scripts/kconfig/gconf.c linux/scripts/kconfig/gconf.c
--- linux-2.6.1/scripts/kconfig/gconf.c	2004-01-15 21:45:22.000000000 +0100
+++ linux/scripts/kconfig/gconf.c	2004-01-15 22:36:55.000000000 +0100
@@ -23,6 +23,9 @@
 #include <unistd.h>
 #include <time.h>
 #include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
 
 //#define DEBUG
 
@@ -643,9 +646,18 @@
 store_filename(GtkFileSelection * file_selector, gpointer user_data)
 {
 	const gchar *fn;
+	gchar trailing;
+	struct stat sb;
 
 	fn = gtk_file_selection_get_filename(GTK_FILE_SELECTION
 					     (user_data));
+	
+	/* protect against 'root directory' bug */
+	trailing = fn[strlen(fn)-1];
+	if(stat(fn, &sb) == -1) return;	
+	if(S_ISDIR(sb.st_mode))
+		if(trailing != '/')
+			strcat((char *)fn, "/");
 
 	if (conf_write(fn))
 		text_insert_msg("Error", "Unable to save configuration !");

-- 
Romain Liévin (roms):         <roms@tilp.info>
Web site:                     http://tilp.info
"Linux, y'a moins bien mais c'est plus cher !"






