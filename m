Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUAROVx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 09:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUAROVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 09:21:53 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:34232 "EHLO
	mwinf0102.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261605AbUAROVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 09:21:51 -0500
Date: Sun, 18 Jan 2004 15:21:48 +0100
From: Romain Lievin <romain@rlievin.dyndns.org>
To: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: True story: "gconfig" removed root folder...
Message-ID: <20040118142148.GB2273@rlievin.dyndns.org>
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

a patch for gconfig against kernel2.6.1.

Thanks to Tomas and Ozan.

Romain.

================ [ cut here ] ===========
diff -Naur linux-2.6.1/scripts/kconfig/gconf.c linux/scripts/kconfig/gconf.c
--- linux-2.6.1/scripts/kconfig/gconf.c	2004-01-15 21:45:22.000000000 +0100
+++ linux/scripts/kconfig/gconf.c	2004-01-18 15:15:23.000000000 +0100
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
+	stat (fn, &sb);
+	safe_fn = g_strdup (fn);
+
+	if (S_ISDIR(sb.st_mode))
+		if (trailing != '/')
+		{
+			g_free (safe_fn);
+			safe_fn = g_strconcat (fn, "/", NULL);
+		}
 
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






