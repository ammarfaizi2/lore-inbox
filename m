Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUFGXBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUFGXBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUFGXBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:01:10 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:56007 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S265108AbUFGXBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:01:01 -0400
Subject: RE: idebus setup problem (2.6.7-rc1)
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Auzanneau Gregory <mls@reolight.net>, Jeff Garzik <jgarzik@pobox.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F842DB1F7@PDSMSX403.ccr.corp.intel.com>
References: <3ACA40606221794F80A5670F0AF15F842DB1F7@PDSMSX403.ccr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1086649200.7998.2.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 09:00:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 21:04, Zhu, Yi wrote:
> > For simplicity, we overload the __setup section to contain
> > both __early_param and __setup, so we can check that all
> > options on the command line are taken by at least one of
> > them.  However, __early_param have different semantics the
> > __setup: in particular, __early_param("acpi"), must not match
> > anything but "acpi" and "acpi=", which mirrors
> > module_param(), whereas __setup("acpi") would match anything
> > which starts with "acpi".
> 
> Really? I think currently only ide_setup is an exception for __setup(),
> which will match all params given in command line.

No, there is at least one other place which relies on this feature last
I searched.  They're all supposed to be stem matches, so __setup("foo")
matches "foobar=100" for example.

> > -			/* Already done in parse_early_param? */
> > -			if (p->early)
> > +			/* Already done in parse_early_param?  (Needs
> > +			 * exact match on param part) */
> > +			if (p->early && (line[n] == '\0' ||
> > line[n] == '='))
> >  				return 1;
> >  			if (!p->setup_func) {
> >  				printk(KERN_WARNING "Parameter
> > %s is obsolete, ignored\n", p->str);
> 
> This doesn't work. The p->setup_func for "acpi" will still be called on
> behalf of "acpi_os_name".
> 
> Below change should work.

Good point, but I think this is clearer:

Name: Handle __early_param and __setup Collision
Status: Booted on 2.6.7-rc2-bk7
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9590-linux-2.6.7-rc2-bk7/init/main.c .9590-linux-2.6.7-rc2-bk7.updated/init/main.c
--- .9590-linux-2.6.7-rc2-bk7/init/main.c	2004-06-08 08:44:23.000000000 +1000
+++ .9590-linux-2.6.7-rc2-bk7.updated/init/main.c	2004-06-08 08:48:15.000000000 +1000
@@ -159,10 +159,12 @@ static int __init obsolete_checksetup(ch
 	do {
 		int n = strlen(p->str);
 		if (!strncmp(line, p->str, n)) {
-			/* Already done in parse_early_param? */
-			if (p->early)
-				return 1;
-			if (!p->setup_func) {
+			if (p->early) {
+				/* Already done in parse_early_param?  (Needs
+				 * exact match on param part) */
+				if (line[n] == '\0' || line[n] == '=')
+					return 1;
+			} else if (!p->setup_func) {
 				printk(KERN_WARNING "Parameter %s is obsolete, ignored\n", p->str);
 				return 1;
 			} else if (p->setup_func(line + n))

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

