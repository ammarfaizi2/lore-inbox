Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281169AbRKTRI5>; Tue, 20 Nov 2001 12:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281170AbRKTRIr>; Tue, 20 Nov 2001 12:08:47 -0500
Received: from t2.redhat.com ([199.183.24.243]:26357 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S281169AbRKTRIf>;
	Tue, 20 Nov 2001 12:08:35 -0500
Date: Tue, 20 Nov 2001 09:08:18 -0800
From: Richard Henderson <rth@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: [alpha] cleanup opDEC workaround
Message-ID: <20011120090818.A16366@redhat.com>
In-Reply-To: <20011119232355.C16091@redhat.com> <20011120133150.A9033@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120133150.A9033@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, Nov 20, 2001 at 01:31:50PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 01:31:50PM +0300, Ivan Kokshaysky wrote:
> On Mon, Nov 19, 2001 at 11:23:55PM -0800, Richard Henderson wrote:
> > --- 2.4.15-7/arch/alpha/kernel/traps.c.~2~	Mon Nov 19 23:05:50 2001
> > +++ 2.4.15-7/arch/alpha/kernel/traps.c	Mon Nov 19 23:07:32 2001
> 
> It seems to be the wrong diff:

Oh, it depended on this one.


r~


--- 2.4.15-7/arch/alpha/kernel/traps.c.~1~	Mon Nov 19 23:03:26 2001
+++ 2.4.15-7/arch/alpha/kernel/traps.c	Mon Nov 19 23:05:50 2001
@@ -20,6 +20,7 @@
 #include <asm/unaligned.h>
 #include <asm/sysinfo.h>
 #include <asm/hwrpb.h>
+#include <asm/mmu_context.h>
 
 #include "proto.h"
 
@@ -311,8 +312,22 @@ do_entIF(unsigned long type, unsigned lo
 			if (alpha_fp_emul(regs.pc-4))
 				return;
 		}
-		/* fallthrough as illegal instruction .. */
+		break;
+
 	      case 3: /* FEN fault */
+		/* Irritating users can call PAL_clrfen to disable the
+		   FPU for the process.  The kernel will then trap in
+		   do_switch_stack and undo_switch_stack when we try
+		   to save and restore the FP registers.
+
+		   Given that GCC by default generates code that uses the
+		   FP registers, PAL_clrfen is not useful except for DoS
+		   attacks.  So turn the bleeding FPU back on and be done
+		   with it.  */
+		current->thread.pal_flags |= 1;
+		__reload_thread(&current->thread);
+		return;
+
 	      case 5: /* illoc */
 	      default: /* unexpected instruction-fault type */
 		      ;
