Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWD2SNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWD2SNg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 14:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWD2SNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 14:13:36 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:34237 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750774AbWD2SNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 14:13:35 -0400
Date: Sat, 29 Apr 2006 14:07:49 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.17-rc3] i386: fix broken FP exception handling
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-stable <stable@kernel.org>
Message-ID: <200604291409_MC3-1-BE50-16AD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The FXSAVE information leak patch introduced a bug in FP exception
handling: it clears FP exceptions only when there are already
none outstanding.  Mikael Pettersson reported that causes problems
with the Erlang runtime and has tested this fix.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Acked-by: Mikael Pettersson <mikpe@it.uu.se>

---

The same bug is in 2.6.16.9+ and this patch applies there as well.


--- 2.6.17-rc3-d4.orig/include/asm-i386/i387.h
+++ 2.6.17-rc3-d4/include/asm-i386/i387.h
@@ -58,13 +58,13 @@ static inline void __save_init_fpu( stru
 	alternative_input(
 		"fnsave %[fx] ;fwait;" GENERIC_NOP8 GENERIC_NOP4,
 		"fxsave %[fx]\n"
-		"bt $7,%[fsw] ; jc 1f ; fnclex\n1:",
+		"bt $7,%[fsw] ; jnc 1f ; fnclex\n1:",
 		X86_FEATURE_FXSR,
 		[fx] "m" (tsk->thread.i387.fxsave),
 		[fsw] "m" (tsk->thread.i387.fxsave.swd) : "memory");
 	/* AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception
 	   is pending.  Clear the x87 state here by setting it to fixed
-   	   values. __per_cpu_offset[0] is a random variable that should be in L1 */
+   	   values. safe_address is a random variable that should be in L1 */
 	alternative_input(
 		GENERIC_NOP8 GENERIC_NOP2,
 		"emms\n\t"	  	/* clear stack tags */
-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
