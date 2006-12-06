Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937066AbWLFScY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937066AbWLFScY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937069AbWLFScY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:32:24 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:47986 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937066AbWLFScX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:32:23 -0500
Date: Wed, 6 Dec 2006 19:32:21 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix linux banner utsname information
Message-ID: <20061206183221.GB16927@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Containers <containers@lists.osdl.org>,
	linux-kernel@vger.kernel.org
References: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com> <20061127202211.GB26108@MAIL.13thfloor.at> <m1y7pwldi4.fsf@ebiederm.dsl.xmission.com> <20061128143250.GA23131@MAIL.13thfloor.at> <m1y7pvinta.fsf@ebiederm.dsl.xmission.com> <20061204223248.GA31399@MAIL.13thfloor.at> <20061205172407.GA15450@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205172407.GA15450@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 06:24:09PM +0100, Herbert Poetzl wrote:
> On Mon, Dec 04, 2006 at 11:32:48PM +0100, Herbert Poetzl wrote:
> > 
> > utsname information is shown in the linux banner, which
> > also is used for /proc/version (which can have different
> > utsname values inside a uts namespaces). this patch
> > makes the varying data arguments and changes the string
> > to a format string, using those arguments.
> > 
> > best,
> > Herbert
> 
> d'oh! just figured I lost the two new includes required
> in main.c, will send an updated version shortly

okay, here is the complete and tested version ...

Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>

--- linux-2.6.19/fs/proc/proc_misc.c	2006-11-30 21:19:28 +0100
+++ linux-2.6.19-banner/fs/proc/proc_misc.c	2006-12-06 07:10:41 +0100
@@ -252,8 +252,8 @@ static int version_read_proc(char *page,
 {
 	int len;
 
-	strcpy(page, linux_banner);
-	len = strlen(page);
+	len = sprintf(page, linux_banner,
+		utsname()->release, utsname()->version);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
--- linux-2.6.19/init/Makefile	2006-09-20 16:58:44 +0200
+++ linux-2.6.19-banner/init/Makefile	2006-12-06 07:10:41 +0100
@@ -15,6 +15,7 @@ clean-files := ../include/linux/compile.
 
 # dependencies on generated files need to be listed explicitly
 
+$(obj)/main.o: include/linux/compile.h
 $(obj)/version.o: include/linux/compile.h
 
 # compile.h changes depending on hostname, generation number, etc,
--- linux-2.6.19/init/main.c	2006-11-30 21:19:43 +0100
+++ linux-2.6.19-banner/init/main.c	2006-12-06 07:10:41 +0100
@@ -49,6 +49,8 @@
 #include <linux/buffer_head.h>
 #include <linux/debug_locks.h>
 #include <linux/lockdep.h>
+#include <linux/utsrelease.h>
+#include <linux/compile.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -501,7 +503,7 @@ asmlinkage void __init start_kernel(void
 	boot_cpu_init();
 	page_address_init();
 	printk(KERN_NOTICE);
-	printk(linux_banner);
+	printk(linux_banner, UTS_RELEASE, UTS_VERSION);
 	setup_arch(&command_line);
 	unwind_setup();
 	setup_per_cpu_areas();
--- linux-2.6.19/init/version.c	2006-11-30 21:19:43 +0100
+++ linux-2.6.19-banner/init/version.c	2006-12-06 07:10:41 +0100
@@ -35,5 +35,6 @@ struct uts_namespace init_uts_ns = {
 EXPORT_SYMBOL_GPL(init_uts_ns);
 
 const char linux_banner[] =
-	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+	"Linux version %s (" LINUX_COMPILE_BY "@"
+	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") %s\n";
+
