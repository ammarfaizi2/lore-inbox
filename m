Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUFGLF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUFGLF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUFGLF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:05:27 -0400
Received: from fmr05.intel.com ([134.134.136.6]:2530 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S261672AbUFGLFI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:05:08 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: idebus setup problem (2.6.7-rc1)
Date: Mon, 7 Jun 2004 19:04:10 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F842DB1F7@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: idebus setup problem (2.6.7-rc1)
Thread-Index: AcRMI4KHu1vMs73ERmKvDX5+PF6yUAAQsHTQ
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>
Cc: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Herbert Poetzl" <herbert@13thfloor.at>,
       "Auzanneau Gregory" <mls@reolight.net>,
       "Jeff Garzik" <jgarzik@pobox.com>,
       "lkml - Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 07 Jun 2004 11:04:10.0774 (UTC) FILETIME=[29200B60:01C44C7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> OK, I've revisited this problem, with my thinking cap ON this time.
> Sorry for the delay. 
> 
> Andrew, please revert kernel-parameter-parsing-fix.patch and
> kernel-parameter-parsing-fix-fix.patch in favor of this one-liner.
> 
> Yi, does this fix your ACPI problem?
> 
> Rusty.
> 
> Name: Handle __early_param and __setup Collision
> Status: Trivial
> Depends: EarlyParam/early_param.patch.gz
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Yi Zhu (yi.zhu@intel.com) points out the following problem:
> 
> In arch/i386/kernel/setup.c:
> 	__early_param("acpi", early_acpi);
> 
> In drivers/acpi/osl.c:
> 	__setup("acpi_os_name=", acpi_os_name_setup);
> 
> The problem command line looks like:
> 
> 	"acpi=force acpi_os_name=my_override_name"
> 
> For simplicity, we overload the __setup section to contain
> both __early_param and __setup, so we can check that all
> options on the command line are taken by at least one of
> them.  However, __early_param have different semantics the
> __setup: in particular, __early_param("acpi"), must not match
> anything but "acpi" and "acpi=", which mirrors
> module_param(), whereas __setup("acpi") would match anything
> which starts with "acpi".

Really? I think currently only ide_setup is an exception for __setup(),
which will match all params given in command line.

> 
> Fix the obsolete_checksetup code to take this difference into account
> correctly. 
> 
> diff -urpN --exclude TAGS -X
> /home/rusty/devel/kernel/kernel-patches/current-dontdiff
> --minimal .22424-linux-2.6.7-rc2-bk7/init/main.c
> .22424-linux-2.6.7-rc2-bk7.updated/init/main.c
> --- .22424-linux-2.6.7-rc2-bk7/init/main.c	2004-06-07
> 09:51:11.000000000 +1000 +++
> .22424-linux-2.6.7-rc2-bk7.updated/init/main.c 2004-06-07
> 09:53:06.000000000 +1000 @@ -159,8 +159,9 @@ static int __init
>  		obsolete_checksetup(ch  	do { int n =
strlen(p->str);
>  		if (!strncmp(line, p->str, n)) {
> -			/* Already done in parse_early_param? */
> -			if (p->early)
> +			/* Already done in parse_early_param?  (Needs
> +			 * exact match on param part) */
> +			if (p->early && (line[n] == '\0' ||
> line[n] == '='))
>  				return 1;
>  			if (!p->setup_func) {
>  				printk(KERN_WARNING "Parameter
> %s is obsolete, ignored\n", p->str);

This doesn't work. The p->setup_func for "acpi" will still be called on
behalf of "acpi_os_name".

Below change should work.

Thanks,
-yi

--- linux-2.6.7-rc2-mm2.orig/init/main.c	2004-06-07
16:01:25.000000000 +0800
+++ linux-2.6.7-rc2-mm2/init/main.c	2004-06-07 18:50:22.256204536
+0800
@@ -154,18 +154,22 @@ static int __init obsolete_checksetup(ch
 {
 	struct obs_kernel_param *p;
 	extern struct obs_kernel_param __setup_start, __setup_end;
-	char *ptr;
-	int len = strlen(line);
 
-	if ((ptr = strchr(line, '=')))
-		len = ptr - line;
 	p = &__setup_start;
 	do {
 		int n = strlen(p->str);
-		if (n == 0 || (len <= n && !strncmp(line, p->str, n))) {
-			/* Already done in parse_early_param? */
-			if (p->early)
-				return 1;
+		if (!strncmp(line, p->str, n)) {
+			if (p->early) {
+				/* Already done in parse_early_param?
(Needs
+				 * exact match on param part) */
+				if (p->early && (line[n] == '\0' ||
+				    line[n] == '='))
+					return 1;
+				else {
+					p++;
+					continue;
+				}
+			}
 			if (!p->setup_func) {
 				printk(KERN_WARNING "Parameter %s is
obsolete,"
 						" ignored\n", p->str);

