Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUGSRhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUGSRhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 13:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUGSRgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 13:36:37 -0400
Received: from mail.convergence.de ([212.84.236.4]:23245 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265314AbUGSRgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 13:36:16 -0400
Date: Mon, 19 Jul 2004 19:36:10 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-kernel@vger.kernel.org, Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] modpost warnings with external modules w/o modversions
Message-ID: <20040719173610.GB1987@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@germaschewski.name>,
	Sam Ravnborg <sam@ravnborg.org>, Pavel Roskin <proski@gnu.org>
References: <20040719125106.GA29131@convergence.de> <20040719145911.GA7007@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719145911.GA7007@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 04:59:11PM +0200, sam@ravnborg.org wrote:
> On Mon, Jul 19, 2004 at 02:51:06PM +0200, Johannes Stezenbach wrote:
> > Hi,
> > 
> > when building external modules (DVB drivers in this case)
> > for a kernel without CONFIG_MODVERSIONS I get a number of:
> > 
> > make[1]: Entering directory `/usr/src/linux-2.6.8-rc1'
> >   Building modules, stage 2.
> >   MODPOST
> > *** Warning: "dvb_unregister_frontend_new" [.../dvb-kernel/build-2.6/ves1x93.ko] has no CRC!
> > 
> > 
> > I believe that there is a small bug in modpost.c which the
> > patch below attempts to fix.
> 
> Pavel Roskin posted a better patch for the same problem.
> I just have not come around to it yet.
> 
> Here is an (outdated maybe) copy of the patch.

OK, that worked (patch applied with 1 line offset, I include a
refreshed patch for 2.6.8-rc1 below).

I also tested with CONFIG_MODVERSIONS (I never used that before),
and that seems to work, too.


Thanks,
Johannes


--- linux-2.6.8-rc1/scripts/Makefile.modpost.orig	2004-07-19 17:38:25.000000000 +0200
+++ linux-2.6.8-rc1/scripts/Makefile.modpost	2004-07-19 17:38:28.000000000 +0200
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
--- linux-2.6.8-rc1/scripts/modpost.c.orig	2004-07-16 19:22:24.000000000 +0200
+++ linux-2.6.8-rc1/scripts/modpost.c	2004-07-19 17:38:28.000000000 +0200
@@ -343,7 +343,6 @@ handle_modversions(struct module *mod, s
 			crc = (unsigned int) sym->st_value;
 			add_exported_symbol(symname + strlen(CRC_PFX),
 					    mod, &crc);
-			modversions = 1;
 		}
 		break;
 	case SHN_UNDEF:
@@ -649,7 +648,6 @@ read_dump(const char *fname)
 
 		if (!(mod = find_module(modname))) {
 			if (is_vmlinux(modname)) {
-				modversions = 1;
 				have_vmlinux = 1;
 			}
 			mod = new_module(NOFAIL(strdup(modname)));
@@ -696,11 +694,14 @@ main(int argc, char **argv)
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
