Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbUEAWW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUEAWW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUEAWW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:22:58 -0400
Received: from web01-imail.bloor.is.net.cable.rogers.com ([66.185.86.75]:52679
	"EHLO web01-imail.rogers.com") by vger.kernel.org with ESMTP
	id S262441AbUEAWWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:22:44 -0400
Date: Sat, 1 May 2004 18:22:45 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Marc Boucher <marc@linuxant.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, riel@redhat.com,
       tconnors+linuxkernel1083378452@astro.swin.edu.au, mbligh@aracnet.com,
       torvalds@osdl.org, nico@cam.org
Subject: Re: [PATCH] clarify message and give support contact for non-GPL
 modules
Message-Id: <20040501182245.3acce85d.seanlkml@rogers.com>
In-Reply-To: <3F6634E3-9BB9-11D8-B83D-000A95BCAC26@linuxant.com>
References: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
	<Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home>
	<20040501205336.GA27607@valve.mbsi.ca>
	<20040501173450.006bae55.seanlkml@rogers.com>
	<3F6634E3-9BB9-11D8-B83D-000A95BCAC26@linuxant.com>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at web01-imail.rogers.com from [24.103.219.176] using ID <seanlkml@rogers.com> at Sat, 1 May 2004 18:22:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004 17:48:14 -0400
Marc Boucher <marc@linuxant.com> wrote:

> Sean,
> 
> I think that your wording is problematic, because:
> 
> - A module with non-GPL license could be distributed in source form.
> - Its author can also be an individual or organization, not necessarily 
> a vendor.

Patch below attempts to address these concerns.

> - The word "tainted" is confusing and needlessly scary for average 
> users.
> 

Please stop your political agenda of subverting the open source nature of
Linux.   The average user SHOULD find it a scary to run modules
that don't conform to her choice of  OPEN SOURCE OPERATING SYSTEM.    
If the average user wanted to run closed source code she would have picked 
a closed source operating system right?  Lets not let closed source code sneak 
in without putting up big red flags for the user.   Lets make sure that the
USER IS NOT CONFUSED about the nature of the module they're loading.


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
+		printk(KERN_INFO "%s: module has non-GPL license (%s) kernel is now tainted.\n", mod->name, license);
+		printk(KERN_INFO "%s: Please consider supporting those who provide GPL licensed drivers\n", mod->name);
+		if(author)
+			printk(KERN_INFO "%s: tainted kernel means all support must come from: %s\n", mod->name, author);
+		else
+			printk(KERN_INFO "%s: tainted kernel means all support must come from driver author\n", mod->name);
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

