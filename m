Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262443AbSJDTBg>; Fri, 4 Oct 2002 15:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262445AbSJDTBf>; Fri, 4 Oct 2002 15:01:35 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:31496 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262443AbSJDTBd>;
	Fri, 4 Oct 2002 15:01:33 -0400
Date: Fri, 4 Oct 2002 21:07:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021004210701.A22726@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20021003223054.A31484@mars.ravnborg.org> <Pine.LNX.4.44.0210031536370.24570-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210031536370.24570-100000@chaos.physics.uiowa.edu>; from kai-germaschewski@uiowa.edu on Thu, Oct 03, 2002 at 03:38:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 03:38:22PM -0500, Kai Germaschewski wrote:
> You must be missing some of the changes (My first push to bkbits was 
> incomplete, since I did inadvertently edit Makefile without checking it 
> out, I do that mistake all the time...). It's fixed in the current repo.

Did a pull from bkbits at 18:30 CET, something like 09:30 pacific I think.

In general.
I like where you are heading, both the make -f, but also the cleanup done
in the top-level Makefile.
It makes it much easier to integrate my (ours) new make clean stuff -
but that shall wait until this is in the kernel.

Comments looking at the two new csets:
1)
In the descend macro you test for
ifeq ($(KBUILD_VERBOSE),1)
To make it consistent I suggest to use
ifneq ($(KBUILD_VERBOSE),0)
As done earlier in the Makefile

2) Needed the following to make my kernel compile (make mrproper defconfig all)
===== Rules.make 1.76 vs edited =====
--- 1.76/Rules.make	Thu Oct  3 04:51:25 2002
+++ edited/Rules.make	Fri Oct  4 20:38:37 2002
@@ -161,7 +161,7 @@
 # This sets version suffixes on exported symbols
 # ---------------------------------------------------------------------------
 
-MODVERDIR := include/linux/modules/$(obj)
+MODVERDIR := include/linux/modules
 
 #
 # Added the SMP separator to stop module accidents between uniprocessor
@@ -191,7 +191,7 @@
 # files (fix-dep filters them), so touch modversions.h if any of the .ver
 # files changes
 
-quiet_cmd_cc_ver_c = MKVER   include/linux/modules/$(obj)/$*.ver
+quiet_cmd_cc_ver_c = MKVER   include/linux/modules/$*.ver
 cmd_cc_ver_c = $(CPP) $(c_flags) $< | $(GENKSYMS) $(genksyms_smp_prefix) \
 		 -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp
 
Otherwise if failed first time it included modversions.h

3) This is just to make output nicer with KBUILD_VERBOSE=0
===== drivers/pci/Makefile 1.15 vs edited =====
--- 1.15/drivers/pci/Makefile	Wed Oct  2 21:54:34 2002
+++ edited/drivers/pci/Makefile	Fri Oct  4 20:59:55 2002
@@ -29,7 +29,9 @@
 obj-y += syscall.o
 endif
 
-host-progs := gen-devlist
+host-progs           := gen-devlist
+quiet_cmd_gendevlist  = DEVLIST $<
+cmd_gendevlist        = ( cd $(obj); ./gen-devlist ) < $<
 
 include $(TOPDIR)/Rules.make
 
@@ -40,6 +42,6 @@
 # And that's how to generate them
 
 $(obj)/devlist.h: $(src)/pci.ids $(obj)/gen-devlist
-	( cd $(obj); ./gen-devlist ) < $<
+	$(call cmd,gendevlist)
 
 $(obj)/classlist.h: $(obj)/devlist.h


And the same for zorro:
===== drivers/zorro/Makefile 1.6 vs edited =====
--- 1.6/drivers/zorro/Makefile	Wed Oct  2 21:54:34 2002
+++ edited/drivers/zorro/Makefile	Fri Oct  4 21:05:54 2002
@@ -7,7 +7,9 @@
 obj-$(CONFIG_ZORRO)	+= zorro.o names.o
 obj-$(CONFIG_PROC_FS)	+= proc.o
 
-host-progs 		:= gen-devlist
+host-progs 	    := gen-devlist
+quiet_cmd_gendevlist = DEVLIST $<
+cmd_gendevlist       = ( cd $(obj); ./gen-devlist ) < $<
 
 include $(TOPDIR)/Rules.make
 
@@ -18,4 +20,4 @@
 # And that's how to generate them
 
 $(obj)/devlist.h: $(src)/zorro.ids $(obj)/gen-devlist
-	( cd $(obj); ./gen-devlist ) < $<
+	$(call cmd,gendevlist)
