Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUGSM7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUGSM7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 08:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGSM7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 08:59:13 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:15457 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265087AbUGSM6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 08:58:52 -0400
Date: Mon, 19 Jul 2004 16:59:11 +0200
From: sam@ravnborg.org
To: Johannes Stezenbach <js@convergence.de>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] modpost warnings with external modules w/o modversions
Message-ID: <20040719145911.GA7007@mars.ravnborg.org>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@germaschewski.name>,
	Sam Ravnborg <sam@ravnborg.org>, Pavel Roskin <proski@gnu.org>
References: <20040719125106.GA29131@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719125106.GA29131@convergence.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 02:51:06PM +0200, Johannes Stezenbach wrote:
> Hi,
> 
> when building external modules (DVB drivers in this case)
> for a kernel without CONFIG_MODVERSIONS I get a number of:
> 
> make[1]: Entering directory `/usr/src/linux-2.6.8-rc1'
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "dvb_unregister_frontend_new" [.../dvb-kernel/build-2.6/ves1x93.ko] has no CRC!
> 
> 
> I believe that there is a small bug in modpost.c which the
> patch below attempts to fix.

Pavel Roskin posted a better patch for the same problem.
I just have not come around to it yet.

Here is an (outdated maybe) copy of the patch.

	Sam

--- linux.orig/scripts/Makefile.modpost
+++ linux/scripts/Makefile.modpost
@@ -51,8 +51,8 @@
 #  Includes step 3,4
 quiet_cmd_modpost = MODPOST
       cmd_modpost = scripts/modpost \
-	$(if $(KBUILD_EXTMOD),-i,-o) $(symverfile) \
-	$(filter-out FORCE,$^)
+	$(if $(CONFIG_MODVERSIONS),-m) $(if $(KBUILD_EXTMOD),-i,-o) \
+	$(symverfile) $(filter-out FORCE,$^)
 
 .PHONY: __modpost
 __modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
--- linux.orig/scripts/modpost.c
+++ linux/scripts/modpost.c
@@ -342,7 +342,6 @@ handle_modversions(struct module *mod, s
 			crc = (unsigned int) sym->st_value;
 			add_exported_symbol(symname + strlen(CRC_PFX),
 					    mod, &crc);
-			modversions = 1;
 		}
 		break;
 	case SHN_UNDEF:
@@ -648,7 +647,6 @@ read_dump(const char *fname)
 
 		if (!(mod = find_module(modname))) {
 			if (is_vmlinux(modname)) {
-				modversions = 1;
 				have_vmlinux = 1;
 			}
 			mod = new_module(NOFAIL(strdup(modname)));
@@ -695,11 +693,14 @@ main(int argc, char **argv)
 	char *dump_read = NULL, *dump_write = NULL;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "i:o:")) != -1) {
+	while ((opt = getopt(argc, argv, "i:mo:")) != -1) {
 		switch(opt) {
 			case 'i':
 				dump_read = optarg;
 				break;
+			case 'm':
+				modversions = 1;
+				break;
 			case 'o':
 				dump_write = optarg;
 				break;

