Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWDOIlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWDOIlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 04:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWDOIlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 04:41:23 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:15890 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751577AbWDOIlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 04:41:22 -0400
Date: Sat, 15 Apr 2006 10:40:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dustin Kirkland <dustin.kirkland@us.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kylene Jo Hall <kjhall@us.ibm.com>,
       kbuild-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make: add modules_update target
Message-ID: <20060415084058.GA29502@mars.ravnborg.org>
References: <1145027216.12054.164.camel@localhost.localdomain> <20060414170222.GA19172@thunk.org> <1145061219.4001.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145061219.4001.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 07:33:39PM -0500, Dustin Kirkland wrote:
> It looks like it may not be easy to drop in modules_update as a more
> efficient alternative to modules_install, but note that is not the patch
> that Kylie submitted...
The problem to be solved is the long time it takes to do
"make modules_install" when working on a single module.
Instead of bringing in more or less complex solutions what about
extending "make dir/module.ko" to include the installation of the
module.

Something like:
"make MI=1 dir/module.ko"
where MI=1 tells us to install the said module.

I'm not particular found of the syntax - anyone with a better proposal?

Untested sample patch below.

	Sam

diff --git a/Makefile b/Makefile
index fc8e08c..0c0649c 100644
--- a/Makefile
+++ b/Makefile
@@ -1312,6 +1312,11 @@ # Modules
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
 	$(build)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
+ifneq ($(MI),)
+	cp $@ $(MODLIB)/kernel/$(dir $@)
+	if [ -r System.map -a -x $(DEPMOD) ]; then \
+            $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
+endif
 
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
