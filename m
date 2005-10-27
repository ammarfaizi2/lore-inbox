Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbVJ0V1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbVJ0V1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbVJ0V1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:27:44 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:10383 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932642AbVJ0V1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:27:43 -0400
Date: Thu, 27 Oct 2005 23:27:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Fao, Sean" <sean.fao@capitalgenomix.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kconfig and lxdialog, kernel 2.6.13.4
In-Reply-To: <4360FB44.3010900@capitalgenomix.com>
Message-ID: <Pine.LNX.4.61.0510272320360.1386@scrub.home>
References: <4360FB44.3010900@capitalgenomix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Oct 2005, Fao, Sean wrote:

> This patch is a functionality modification that implements a proposed design
> change to lxdialog.  Specifically, this patch makes use of the proposed
> "Abort" functionality of lxdialog, which adds an "Abort" button in *addition*
> to the "Yes" and "No" buttons that are currently displayed when a user exits
> kconfig.  The Abort button allows a user to return to the root menu of kconfig
> rather than exiting.

This reminds me I had a similiar patch lying around, could you use this 
one as a basis.

bye, Roman

 scripts/kconfig/mconf.c |   49 +++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

Index: linux-2.6/scripts/kconfig/mconf.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/mconf.c	2005-10-27 23:02:15.000000000 +0200
+++ linux-2.6/scripts/kconfig/mconf.c	2005-10-27 23:04:12.000000000 +0200
@@ -1064,34 +1064,37 @@ int main(int ac, char **av)
 	tcgetattr(1, &ios_org);
 	atexit(conf_cleanup);
 	init_wsize();
-	conf(&rootmenu);
+	while (1) {
+		conf(&rootmenu);
 
-	do {
-		cprint_init();
-		cprint("--yesno");
-		cprint(_("Do you wish to save your new kernel configuration?"));
-		cprint("5");
-		cprint("60");
-		stat = exec_conf();
-	} while (stat < 0);
+		do {
+			cprint_init();
+			cprint("--yesno");
+			cprint(_("Do you wish to save your new kernel configuration?"));
+			cprint("5");
+			cprint("60");
+			stat = exec_conf();
+		} while (stat < 0);
 
-	if (stat == 0) {
-		if (conf_write(NULL)) {
+		switch (stat) {
+		case 0:
+			if (conf_write(NULL)) {
+				fprintf(stderr, _("\n\n"
+					"Error during writing of the kernel configuration.\n"
+					"Your kernel configuration changes were NOT saved."
+					"\n\n"));
+				return 1;
+			}
+			printf(_("\n\n"
+				"*** End of Linux kernel configuration.\n"
+				"*** Execute 'make' to build the kernel or try 'make help'."
+				"\n\n"));
+			return 0;
+		case 1:
 			fprintf(stderr, _("\n\n"
-				"Error during writing of the kernel configuration.\n"
 				"Your kernel configuration changes were NOT saved."
 				"\n\n"));
-			return 1;
+			return 0;
 		}
-		printf(_("\n\n"
-			"*** End of Linux kernel configuration.\n"
-			"*** Execute 'make' to build the kernel or try 'make help'."
-			"\n\n"));
-	} else {
-		fprintf(stderr, _("\n\n"
-			"Your kernel configuration changes were NOT saved."
-			"\n\n"));
 	}
-
-	return 0;
 }
