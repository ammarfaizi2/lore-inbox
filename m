Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933098AbWFZW1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933098AbWFZW1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbWFZW1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:27:16 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:38973 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S933098AbWFZW1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:27:15 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: oom-killer problem
Date: Tue, 27 Jun 2006 00:28:15 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270028.16346.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-05.tornado.cablecom.ch 1378;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i got the same here. reason is a recent change that made modules always
shows as module.mod. it breaks modprobe and probably many scripts..besides
lsmod looking horrible.
stuff like this in modprobe.conf:
	install pcmcia_core /sbin/modprobe --ignore-install pcmcia_core; /sbin/modprobe pcmcia
makes modprobe fork/exec endlessly calling itself...until oom interrupts it...
reverting the attached patch fixes the problem...

rgds
-daniel


From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: Sat, 24 Jun 2006 20:50:18 +0000 (+0200)
Subject: kbuild: fix make -rR breakage
X-Git-Url: http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=e5c44fd88c146755da6941d047de4d97651404a9

kbuild: fix make -rR breakage

make failed to supply the filename when using make -rR and using $(*F)
to get target filename without extension.
This bug was not reproduceable in small scale but using:
$(basename $(notdir $@)) fixes it with same functionality.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -13,6 +13,11 @@ space   := $(empty) $(empty)
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
 ###
+# basetarget equals the filename of the target with no extension.
+# So 'foo/bar.o' becomes 'bar'
+basetarget = $(basename $(notdir $@))
+
+###
 # Escape single quote for use in echo statements
 escsq = $(subst $(squote),'\$(squote)',$1)
 
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -117,7 +117,7 @@ $(real-objs-m:.o=.lst): quiet_modtag := 
 $(obj-m)              : quiet_modtag := [M]
 
 # Default for not multi-part modules
-modname = $(*F)
+modname = $(basetarget)
 
 $(multi-objs-m)         : modname = $(modname-multi)
 $(multi-objs-m:.o=.i)   : modname = $(modname-multi)
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -80,8 +80,10 @@ obj-dirs += $(host-objdirs)
 #####
 # Handle options to gcc. Support building with separate output directory
 
-_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   $(HOSTCFLAGS_$(*F).o)
-_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) $(HOSTCXXFLAGS_$(*F).o)
+_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
+                 $(HOSTCFLAGS_$(basetarget).o)
+_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
+                 $(HOSTCXXFLAGS_$(basetarget).o)
 
 ifeq ($(KBUILD_SRC),)
 __hostc_flags	= $(_hostc_flags)
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -82,12 +82,12 @@ obj-dirs	:= $(addprefix $(obj)/,$(obj-di
 #       than one module. In that case KBUILD_MODNAME will be set to foo_bar,
 #       where foo and bar are the name of the modules.
 name-fix = $(subst $(comma),_,$(subst -,_,$1))
-basename_flags = -D"KBUILD_BASENAME=KBUILD_STR($(call name-fix,$(*F)))"
+basename_flags = -D"KBUILD_BASENAME=KBUILD_STR($(call name-fix,$(basetarget)))"
 modname_flags  = $(if $(filter 1,$(words $(modname))),\
                  -D"KBUILD_MODNAME=KBUILD_STR($(call name-fix,$(modname)))")
 
-_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
-_a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(basetarget).o)
+_a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
 _cpp_flags     = $(CPPFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS_$(@F))
 
 # If building the kernel in a separate objtree expand all occurrences
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -72,7 +72,7 @@ $(modules:.ko=.mod.c): __modpost ;
 # Step 5), compile all *.mod.c files
 
 # modname is set to make c_flags define KBUILD_MODNAME
-modname = $(*F)
+modname = $(basetarget)
 
 quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
