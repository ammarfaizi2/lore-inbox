Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWGHIr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWGHIr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 04:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWGHIr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 04:47:29 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:41862 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751273AbWGHIr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 04:47:28 -0400
Date: Sat, 8 Jul 2006 10:47:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] Use target filename in BUG_ON and friends
Message-ID: <20060708084713.GA8020@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel using make O=.. all uses of __FILE__ becomes
filenames with absolute path resulting in increased text size.
Following patch supply the target filename as a commandline define
KBUILD_TARGET_FILE="mmslab.o"

With this doing a defconfig build I saw follow size reduction of
vmlinux (for x86_64):

-rc1:
   text	   data	    bss	    dec	    hex	filename
4727595	1174844	 605224	6507663	 634c8f	vmlinux

With patch applied:
   text	   data	    bss	    dec	    hex	filename
4733637	1174844	 605224	6513705	 636429	vmlinux.with-full-filenames

So a net saving of 6042 bytes. Corresponding to BUG or WARN being used
215 times with this configuration. (My path is 28 bytes up to the kernel
src dir).
With this config before applying the patch I have 344 strings in vmlinux
that starts with /home/sam/... so there is 129 more uses of __FILE__ 
that is not addressed by this patch.

The drawback of this patch is that the provided filename is no longer the
file that used the macro but the target filename. So it would be
"mm/slab.o" and not as before "mm/slab.c" that is identified. I played
no tricks to find the extension since identifying the .o file give a
hint that this may be in another file than just the corresponding .c
file (think included .c file, usage in other .h files etc).

If gcc could be teached not to use full path for __FILE__ this would be
an even better fix, but with current make O=.. support I have not found a
way to do so.

Patch below only modify x86_64, but if this is accepted all arch's bug.h
will be fixed.

	Sam

diffstat:
 include/asm-generic/bug.h |    6 ++++--
 include/asm-x86_64/bug.h  |    2 +-
 scripts/Makefile.lib      |    5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)


diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 8ceab7b..7811afa 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -6,7 +6,8 @@ #include <linux/compiler.h>
 #ifdef CONFIG_BUG
 #ifndef HAVE_ARCH_BUG
 #define BUG() do { \
-	printk("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __FUNCTION__); \
+	printk("BUG: failure at %s:%d/%s()!\n", \
+	       KBUILD_TARGET_FILE, __LINE__, __FUNCTION__); \
 	panic("BUG!"); \
 } while (0)
 #endif
@@ -18,7 +19,8 @@ #endif
 #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) do { \
 	if (unlikely((condition)!=0)) { \
-		printk("BUG: warning at %s:%d/%s()\n", __FILE__, __LINE__, __FUNCTION__); \
+		printk("BUG: warning at %s:%d/%s()\n", \
+		       KBUILD_TARGET_FILE, __LINE__, __FUNCTION__); \
 		dump_stack(); \
 	} \
 } while (0)
diff --git a/include/asm-x86_64/bug.h b/include/asm-x86_64/bug.h
index 80ac1fe..355fac4 100644
--- a/include/asm-x86_64/bug.h
+++ b/include/asm-x86_64/bug.h
@@ -24,7 +24,7 @@ #define HAVE_ARCH_BUG
 #define BUG() 								\
 	asm volatile(							\
 	"ud2 ; pushq $%c1 ; ret $%c0" :: 				\
-		     "i"(__LINE__), "i" (__FILE__))
+		     "i"(__LINE__), "i" (KBUILD_TARGET_FILE))
 void out_of_line_bug(void);
 #else
 static inline void out_of_line_bug(void) { }
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index fc498fe..64753d0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -85,6 +85,7 @@ name-fix = $(subst $(comma),_,$(subst -,
 basename_flags = -D"KBUILD_BASENAME=KBUILD_STR($(call name-fix,$(basetarget)))"
 modname_flags  = $(if $(filter 1,$(words $(modname))),\
                  -D"KBUILD_MODNAME=KBUILD_STR($(call name-fix,$(modname)))")
+filename_flags = -D"KBUILD_TARGET_FILE=KBUILD_STR($(src)/$(notdir $@))"
 
 _c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(basetarget).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
@@ -109,8 +110,8 @@ __cpp_flags     =                       
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
-		 $(__c_flags) $(modkern_cflags) \
-		 -D"KBUILD_STR(s)=\#s" $(basename_flags) $(modname_flags)
+		 $(__c_flags) $(modkern_cflags) -D"KBUILD_STR(s)=\#s" \
+		 $(basename_flags) $(modname_flags) $(filename_flags)
 
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__a_flags) $(modkern_aflags)
