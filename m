Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbSKSGVf>; Tue, 19 Nov 2002 01:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbSKSGVf>; Tue, 19 Nov 2002 01:21:35 -0500
Received: from dp.samba.org ([66.70.73.150]:21942 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267121AbSKSGVc>;
	Tue, 19 Nov 2002 01:21:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues 
In-reply-to: Your message of "Mon, 18 Nov 2002 10:46:10 MDT."
             <Pine.LNX.4.44.0211181040490.24137-100000@chaos.physics.uiowa.edu> 
Date: Tue, 19 Nov 2002 17:26:47 +1100
Message-Id: <20021119062835.E09A52C05A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211181040490.24137-100000@chaos.physics.uiowa.edu> y
ou write:
> On Fri, 15 Nov 2002, Richard Henderson wrote:
> 
> > [...]
> > 
> > 	ld -T z.ld -shared -o z.so z.o
> 
> BTW, this reminds me of something various people and me have been thinking
> about for some time, i.e. postprocessing the .o files to generate the 
> actual module object.

See below, I made it go via ".raw.o" (this code is from the module
alias / device tables patch).  Renaming the .o files to ".mod" or
".kso" is probably cleaner and clearer.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5-bk-devicetable-base/scripts/Makefile.build working-2.5-bk-devicetable/scripts/Makefile.build
--- working-2.5-bk-devicetable-base/scripts/Makefile.build	2002-11-13 18:54:56.000000000 +1100
+++ working-2.5-bk-devicetable/scripts/Makefile.build	2002-11-14 03:41:30.000000000 +1100
@@ -91,7 +91,8 @@ cmd_cc_i_c       = $(CPP) $(c_flags)   -
 quiet_cmd_cc_o_c = CC      $@
 cmd_cc_o_c       = $(CC) $(c_flags) -c -o $@ $<
 
-%.o: %.c FORCE
+# Not for modules
+$(sort $(objs-y) $(multi-objs)) %.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
 quiet_cmd_cc_lst_c = MKLST   $@
@@ -100,6 +101,16 @@ cmd_cc_lst_c       = $(CC) $(c_flags) -g
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
 
+# Modules need to go via "finishing" step.
+quiet_cmd_modfinish = FINISH   $@
+cmd_modfinish       = sh scripts/modfinish $< $@
+
+$(patsubst %.o,%.raw.o,$(filter-out $(multi-used-m),$(obj-m))): %.raw.o: %.c
+	$(call if_changed_dep,cc_o_c)
+
+$(obj-m): %.o: %.raw.o
+	$(call cmd,modfinish)
+
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
 
@@ -161,7 +172,7 @@ targets += $(L_TARGET)
 endif
 
 #
-# Rule to link composite objects
+# Rule to link composite objects (builtin)
 #
 
 quiet_cmd_link_multi = LD      $@
@@ -174,8 +185,16 @@ cmd_link_multi = $(LD) $(LDFLAGS) $(EXTR
 $(multi-used-y) : %.o: $(multi-objs-y) FORCE
 	$(call if_changed,link_multi)
 
-$(multi-used-m) : %.o: $(multi-objs-m) FORCE
-	$(call if_changed,link_multi)
+#
+# Rule to link composite objects (module)
+#
+
+quiet_cmd_link_mmulti = LD      $@
+cmd_link_mmulti = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.raw.o=-objs))) $($(subst $(obj)/,,$(@:.raw.o=-y)))),$^)
+
+# Need finishing step
+$(multi-used-m:.o=.raw.o) : %.raw.o: $(multi-objs-m) FORCE
+	$(call if_changed,link_mmulti)
 
 targets += $(multi-used-y) $(multi-used-m)
 
