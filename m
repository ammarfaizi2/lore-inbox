Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbRL3AVl>; Sat, 29 Dec 2001 19:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287286AbRL3AVc>; Sat, 29 Dec 2001 19:21:32 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:59306
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287289AbRL3AVY>; Sat, 29 Dec 2001 19:21:24 -0500
Date: Sat, 29 Dec 2001 17:21:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, Release 1.12 is available
Message-ID: <20011230002105.GF21928@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <19466.1009506702@ocs3.intra.ocs.com.au> <10706.1009614471@ocs3.intra.ocs.com.au> <20011229222706.GD21928@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011229222706.GD21928@cpe-24-221-152-185.az.sprintbbd.net>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 03:27:06PM -0700, Tom Rini wrote:
> On Sat, Dec 29, 2001 at 07:27:51PM +1100, Keith Owens wrote:
> > Content-Type: text/plain; charset=us-ascii
> > 
> > On Fri, 28 Dec 2001 13:31:42 +1100, 
> > Keith Owens <kaos@ocs.com.au> wrote:
> > >This announcement is for the base kbuild 2.5 code, i386 against 2.4.16.
> > >Patches for other architectures and kernels will be out later today, it
> > >takes time to generate and test patches for 6 architectures against 3
> > >different kernel trees.
> > 
> > All architecture and tree specific patches for kbuild 2.5 are now
> > available, if you don't see your arch then nobody has sent me a patch
> > yet.
> [snip]
> > kbuild-2.5-2.4.16-ppc-1		Add on for ppc by Tom Rini.
> 
> This seems to have been generated (or applied originally) w/ the wrong
> -p level (I suspect 'cuz of the wierd way I created the diff tho), since
> this creates ./ppc/.., instead of ./arch/ppc/...

And now more importantly, here's a patch to gets everything right.  This
is vs 2.4.16 + kbuild-2.5-2.4.16-3 + kbuild-2.5-2.4.16-ppc-1 (after
making it apply correctly).  I'll be sending along a 2.4.18-pre1 patch
later on (but vs a different base tree for now).  This fixes 3 things:
1) Add -Wa,-m405 to CONFIG_4xx AFLAGS
2) Either include <asm-offsets.h> or "ppc_defs.h".
3) Only have <asm-ppc/processor.h> include <asm/ptrace.h> if we're
!__ASSEMBLY__, since we were getting a warning.  I mean to spend a bit
more time poking around and seeing what/when we should/shouldn't be
defining STACK_FRAME_OVERHEAD, but for now this should do it.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/Makefile.defs.config 1.1 vs edited =====
--- 1.1/arch/ppc/Makefile.defs.config	Sat Dec 29 00:47:34 2001
+++ edited/arch/ppc/Makefile.defs.config	Sat Dec 29 16:36:17 2001
@@ -16,15 +16,16 @@
 # We can have any number of 'head.o' files, depending on CPU.
 # So we go ahead and set a default one and then modify it (and
 # CFLAGS) based on what processor we're on.
 arch_head = arch/ppc/kernel/head.o
 
 ifneq ($(subst n,,$(CONFIG_4xx)),)
   CFLAGS += -Wa,-m405
+  AFLAGS += -Wa,-m405
   arch_head := arch/ppc/kernel/head_4xx.o
 endif
 
 ifneq ($(subst n,,$(CONFIG_8xx)),)
   arch_head := arch/ppc/kernel/head_8xx.o
 endif
 
 ifneq ($(subst n,,$(CONFIG_PPC64BRIDGE)),)
===== arch/ppc/kernel/ppc_asm.h 1.19 vs edited =====
--- 1.19/arch/ppc/kernel/ppc_asm.h	Sun Nov  4 04:58:20 2001
+++ edited/arch/ppc/kernel/ppc_asm.h	Sat Dec 29 16:36:47 2001
@@ -17,7 +17,11 @@
 #include <linux/config.h>
 
 #include "ppc_asm.tmpl"
+#ifdef CONFIG_KBUILD_2_5
+#include <asm-offsets.h>
+#else
 #include "ppc_defs.h"
+#endif
 
 /*
  * Macros for storing registers into and loading registers from
===== include/asm-ppc/processor.h 1.32 vs edited =====
--- 1.32/include/asm-ppc/processor.h	Sun Oct  7 17:32:53 2001
+++ edited/include/asm-ppc/processor.h	Sat Dec 29 16:50:31 2001
@@ -13,7 +13,6 @@
 
 #include <linux/config.h>
 
-#include <asm/ptrace.h>
 #include <asm/types.h>
 #include <asm/mpc8xx.h>
 
@@ -536,6 +535,8 @@
 #define SR15	15
 
 #ifndef __ASSEMBLY__
+/* Avoid a warning when we're included with <asm-offsets.h> */
+#include <asm/ptrace.h>
 #if defined(CONFIG_ALL_PPC)
 extern int _machine;
 
