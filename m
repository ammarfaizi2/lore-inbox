Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265339AbUFRWMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUFRWMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUFRWLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:11:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:29315 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263713AbUFRWIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:08:35 -0400
Date: Fri, 18 Jun 2004 15:05:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] save kernel version in .config file
Message-Id: <20040618150535.6a421bdb.rddunlap@osdl.org>
In-Reply-To: <20040618205602.GC4441@mars.ravnborg.org>
References: <20040617220651.0ceafa91.rddunlap@osdl.org>
	<20040618053455.GF29808@alpha.home.local>
	<20040618205602.GC4441@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 22:56:02 +0200 Sam Ravnborg wrote:

| On Fri, Jun 18, 2004 at 07:34:55AM +0200, Willy Tarreau wrote:
| > On Thu, Jun 17, 2004 at 10:06:51PM -0700, Randy.Dunlap wrote:
| > > 
| > > Is this interesting to anyone besides me?
| > > Save kernel version info when writing .config file.
| > 
| > Very good idea Randy ! I've already used some wrong config picked out of 20,
| > and having a simple way to do a quick check is really an enhancement. BTW,
| > does KERNELRELEASE include the build number ? and could we include the
| > config date in the file too ?
| 
| Date seems worthwhile. buildnumber does not make sense since we do not
| generate a new .config for each build.

OK, I've added date, based on Sam's comments, but someone tell me,
when/why does filesystem-timestamp not work for this?

Thanks for the replies.

--
~Randy



Save kernel version info and date when writing .config file.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 scripts/kconfig/confdata.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff -Naurp ./scripts/kconfig/confdata.c~config_version ./scripts/kconfig/confdata.c
--- ./scripts/kconfig/confdata.c~config_version	2004-06-15 22:20:21.000000000 -0700
+++ ./scripts/kconfig/confdata.c	2004-06-18 14:27:25.414950216 -0700
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 #include <unistd.h>
 
 #define LKC_DIRECT_LINK
@@ -268,6 +269,7 @@ int conf_write(const char *name)
 	char dirname[128], tmpname[128], newname[128];
 	int type, l;
 	const char *str;
+	time_t now;
 
 	dirname[0] = 0;
 	if (name && name[0]) {
@@ -301,14 +303,22 @@ int conf_write(const char *name)
 		if (!out_h)
 			return 1;
 	}
+	sym = sym_lookup("KERNELRELEASE", 0);
+	time(&now);
 	fprintf(out, "#\n"
 		     "# Automatically generated make config: don't edit\n"
-		     "#\n");
+		     "# Linux kernel version: %s\n"
+		     "# %s"
+		     "#\n",
+		     (char *)sym->curr.val, ctime(&now));
 	if (out_h)
 		fprintf(out_h, "/*\n"
 			       " * Automatically generated C config: don't edit\n"
+			       " * Linux kernel version: %s\n"
+			       " * %s"
 			       " */\n"
-			       "#define AUTOCONF_INCLUDED\n");
+			       "#define AUTOCONF_INCLUDED\n",
+			       (char *)sym->curr.val, ctime(&now));
 
 	if (!sym_change_count)
 		sym_clear_all_valid();
