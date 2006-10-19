Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946083AbWJSHu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946083AbWJSHu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946082AbWJSHu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:50:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38376 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946083AbWJSHuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:50:25 -0400
Subject: Re: make headers_install headers problem on sparc64
From: David Woodhouse <dwmw2@infradead.org>
To: andrew@walrond.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <20061018223713.GD9350@pelagius.h-e-r-e-s-y.com>
References: <20061018223713.GD9350@pelagius.h-e-r-e-s-y.com>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 08:50:22 +0100
Message-Id: <1161244222.3376.470.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 22:37 +0000, andrew@walrond.org wrote:
> Hi david, lkml.
> 
> I found a message where you said
> 
> "If you have problems with the exported headers (other
> than that some userspace abuses headers which it shouldn't), then
> _shout_. Please don't just let them go unreported."

Thank you.

> So,
> 
> Using headers exported from vanilla linux 2.6.18.1 and compiling the
> elftoaout part of the debian sparc-utils package, I get some breakage
> here:
> 
> In file included from /usr/include/asm/elf.h:5,
>                  from /usr/include/linux/elf.h:7,
>                  from elftoaout.c:24:
> 
> due to tlb_type, cheetah et al being undefined in this part of
> asm-sparc64/elf.h:
> 
> 

Hm, yes. There's still a lot of crap being exposed there that we really
don't need to be showing. Try this entirely untested patch...

The sparc64 version could do with something similar, too.


 ----
[SPARC] Clean up asm-sparc/elf.h pollution in userspace.

We don't need to export sparc_elf_hwcap() to userspace, and it doesn't
build there. Remove it by moving it inside #ifdef __KERNEL__, along with
some other things which don't need to be exported.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-sparc/elf.h b/include/asm-sparc/elf.h
index 83a3dd1..aaf6ef4 100644
--- a/include/asm-sparc/elf.h
+++ b/include/asm-sparc/elf.h
@@ -8,11 +8,6 @@ #define __ASMSPARC_ELF_H
 
 #include <asm/ptrace.h>
 
-#ifdef __KERNEL__
-#include <asm/mbus.h>
-#include <asm/uaccess.h>
-#endif
-
 /*
  * Sparc section types
  */
@@ -77,6 +72,23 @@ typedef unsigned long elf_greg_t;
 #define ELF_NGREG 38
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
+typedef struct {
+	union {
+		unsigned long	pr_regs[32];
+		double		pr_dregs[16];
+	} pr_fr;
+	unsigned long __unused;
+	unsigned long	pr_fsr;
+	unsigned char	pr_qcnt;
+	unsigned char	pr_q_entrysize;
+	unsigned char	pr_en;
+	unsigned int	pr_q[64];
+} elf_fpregset_t;
+
+#ifdef __KERNEL__
+#include <asm/mbus.h>
+#include <asm/uaccess.h>
+
 /* Format is:
  * 	G0 --> G7
  *	O0 --> O7
@@ -99,20 +111,7 @@ do {	unsigned long *dest = &(__elf_regs[
 	dest[34] = src->npc;				\
 	dest[35] = src->y;				\
 	dest[36] = dest[37] = 0; /* XXX */		\
-} while(0); /* Janitors: Don't touch this colon. */
-
-typedef struct {
-	union {
-		unsigned long	pr_regs[32];
-		double		pr_dregs[16];
-	} pr_fr;
-	unsigned long __unused;
-	unsigned long	pr_fsr;
-	unsigned char	pr_qcnt;
-	unsigned char	pr_q_entrysize;
-	unsigned char	pr_en;
-	unsigned int	pr_q[64];
-} elf_fpregset_t;
+} while(0); /* Janitors: Don't touch this semicolon. */
 
 #define ELF_CORE_COPY_TASK_REGS(__tsk, __elf_regs)	\
 	({ ELF_CORE_COPY_REGS((*(__elf_regs)), (__tsk)->thread.kregs); 1; })
@@ -165,8 +164,8 @@ #define ELF_HWCAP	((ARCH_SUN4C_SUN4) ? 0
 
 #define ELF_PLATFORM	(NULL)
 
-#ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
+
+#endif /* __KERNEL__ */
 
 #endif /* !(__ASMSPARC_ELF_H) */


-- 
dwmw2

