Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312889AbSDOP44>; Mon, 15 Apr 2002 11:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312891AbSDOP4z>; Mon, 15 Apr 2002 11:56:55 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:48536 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S312889AbSDOP4y>; Mon, 15 Apr 2002 11:56:54 -0400
Date: Mon, 15 Apr 2002 10:56:47 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
cc: linux-kernel@vger.kernel.org
Subject: Re: error compiling 2.5.8
In-Reply-To: <20020415161601.31430a76.Corporal_Pisang@Counter-Strike.com.my>
Message-ID: <Pine.LNX.4.44.0204151054240.13828-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Corporal Pisang wrote:

> this error also occured in 2.5.8pre2, 2.5.8pre3, and now 2.5.8final.

> init/main.o(.text.init+0x675): undefined reference to `setup_per_cpu_areas'

Some patches I needed to get 2.5.8 to compile are appended. They'll fix 
the issue above.

--Kai


Pull from http://linux-isdn.bkbits.net/linux-2.5.misc

(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.457, 2002-04-14 20:29:44-05:00, kai@tp1.ruhr-uni-bochum.de
  Fix setup_per_pcu_areas() for UP compile
  
  For !CONFIG_SMP we want the empty inline setup_per_cpu_areas().
  If CONFIG_SMP is set, we never want the empty inline. If we use the
  generic implementation, we have it here, if not the arch has it somwhere
  else (hopefully).
  

 ----------------------------------------------------------------------------
 main.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.458, 2002-04-14 20:31:09-05:00, kai@tp1.ruhr-uni-bochum.de
  Avoid a compile-time warning in bluesmoke.c
  
  (intel_thermal_interrupt() defined but not used)

 ----------------------------------------------------------------------------
 bluesmoke.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.459, 2002-04-14 20:31:37-05:00, kai@tp1.ruhr-uni-bochum.de
  Fix neofb.c to use strsep.

 ----------------------------------------------------------------------------
 neofb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)





=============================================================================
unified diffs follow for reference
=============================================================================

-----------------------------------------------------------------------------
ChangeSet@1.457, 2002-04-14 20:29:44-05:00, kai@tp1.ruhr-uni-bochum.de
  Fix setup_per_pcu_areas() for UP compile
  
  For !CONFIG_SMP we want the empty inline setup_per_cpu_areas().
  If CONFIG_SMP is set, we never want the empty inline. If we use the
  generic implementation, we have it here, if not the arch has it somwhere
  else (hopefully).
  

  ---------------------------------------------------------------------------

diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Mon Apr 15 10:55:50 2002
+++ b/init/main.c	Mon Apr 15 10:55:50 2002
@@ -271,6 +271,10 @@
 #define smp_init()	do { } while (0)
 #endif
 
+static inline void setup_per_cpu_areas(void)
+{
+}
+
 #else
 
 #ifdef __GENERIC_PER_CPU
@@ -294,10 +298,6 @@
 		__per_cpu_offset[i] = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, size);
 	}
-}
-#else
-static inline void setup_per_cpu_areas(void)
-{
 }
 #endif /* !__GENERIC_PER_CPU */
 

-----------------------------------------------------------------------------
ChangeSet@1.458, 2002-04-14 20:31:09-05:00, kai@tp1.ruhr-uni-bochum.de
  Avoid a compile-time warning in bluesmoke.c
  
  (intel_thermal_interrupt() defined but not used)

  ---------------------------------------------------------------------------

diff -Nru a/arch/i386/kernel/bluesmoke.c b/arch/i386/kernel/bluesmoke.c
--- a/arch/i386/kernel/bluesmoke.c	Mon Apr 15 10:55:51 2002
+++ b/arch/i386/kernel/bluesmoke.c	Mon Apr 15 10:55:51 2002
@@ -33,9 +33,9 @@
  *	P4/Xeon Thermal transition interrupt handler
  */
 
+#ifdef CONFIG_X86_LOCAL_APIC
 static void intel_thermal_interrupt(struct pt_regs *regs)
 {
-#ifdef CONFIG_X86_LOCAL_APIC
 	u32 l, h;
 	unsigned int cpu = smp_processor_id();
 
@@ -48,8 +48,8 @@
 	} else {
 		printk(KERN_INFO "CPU#%d: Temperature/speed normal\n", cpu);
 	}
-#endif
 }
+#endif
 
 static void unexpected_thermal_interrupt(struct pt_regs *regs)
 {	

-----------------------------------------------------------------------------
ChangeSet@1.459, 2002-04-14 20:31:37-05:00, kai@tp1.ruhr-uni-bochum.de
  Fix neofb.c to use strsep.

  ---------------------------------------------------------------------------

diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	Mon Apr 15 10:55:52 2002
+++ b/drivers/video/neofb.c	Mon Apr 15 10:55:52 2002
@@ -2365,7 +2365,7 @@
   if (!options || !*options)
     return 0;
 
-  for (this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,","))
+  while ((this_opt = strsep(&options,",")) != NULL)
     {
       if (!*this_opt) continue;
 


