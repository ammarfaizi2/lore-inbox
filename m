Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUEBMns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUEBMns (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 08:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUEBMns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 08:43:48 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:18393
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263019AbUEBMnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 08:43:45 -0400
Date: Sun, 2 May 2004 08:43:45 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Marc Boucher <marc@linuxant.com>
Cc: torvalds@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       riel@redhat.com, tconnors+linuxkernel1083378452@astro.swin.edu.au,
       mbligh@aracnet.com, nico@cam.org
Subject: Re: [PATCH] clarify message and give support contact for non-GPL
 modules
Message-Id: <20040502084345.4b89d35f.seanlkml@rogers.com>
In-Reply-To: <5CDEE054-9BD4-11D8-B83D-000A95BCAC26@linuxant.com>
References: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
	<Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home>
	<20040501205336.GA27607@valve.mbsi.ca>
	<20040501173450.006bae55.seanlkml@rogers.com>
	<3F6634E3-9BB9-11D8-B83D-000A95BCAC26@linuxant.com>
	<Pine.LNX.4.58.0405011541330.18014@ppc970.osdl.org>
	<3114F1F7-9BC7-11D8-B83D-000A95BCAC26@linuxant.com>
	<Pine.LNX.4.58.0405011713110.18014@ppc970.osdl.org>
	<5CDEE054-9BD4-11D8-B83D-000A95BCAC26@linuxant.com>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.103.219.176] using ID <seanlkml@rogers.com> at Sun, 2 May 2004 08:42:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004 21:02:20 -0400
Marc Boucher <marc@linuxant.com> wrote:

> Understood. So perhaps we should call it "open" and "proprietary" which 
> are clear, well known words. "tainted" is honestly confusing/hard to 
> understand for many ordinary users, especially international/non-native 
> speakers who do not encounter the word that often (thankfully ;-).

No.  It's tainted.  And hopefully if the user is concerned or confused about this
word they will educate themself on the issues involved.    They might even
then support hardware companies that support open source development.
Nobody is forcing anything on them, and the module will still load and run.

Linux is an open source operating system.  There is nothing wrong with
promoting and protecting the code and license.

I've been looking at the latest version of the patch and thinking that it is really
wrong for any message to be displayed only once.   If the user is unfortunate 
enough to be loading two or more closed-source modules, the second
module should not be hidden by the first.   The author of the second module
should not have their name hidden just because another module was loaded
first.

So here is another attempt at the patch.   I think it addresses everything
that has been criticized.  It  makes sure the author of all non-GPL modules 
are shown and returns the message to be a warning instead of info:

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
+	if (!mod->license_gplok) {
+		printk(KERN_WARNING "%s: module has non-GPL license (%s) **KERNEL IS NOW TAINTED**.\n", mod->name, license);
+		printk(KERN_WARNING "%s: Please consider supporting those who provide GPL licensed drivers\n", mod->name);
+		if(author)
+			printk(KERN_WARNING "%s: Tainted kernel means support is only available from: %s\n", mod->name, author);
+		else
+			printk(KERN_WARNING "%s: Tainted kernel means support is only available from the author of this driver\n", mod->name);
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

