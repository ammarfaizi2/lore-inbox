Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUEAUxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUEAUxo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUEAUxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 16:53:44 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:28861 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S262138AbUEAUxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 16:53:41 -0400
Date: Sat, 1 May 2004 16:53:36 -0400
From: Marc Boucher <marc@linuxant.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Marc Boucher <marc@linuxant.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Rik van Riel <riel@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Tim Connors <tconnors+linuxkernel1083378452@astro.swin.edu.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] clarify message and give support contact for non-GPL modules
Message-ID: <20040501205336.GA27607@valve.mbsi.ca>
References: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 03:47:15PM -0400, Nicolas Pitre wrote:
> On Sat, 1 May 2004, Marc Boucher wrote:
> 
> > Let's deal with the root problem and fix the messages, as Rik van Riel
> > has suggested.
> 
> Please do yourself and the rest of us a favor.  Stop waiting and _do_ submit
> a patch yourself for precisely that root problem.
> 
> That's what you should have done in the first place instead of being lazy,
> but it's not too late for Linuxant people to show they care about resolving
> this issue, and about the community they rely upon, as much as they care
> about their customers.

ok, please see tentative patch for 2.6 below, incorporating Rusty's change
to only emit the warning once, and Rik's suggestion to explicitly direct users
to the party responsible for support, if specified as
MODULE_AUTHOR("NAME <EMAIL>").

Constructive comments/improvements welcome.

Marc

-- 
Marc Boucher
Linuxant inc.

--- linux-2.6.6-rc3-bk3/kernel/module.c	2004-05-01 16:06:46.769778360 -0400
+++ linux-2.6.6-rc3-bk3-mb/kernel/module.c	2004-05-01 16:38:02.563614352 -0400
@@ -1125,15 +1125,18 @@
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
+		if(author)
+			printk(KERN_INFO "%s: for any support issues, please contact %s\n", mod->name, author);
+		else
+			printk(KERN_INFO "%s: the Linux kernel community cannot resolve problems you may encounter when using this module.\n", mod->name);
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
