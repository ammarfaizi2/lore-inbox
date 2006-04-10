Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWDJH4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWDJH4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWDJH4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:56:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750943AbWDJH4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:56:31 -0400
Date: Sun, 9 Apr 2006 23:55:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
Message-Id: <20060409235548.52b563a9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Andrew, what might be very interesting for you is that kconfig is not 
>  rewriting .config anymore all the time by itself and if you set 
>  KCONFIG_NOSILENTUPDATE you can even omit the silent updates, so unless you 
>  explicitly call one of the config targets, you can be sure kbuild won't 
>  touch your .config symlink anymore and as long as the .config is in sync 
>  with the Kconfig files you shouldn't see a difference. I'm very interested 
>  how that works for you.

Badly, sorry.  `make oldconfig' blows away the .config symlink.



 scripts/kconfig/confdata.c        |   28 ++++++++++++++++++++++++++--
 scripts/kconfig/lxdialog/colors.h |    6 +++---
 2 files changed, 29 insertions(+), 5 deletions(-)

diff -puN scripts/kconfig/lxdialog/colors.h~sane-menuconfig-colours scripts/kconfig/lxdialog/colors.h
--- devel/scripts/kconfig/lxdialog/colors.h~sane-menuconfig-colours	2006-04-09 23:46:02.000000000 -0700
+++ devel-akpm/scripts/kconfig/lxdialog/colors.h	2006-04-09 23:46:02.000000000 -0700
@@ -37,7 +37,7 @@
 #define DIALOG_BG                    COLOR_WHITE
 #define DIALOG_HL                    FALSE
 
-#define TITLE_FG                     COLOR_YELLOW
+#define TITLE_FG                     COLOR_BLUE
 #define TITLE_BG                     COLOR_WHITE
 #define TITLE_HL                     TRUE
 
@@ -109,7 +109,7 @@
 #define ITEM_SELECTED_BG             COLOR_BLUE
 #define ITEM_SELECTED_HL             TRUE
 
-#define TAG_FG                       COLOR_YELLOW
+#define TAG_FG                       COLOR_BLUE
 #define TAG_BG                       COLOR_WHITE
 #define TAG_HL                       TRUE
 
@@ -117,7 +117,7 @@
 #define TAG_SELECTED_BG              COLOR_BLUE
 #define TAG_SELECTED_HL              TRUE
 
-#define TAG_KEY_FG                   COLOR_YELLOW
+#define TAG_KEY_FG                   COLOR_BLUE
 #define TAG_KEY_BG                   COLOR_WHITE
 #define TAG_KEY_HL                   TRUE
 
diff -puN scripts/kconfig/confdata.c~sane-menuconfig-colours scripts/kconfig/confdata.c
--- devel/scripts/kconfig/confdata.c~sane-menuconfig-colours	2006-04-09 23:51:43.000000000 -0700
+++ devel-akpm/scripts/kconfig/confdata.c	2006-04-09 23:55:04.000000000 -0700
@@ -360,6 +360,30 @@ int conf_read(const char *name)
 	return 0;
 }
 
+static int __copy(const char *in_name, const char *out_name)
+{
+	FILE *out;
+	FILE *in;
+	int c;
+
+	out = fopen(out_name, "w");
+	if (!out) {
+		perror("open");
+		return 1;
+	}
+	in = fopen(in_name, "r");
+	if (!in) {
+		perror("open");
+		fclose(out);
+		return 1;
+	}
+	while ((c = fgetc(in)) != EOF)
+		fputc(c, out);
+	fclose(in);
+	fclose(out);
+	return 0;
+}
+
 int conf_write(const char *name)
 {
 	FILE *out;
@@ -502,10 +526,10 @@ int conf_write(const char *name)
 		if (!name)
 			name = conf_def_filename;
 		sprintf(tmpname, "%s.old", name);
-		rename(name, tmpname);
+		__copy(name, tmpname);
 	}
 	sprintf(tmpname, "%s%s", dirname, basename);
-	if (rename(newname, tmpname))
+	if (__copy(newname, tmpname))
 		return 1;
 
 	printf(_("#\n"
_

