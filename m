Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313289AbSDOVS7>; Mon, 15 Apr 2002 17:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313288AbSDOVS6>; Mon, 15 Apr 2002 17:18:58 -0400
Received: from zero.tech9.net ([209.61.188.187]:43025 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313268AbSDOVS5>;
	Mon, 15 Apr 2002 17:18:57 -0400
Subject: Re: Linux 2.5.7-dj4
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020414212115.A10316@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 Apr 2002 17:19:01 -0400
Message-Id: <1018905541.3331.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Sun, 2002-04-14 at 04:54, Keith Owens wrote:
> Even after removing all the code that will not compile at all, there
> are still a lot of warning messages in 2.5.8-pre3.  I offer this list
> in the hope that the maintainers will fix the code (I can dream, can't
> I?).  No need to copy me on replies, just fix the code.
> ...
> arch/i386/kernel/bluesmoke.c: In function `mce_timerfunc':
> arch/i386/kernel/bluesmoke.c:267: warning: passing arg 1 of `smp_call_function' from incompatible pointer type
> arch/i386/kernel/bluesmoke.c:267: warning: passing arg 2 of `smp_call_function' makes pointer from integer without a cast

The cause of these warnings is that mce_checkregs is prototyped as

	void mce_checkregs (unsigned int)

and smp_call_function wants

	void mce_checkregs (void *)

and also the second parameter to smp_call_function is a void* not an
int.  This patch converts mce_checkregs to the desired format and also
properly passes a pointer.  Not matching the prototypes is probably fine
(at least on i386) but the warning should be avoided.  I bet the
resulting machine code is similar if not the same, anyhow.

Patch is actually against my bluesmoke.c, but that should match what you
have in 2.5.7-dj4 pretty much.  Please, apply.

	Robert Love

diff -urN linux-2.5.7-dj4/arch/i386/kernel/bluesmoke.c linux/arch/i386/kernel/bluesmoke.c
--- linux-2.5.7-dj4/arch/i386/kernel/bluesmoke.c	Mon Apr 15 16:59:20 2002
+++ linux/arch/i386/kernel/bluesmoke.c	Mon Apr 15 16:57:54 2002
@@ -233,12 +233,13 @@
 
 #define MCE_RATE	15*HZ	/* timer rate is 15s */
 
-static void mce_checkregs (unsigned int cpu)
+static void mce_checkregs (void *info)
 {
 	u32 low, high;
 	int i;
+	unsigned int *cpu = info;
 
-	BUG_ON(cpu!=smp_processor_id());
+	BUG_ON(*cpu != smp_processor_id());
 
 	for (i=0; i<banks; i++) {
 		rdmsr(MSR_IA32_MC0_STATUS+i*4, low, high);
@@ -262,13 +263,13 @@
 
 static void mce_timerfunc (unsigned long data)
 {
-	int i;
+	unsigned int i;
 
 	for (i=0; i<smp_num_cpus; i++) {
 		if (i == smp_processor_id())
-			mce_checkregs(i);
+			mce_checkregs(&i);
 		else
-			smp_call_function (mce_checkregs, i, 1, 1);
+			smp_call_function (mce_checkregs, &i, 1, 1);
 	}
 
 	/* Refresh the timer */

