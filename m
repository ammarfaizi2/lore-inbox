Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266014AbSKFSpz>; Wed, 6 Nov 2002 13:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266015AbSKFSpz>; Wed, 6 Nov 2002 13:45:55 -0500
Received: from pasky.ji.cz ([62.44.12.54]:33786 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S266014AbSKFSpx>;
	Wed, 6 Nov 2002 13:45:53 -0500
Date: Wed, 6 Nov 2002 19:52:30 +0100
From: Petr Baudis <pasky@ucw.cz>
To: mec@shout.net
Cc: zippel@linux-m68k.org, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021106185230.GD5219@pasky.ji.cz>
Mail-Followup-To: mec@shout.net, zippel@linux-m68k.org,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.46) introduces two special variables which make it
actually possible to have .so as the only product of build in some directory
and to link something against .so being built in another directory. The
variable host-cshlib-extra makes it possible to explicitly mention shared
objects to be built and the variable $(<foo>-linkobjs) allows user to specify
additional objects to link <foo> against, while not creating any dependencies
of <foo> on the objects.

  The changes are minimal while dramatically extending possibilities for
messing with the shared objects and they should have no unwanted side-effects,
and it appears to actually work for me. Please apply.

 scripts/Makefile.build |    6 ++++++
 scripts/Makefile.lib   |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

  Kind regards,
                                Petr Baudis

diff -ru linux/scripts/Makefile.build linux+pasky/scripts/Makefile.build
--- linux/scripts/Makefile.build	Tue Nov  5 19:29:20 2002
+++ linux+pasky/scripts/Makefile.build	Wed Nov  6 19:39:52 2002
@@ -197,6 +197,11 @@
 # libkconfig.so as the executable conf.
 # Note: Shared libraries consisting of C++ files are not supported  
 #
+# host-progs     := mconf
+# mconf-objs     := mconf.o
+# mconf-linkobjs := ../lxdialog/liblxdialog.so
+# Will link mconf.o against ../lxdialog/liblxdialog.so, but will not attempt
+# to build ../lxdialog/liblxdialog.so nor will make mconf depend on it.
 
 # Create executable from a single .c file
 # host-csingle -> Executable
@@ -212,6 +217,7 @@
 quiet_cmd_host-cmulti	= HOSTLD  $@
       cmd_host-cmulti	= $(HOSTCC) $(HOSTLDFLAGS) -o $@ \
 			  $(addprefix $(obj)/,$($(@F)-objs)) \
+			  $(addprefix $(obj)/,$($(@F)-linkobjs)) \
 			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-cmulti): %: $(host-cobjs) $(host-cshlib) FORCE
 	$(call if_changed,host-cmulti)
diff -ru linux/scripts/Makefile.lib linux+pasky/scripts/Makefile.lib
--- linux/scripts/Makefile.lib	Fri Nov  1 22:22:07 2002
+++ linux+pasky/scripts/Makefile.lib	Wed Nov  6 19:07:47 2002
@@ -78,7 +78,7 @@
 
 # Shared libaries (only .c supported)
 # Shared libraries (.so) - all .so files referenced in "xxx-objs"
-host-cshlib	:= $(sort $(filter %.so, $(host-cobjs)))
+host-cshlib	:= $(host-cshlib-extra) $(sort $(filter %.so, $(host-cobjs)))
 # Remove .so files from "xxx-objs"
 host-cobjs	:= $(filter-out %.so,$(host-cobjs))
 
