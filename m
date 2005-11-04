Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbVKDPlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbVKDPlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbVKDPla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:41:30 -0500
Received: from mail.capitalgenomix.com ([143.247.20.203]:62854 "EHLO
	mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S1751515AbVKDPl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:41:29 -0500
Date: Fri, 4 Nov 2005 10:42:06 -0500
From: sean@mail.capitalgenomix.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kconfig and lxdialog, kernel 2.6.14
Message-ID: <20051104154206.GB32656@cgx-mail.capitalgenomix.com>
References: <4360FB44.3010900@capitalgenomix.com> <Pine.LNX.4.61.0510272320360.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mconf.patch"
In-Reply-To: <Pine.LNX.4.61.0510272320360.1386@scrub.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 11:27:42PM +0200, Roman Zippel wrote:
>
> On Thu, 27 Oct 2005, Fao, Sean wrote:
>
> > This patch is a functionality modification that implements a proposed design
> > change to lxdialog.  Specifically, this patch makes use of the proposed
> > "Abort" functionality of lxdialog, which adds an "Abort" button in addition
> > to the "Yes" and "No" buttons that are currently displayed when a user exits
> > kconfig.  The Abort button allows a user to return to the root menu of
> > kconfig rather than exiting.
>
> This reminds me I had a similiar patch lying around, could you use this
> one as a basis.

I like your patch because it was the same idea and one less variable.  The
only thing that worries me is that the return value from "changes NOT saved"
is 0 rather than 1, which the original returned.  Is there any reason for
this?

Signed-off-by: Sean Fao <sean.fao@capitalgenomix.com>

---

--- linux-2.6.14/scripts/kconfig/mconf.c	2005-10-27 19:02:08.000000000 -0500
+++ linux/scripts/kconfig/mconf.c	2005-11-03 10:49:43.000000000 -0500
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
+			cprint("--yesnoabort");
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
