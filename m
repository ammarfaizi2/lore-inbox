Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268746AbUIQRZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268746AbUIQRZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUIQRZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:25:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:6557 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268746AbUIQRZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 13:25:15 -0400
Date: Fri, 17 Sep 2004 10:20:24 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Olaf Hering <olh@suse.de>, akpm <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: [PATCH] kconfig: OVERRIDE: save kernel version in .config file
Message-Id: <20040917102024.50188756.rddunlap@osdl.org>
In-Reply-To: <20040917154346.GA15156@suse.de>
References: <20040917154346.GA15156@suse.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 17:43:46 +0200 Olaf Hering wrote:

| Randy,
| 
| we need a way to turn the timestamp off when running make oldconfig.
| Running make oldconfig gives always a delta, even if the .config is
| unchanged. This is bad for cvs repos, it generates conflicts now if 2
| people work on the same config file.
| Please provide a patch to not call ctime if a non-empty enviroment
| variable of your choice is set.

How's this?



Omit .config file timestamp in the file if the environment
variable "NOTIMESTAMP" is present (its value is not checked).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 scripts/kconfig/confdata.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff -Naurp ./scripts/kconfig/confdata.c~nostamp ./scripts/kconfig/confdata.c
--- ./scripts/kconfig/confdata.c~nostamp	2004-09-14 14:21:50.855120560 -0700
+++ ./scripts/kconfig/confdata.c	2004-09-17 08:51:42.050127184 -0700
@@ -270,6 +270,8 @@ int conf_write(const char *name)
 	int type, l;
 	const char *str;
 	time_t now;
+	int use_timestamp = 1;
+	char *env;
 
 	dirname[0] = 0;
 	if (name && name[0]) {
@@ -306,22 +308,28 @@ int conf_write(const char *name)
 	sym = sym_lookup("KERNELRELEASE", 0);
 	sym_calc_value(sym);
 	time(&now);
+	env = getenv("NOTIMESTAMP");
+	if (env)
+		use_timestamp = 0;
+
 	fprintf(out, "#\n"
 		     "# Automatically generated make config: don't edit\n"
 		     "# Linux kernel version: %s\n"
-		     "# %s"
+		     "%s%s"
 		     "#\n",
 		     sym_get_string_value(sym),
-		     ctime(&now));
+		     use_timestamp ? "# " : "",
+		     use_timestamp ? ctime(&now) : "");
 	if (out_h)
 		fprintf(out_h, "/*\n"
 			       " * Automatically generated C config: don't edit\n"
 			       " * Linux kernel version: %s\n"
-			       " * %s"
+			       "%s%s"
 			       " */\n"
 			       "#define AUTOCONF_INCLUDED\n",
 			       sym_get_string_value(sym),
-			       ctime(&now));
+			       use_timestamp ? " * " : "",
+			       use_timestamp ? ctime(&now) : "");
 
 	if (!sym_change_count)
 		sym_clear_all_valid();
--
