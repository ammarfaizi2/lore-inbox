Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUAUTyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUAUTyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:54:17 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:44488 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266136AbUAUTyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:54:14 -0500
Date: Wed, 21 Jan 2004 20:54:10 +0100
From: Romain Lievin <romain@rlievin.dyndns.org>
To: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] "gconfig" removed root folder...
Message-ID: <20040121195410.GA13333@rlievin.dyndns.org>
References: <1074177405.3131.10.camel@oebilgen>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1074177405.3131.10.camel@oebilgen>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This new patch includes Muli's remarks.
Need to be applied against a 2.6.1 kernel.

Thanks, Romain.
==========================[ cut here]==========================
diff -Naur linux-2.6.1/scripts/kconfig/gconf.c linux/scripts/kconfig/gconf.c
--- linux-2.6.1/scripts/kconfig/gconf.c	2004-01-15 21:45:22.000000000 +0100
+++ linux/scripts/kconfig/gconf.c	2004-01-21 20:48:04.000000000 +0100
@@ -23,6 +23,9 @@
 #include <unistd.h>
 #include <time.h>
 #include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
 
 //#define DEBUG
 
@@ -643,14 +646,29 @@
 store_filename(GtkFileSelection * file_selector, gpointer user_data)
 {
 	const gchar *fn;
+	gchar trailing;
+	gchar *safe_fn;
+	struct stat sb;
 
-	fn = gtk_file_selection_get_filename(GTK_FILE_SELECTION
+	fn = gtk_file_selection_get_filename (GTK_FILE_SELECTION
 					     (user_data));
 
-	if (conf_write(fn))
-		text_insert_msg("Error", "Unable to save configuration !");
+	/* protect against 'root directory' bug */
+	trailing = fn[strlen (fn)-1];
+	safe_fn = g_strdup (fn);
+
+	if(!stat (fn, &sb))
+		if (S_ISDIR(sb.st_mode))
+			if (trailing != '/')
+			{
+				g_free (safe_fn);
+				safe_fn = g_strconcat (fn, "/", NULL);
+			}
 
-	gtk_widget_destroy(GTK_WIDGET(user_data));
+	if (conf_write (safe_fn))
+		text_insert_msg("Error", "Unable to save configuration !");
+	g_free (safe_fn);
+	gtk_widget_destroy (GTK_WIDGET(user_data));
 }
 
 void on_save_as1_activate(GtkMenuItem * menuitem, gpointer user_data)

-- 
Romain Li�vin (roms):         <roms@tilp.info>
Web site:                     http://tilp.info
"Linux, y'a moins bien mais c'est plus cher !"






