Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbUAPURi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265553AbUAPURh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:17:37 -0500
Received: from [212.174.195.226] ([212.174.195.226]:52203 "EHLO
	uekae.uekae.gov.tr") by vger.kernel.org with ESMTP id S265699AbUAPURS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:17:18 -0500
Message-ID: <35413.212.174.53.232.1074284229.squirrel@www.uekae.tubitak.gov.tr>
In-Reply-To: <20040115214416.GA25409@rlievin.dyndns.org>
References: <1074177405.3131.10.camel@oebilgen>
    <20040115214416.GA25409@rlievin.dyndns.org>
Date: Fri, 16 Jan 2004 22:17:09 +0200 (EET)
Subject: [PATCH] Bug in patch of 
     =?iso-8859-9?Q?Romain:=A0"gconfig"=A0removed=A0root=A0folder...?=
From: oebilgen@uekae.tubitak.gov.tr
To: "Romain Lievin" <romain@rlievin.dyndns.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-9
X-Priority: 3
Importance: Normal
X-Pyzor: Reported 0 times.
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,


Romain, I guess that there will be a segmentation fault because of:

   strcat((char *)fn, "/");

because:

   fn + strlen (fn) + 1

is not allocated for "fn" and strcat(3) may fail (may fail: It might
escape from segfault if gtk_file_selection_get_filename() has an indolent
allocation strategy for fn - like in "Vector" class of C++). It still is a
bug.

Try this. And Romain, this was my first patch (and also first bug report)
for linux-kernel, THX for your hint. I would lose too much time in order
to find store_file@linux-2.6.1/scripts/kconfig/gconf.c ;)


NOTE: I combined mine and Romain's patch, *** DO NOT APPLY BOTH *** !!!

--- scripts/kconfig/gconf.c	2004-01-09 09:00:03.000000000 +0200
+++ scripts/kconfig/gconf-oebilgen_and_romain.c	2004-01-16
21:32:26.000000000 +0200
@@ -23,6 +23,9 @@
 #include <unistd.h>
 #include <time.h>
 #include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+

 //#define DEBUG

@@ -643,13 +646,29 @@
 store_filename(GtkFileSelection * file_selector, gpointer user_data)
 {
 	const gchar *fn;
+	gchar trailing, *safefn;
+	struct stat sb;

 	fn = gtk_file_selection_get_filename(GTK_FILE_SELECTION
 					     (user_data));

-	if (conf_write(fn))
+	/* protect against 'root directory' bug */
+	trailing = fn[strlen(fn)-1];
+	if(stat(fn, &sb) == -1)
+		return;
+	if(S_ISDIR(sb.st_mode))
+		if(trailing != '/')
+		{
+			safefn = (gchar *) malloc (strlen (fn) + 2);
+			strcpy ((char *) safefn, (char *) fn);
+			strcat ((char *) safefn, "/");
+                }
+
+	if (conf_write(safefn))
 		text_insert_msg("Error", "Unable to save configuration !");

+	free (safefn);
+
 	gtk_widget_destroy(GTK_WIDGET(user_data));
 }


To Doug McNaught and "viro"; running gconf as root it is not a must of
course but one couldn't be punished that hard. If you run gconf as normal
user, you still may experience this (a user friendly bug :P) by loosing
your (home) folders...


BTW, I looked to conf_write and saw that its char arrays are very
dangerous. I will hack it on monday, if possible. ("Open source groups are
like mafia; you can join but cannot leave")


THX in advance,

Comp. Eng. Ozan Eren BILGEN

TUBITAK - UEKAE (Turkey)
National Research Institute of Electronics & Cryptology
Special Projects Group
Researcher


> Hi,
>
>> Today I downloaded 2.6.1 kernel and tried to configure it with "make
>> gconfig". After all changes I selected "Save As" and clicked "/root"
>> folder to save in. Then I clicked "OK", without giving a file name. I
>> expected that it opens root folder and lists contents. But this magic
>> configurator removed (rm -Rf) my root folder and created a file named
>> "root". It was a terrible experience!..
>
> A patch against 2.6.1 which fix this problem. Please apply...
>
> Thanks, Romain
>
> ===========================[cut here]=========================diff -Naur
> linux-2.6.1/scripts/kconfig/gconf.c linux/scripts/kconfig/gconf.c
> --- linux-2.6.1/scripts/kconfig/gconf.c	2004-01-15 21:45:22.000000000
> +0100
> +++ linux/scripts/kconfig/gconf.c	2004-01-15 22:36:55.000000000 +0100
> @@ -23,6 +23,9 @@
>  #include <unistd.h>
>  #include <time.h>
>  #include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
>
>  //#define DEBUG
>
> @@ -643,9 +646,18 @@
>  store_filename(GtkFileSelection * file_selector, gpointer user_data)
>  {
>  	const gchar *fn;
> +	gchar trailing;
> +	struct stat sb;
>
>  	fn = gtk_file_selection_get_filename(GTK_FILE_SELECTION
>  					     (user_data));
> +
> +	/* protect against 'root directory' bug */
> +	trailing = fn[strlen(fn)-1];
> +	if(stat(fn, &sb) == -1) return;
> +	if(S_ISDIR(sb.st_mode))
> +		if(trailing != '/')
> +			strcat((char *)fn, "/");
>
>  	if (conf_write(fn))
>  		text_insert_msg("Error", "Unable to save configuration !");
>
> --
> Romain Liévin (roms):         <roms@tilp.info>
> Web site:                     http://tilp.info
> "Linux, y'a moins bien mais c'est plus cher !"
>
>


