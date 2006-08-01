Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751845AbWHATmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWHATmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWHATmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:42:24 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:41347 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751845AbWHATmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:42:24 -0400
Date: Tue, 1 Aug 2006 21:42:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, agruen@suse.de,
       Dave Jones <davej@redhat.com>
Subject: Re: Building external modules against objdirs
Message-ID: <20060801194216.GA15462@mars.ravnborg.org>
References: <200607301846.07797.ak@suse.de> <200607301949.41165.ak@suse.de> <20060730183159.GA30278@mars.ravnborg.org> <200607302037.02559.ak@suse.de> <20060730191700.GA30700@mars.ravnborg.org> <Pine.LNX.4.64.0607311135350.6762@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607311135350.6762@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 11:39:30AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sun, 30 Jul 2006, Sam Ravnborg wrote:
> 
> > On Sun, Jul 30, 2006 at 08:37:02PM +0200, Andi Kleen wrote:
> >  
> > > 
> > > The echo didn't output for some reason, but adding it to the error gives
> > > 
> > > /home/lsrc/quilt/linux/Makefile:456: *** triggered by /home/lsrc/quilt/linux/drivers/net/wireless/Kconfig /home/lsrc/quilt/linux/drivers/message/fusion/Kconfig /home/lsrc/quilt/linux/net/ieee80211/Kconfig /home/lsrc/quilt/linux/net/netfilter/Kconfig kernel configuration not valid - run 'make prepare' in /home/lsrc/quilt/linux to update it.  Stop.
> > 
> > What happens is that a few Kconfig files in your quilt tree are updated
> > after last time you reran 'make'.
> > And then kbuild say that config is invalid since it has not been updated
> > since last edit of Kconfig files.
> > 
> > Hmm...
> 
> What we could do is to call silentoldconfig and set 
> KCONFIG_NOSILENTUPDATE, if the .config is uptodate it will only update 
> autoconf and abort otherwise.
External modules shall to a great extent just rely on the avialble
kernel, and any attempt to do automatic updates are not OK.
The kernel source could be RO and no rights to write in the
directories either.
So it is preferable to bail out in case we cannot build the external
module but to avoid the consistency checks all over.
Following patch does this for the configuration part.

	Sam

diff --git a/Makefile b/Makefile
index 110db85..291bb5e 100644
--- a/Makefile
+++ b/Makefile
@@ -436,12 +436,13 @@ core-y		:= usr/
 endif # KBUILD_EXTMOD
 
 ifeq ($(dot-config),1)
-# In this section, we need .config
+# Read in config
+-include include/config/auto.conf
 
+ifeq ($(KBUILD_EXTMOD),)
 # Read in dependencies to all Kconfig* files, make sure to run
 # oldconfig if changes are detected.
 -include include/config/auto.conf.cmd
--include include/config/auto.conf
 
 # To avoid any implicit rule to kick in, define an empty command
 $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
@@ -451,16 +452,27 @@ # with it and forgot to run make oldconf
 # if auto.conf.cmd is missing then we are probably in a cleaned tree so
 # we execute the config step to be sure to catch updated Kconfig files
 include/config/auto.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
-ifeq ($(KBUILD_EXTMOD),)
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
-	$(error kernel configuration not valid - run 'make prepare' in $(srctree) to update it)
-endif
+# external modules needs include/linux/autoconf.h and include/config/auto.conf
+# but do not care if they are up-to-date. Use auto.conf to trigger the test
+PHONY += include/config/auto.conf
+
+include/config/auto.conf:
+	$(Q)test -e include/linux/autoconf.h -a -e $@ || (		\
+	echo;								\
+	echo "  ERROR: Kernel configuration is invalid.";		\
+	echo "         include/linux/autoconf.h or $@ is missing.";	\
+	echo "         Run 'make oldconfig && make prepare' on kernel src to fix it.";	\
+	echo;								\
+	/bin/false)
+
+endif # KBUILD_EXTMOD
 
 else
 # Dummy target needed, because used as prerequisite
 include/config/auto.conf: ;
-endif
+endif # $(dot-config)
 
 # The all: target is the default when no target is given on the
 # command line.
