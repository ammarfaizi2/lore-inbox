Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbUEAVfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUEAVfB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 17:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUEAVfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 17:35:01 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:20874
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261635AbUEAVe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 17:34:57 -0400
Date: Sat, 1 May 2004 17:34:50 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Marc Boucher <marc@linuxant.com>
Cc: nico@cam.org, marc@linuxant.com, mbligh@aracnet.com, riel@redhat.com,
       rusty@rustcorp.com.au, torvalds@osdl.org,
       tconnors+linuxkernel1083378452@astro.swin.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clarify message and give support contact for non-GPL
 modules
Message-Id: <20040501173450.006bae55.seanlkml@rogers.com>
In-Reply-To: <20040501205336.GA27607@valve.mbsi.ca>
References: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
	<Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home>
	<20040501205336.GA27607@valve.mbsi.ca>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.103.219.176] using ID <seanlkml@rogers.com> at Sat, 1 May 2004 17:34:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004 16:53:36 -0400
Marc Boucher <marc@linuxant.com> wrote:

> Constructive comments/improvements welcome.

I think the following patch is more respectful of the Linux license.  
It also explains to the user why their kernel is now tainted so they
won't be confused when they see "tainted" messages elsewhere.
Also it may encourage more open source drivers which you agree
are better Marc:

--- linux-2.6.6-rc3-bk3/kernel/module.c	2004-05-01 16:06:46.769778360 -0400
+++ linux-2.6.6-rc3-bk3-mb/kernel/module.c	2004-05-01 16:38:02.563614352 -0400
@@ -1125,15 +1125,19 @@
 		|| strcmp(license, "Dual MPL/GPL") == 0);
 }
 
-static void set_license(struct module *mod, const char *license)
+static void set_license(struct module *mod, const char *license, const char *author)
 {
 	if (!license)
 		license = "unspecified";
 
 	mod->license_gplok = license_is_gpl_compatible(license);
-	if (!mod->license_gplok) {
-		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
-		       mod->name, license);
+	if (!mod->license_gplok && !(tainted & TAINT_PROPRIETARY_MODULE)) {
+		printk(KERN_INFO "%s: module has non-GPL license (%s).\n", mod->name, license);
+		printk(KERN_INFO "%s: Please consider supporting vendors that provide open source drivers\n", mod->name);
+		if(author)
+			printk(KERN_INFO "%s: kernel now tainted, for all support contact: %s\n", mod->name, author);
+		else
+			printk(KERN_INFO "%s: kernel now tainted, for all support contact author of this driver\n", mod->name);
 		tainted |= TAINT_PROPRIETARY_MODULE;
 	}
 }
@@ -1470,7 +1473,9 @@
 	module_unload_init(mod);
 
 	/* Set up license info based on the info section */
-	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
+	set_license(mod,
+		get_modinfo(sechdrs, infoindex, "license"),
+		get_modinfo(sechdrs, infoindex, "author"));
 
 	/* Fix up syms, so that st_value is a pointer to location. */
 	err = simplify_symbols(sechdrs, symindex, strtab, versindex, pcpuindex,



