Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264262AbUFGAIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbUFGAIk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 20:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbUFGAIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 20:08:39 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:49039 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264263AbUFGAIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 20:08:17 -0400
Subject: RE: idebus setup problem (2.6.7-rc1)
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Auzanneau Gregory <mls@reolight.net>, Jeff Garzik <jgarzik@pobox.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD550B@PDSMSX403.ccr.corp.intel.com>
References: <3ACA40606221794F80A5670F0AF15F8403BD550B@PDSMSX403.ccr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1086566829.18637.44.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 10:07:10 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 23:11, Zhu, Yi wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > 
> > Why can't we apply this minimal fix from Yi for now?
> 
> Thanks, this is in 2.6.7-rc2-mm2.

OK, I've revisited this problem, with my thinking cap ON this time. 
Sorry for the delay.

Andrew, please revert kernel-parameter-parsing-fix.patch and 
kernel-parameter-parsing-fix-fix.patch in favor of this one-liner.

Yi, does this fix your ACPI problem?

Rusty.

Name: Handle __early_param and __setup Collision
Status: Trivial
Depends: EarlyParam/early_param.patch.gz
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Yi Zhu (yi.zhu@intel.com) points out the following problem:

In arch/i386/kernel/setup.c:
	__early_param("acpi", early_acpi);

In drivers/acpi/osl.c:
	__setup("acpi_os_name=", acpi_os_name_setup);

The problem command line looks like:

	"acpi=force acpi_os_name=my_override_name"

For simplicity, we overload the __setup section to contain both
__early_param and __setup, so we can check that all options on the
command line are taken by at least one of them.  However,
__early_param have different semantics the __setup: in particular,
__early_param("acpi"), must not match anything but "acpi" and "acpi=",
which mirrors module_param(), whereas __setup("acpi") would match
anything which starts with "acpi".

Fix the obsolete_checksetup code to take this difference into account
correctly.
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22424-linux-2.6.7-rc2-bk7/init/main.c .22424-linux-2.6.7-rc2-bk7.updated/init/main.c
--- .22424-linux-2.6.7-rc2-bk7/init/main.c	2004-06-07 09:51:11.000000000 +1000
+++ .22424-linux-2.6.7-rc2-bk7.updated/init/main.c	2004-06-07 09:53:06.000000000 +1000
@@ -159,8 +159,9 @@ static int __init obsolete_checksetup(ch
 	do {
 		int n = strlen(p->str);
 		if (!strncmp(line, p->str, n)) {
-			/* Already done in parse_early_param? */
-			if (p->early)
+			/* Already done in parse_early_param?  (Needs
+			 * exact match on param part) */
+			if (p->early && (line[n] == '\0' || line[n] == '='))
 				return 1;
 			if (!p->setup_func) {
 				printk(KERN_WARNING "Parameter %s is obsolete, ignored\n", p->str);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

