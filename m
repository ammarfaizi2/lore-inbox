Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUEVOxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUEVOxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUEVOxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:53:42 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:3562 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S261479AbUEVOx0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:53:26 -0400
Date: Sat, 22 May 2004 22:43:25 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kernel parameter parsing fix
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403FD31C2@PDSMSX403.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.44.0405222155030.10219-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2004, Andrew Morton wrote:
> 
> Can you explain waht problem this solves?  An example?

The real problem happens on 2.6.5 -mm kernel, but not vanilla kernel
because of the early_param patch.

For example in arch/i386/kernel/setup.c:
__early_param("acpi", early_acpi);

In drivers/acpi/osl.c:
__setup("acpi_os_name=", acpi_os_name_setup);

So if one passes kernel parameter in the bootloader as below,

"acpi=force acpi_os_name=my_override_name"

the "acpi_os_name=" parameter will take the setup func for "acpi",
because they begin with the same string "acpi".


Vanilla kernel doesn't have the problem now because most of the
parameter strings have a trailing '=', so "acpi_os_name" won't
take the setup func for "acpi=". But a safer way is to checkup 
the parameter string when parsing it as the patch did.

> 
> The patch is wordwrapped
Sorry, please try this time.

--- linux-2.6.6.orig/init/main.c	2004-05-14 13:38:31.000000000 +0800
+++ linux-2.6.6/init/main.c	2004-05-15 00:25:41.339261792 +0800
@@ -149,11 +149,15 @@ static int __init obsolete_checksetup(ch
 {
 	struct obs_kernel_param *p;
 	extern struct obs_kernel_param __setup_start, __setup_end;
+	char *ptr;
+	int len = strlen(line);
 
+	if ((ptr = strchr(line, '=')))
+		len = ptr - line;
 	p = &__setup_start;
 	do {
 		int n = strlen(p->str);
-		if (!strncmp(line, p->str, n)) {
+		if (len <= n && !strncmp(line, p->str, n)) {
 			if (!p->setup_func) {
 				printk(KERN_WARNING "Parameter %s is
obsolete, ignored\n", p->str);
 				return 1;


Thanks,
-- 
-----------------------------------------------------------------
Opinions expressed are those of the author and do not represent
Intel Corp.

Zhu Yi (Chuyee)

GnuPG v1.0.6 (GNU/Linux)
http://cn.geocities.com/chewie_chuyee/gpg.txt or
$ gpg --keyserver wwwkeys.pgp.net --recv-keys 71C34820
1024D/71C34820 C939 2B0B FBCE 1D51 109A  55E5 8650 DB90 71C3 4820

