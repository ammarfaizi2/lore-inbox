Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286172AbRLaCYH>; Sun, 30 Dec 2001 21:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286177AbRLaCX5>; Sun, 30 Dec 2001 21:23:57 -0500
Received: from sushi.toad.net ([162.33.130.105]:56524 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S286172AbRLaCXm>;
	Sun, 30 Dec 2001 21:23:42 -0500
Subject: Re: APM driver patch okay?
From: Thomas Hood <jdthood@mail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011231120236.27c0a8d5.sfr@canb.auug.org.au>
In-Reply-To: <XFMail.20011223131241.ast@domdv.de>
	<1009742756.9517.9.camel@thanatos> 
	<20011231120236.27c0a8d5.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 30 Dec 2001 21:23:44 -0500
Message-Id: <1009765430.9517.32.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-30 at 20:02, Stephen Rothwell wrote:
> OK, I have a slightly modified version of the patch that I created just
> before starting my Christmas break.  The only problem is that it crashes
> the kernel hard when I remove the apm module.

Erp.  Obviously that wasn't something I tested.

I was just looking at the code to make sure that when the
module is removed it can't leave the machine in the idle
state.  Unfortunately the apm_cpu_idle() function uses
several gotos, continues and breaks, and uses both "t1"
and "t2" for more than one purpose.  Here's a patch that
makes that function a bit easier to read.            // TH

--- linux-2.4.17/arch/i386/kernel/apm.c_1	Sun Dec 23 14:53:12 2001
+++ linux-2.4.17/arch/i386/kernel/apm.c	Sun Dec 30 21:19:29 2001
@@ -757,12 +757,10 @@
 #define HARD_IDLE_TIMEOUT (HZ/3)
 #define IDLE_CALC_LIMIT   (HZ*100)
 #define IDLE_LEAKY_MAX    16
 
 static void (*sys_idle)(void); /* = 0 */
-static unsigned int last_jiffies; /* = 0 */
-static unsigned int last_stime; /* = 0 */
 
 /**
  * apm_cpu_idle		-	cpu idling for APM capable Linux
  *
  * This is the idling function the kernel executes when APM is available. It 
@@ -770,57 +768,62 @@
  * Furthermore it calls the system default idle routine.
  */
 
 static void apm_cpu_idle(void)
 {
-	static int use_apm_idle = 0;
+	static int use_apm_idle; /* = 0 */
+	static unsigned int last_jiffies; /* = 0 */
+	static unsigned int last_stime; /* = 0 */
 	int apm_is_idle = 0;
-	unsigned int t1 = jiffies - last_jiffies;
-	unsigned int t2;
+	unsigned int delta_jiffies;
+	unsigned int leak;
 
-recalc:	if(t1 > IDLE_CALC_LIMIT)
+	delta_jiffies = jiffies - last_jiffies;
+
+recalc:	if(delta_jiffies > IDLE_CALC_LIMIT)
 		goto reset;
 
-	if(t1 > HARD_IDLE_TIMEOUT) {
-		t2 = current->times.tms_stime - last_stime;
-		t2 *= 100;
-		t2 /= t1;
-		if (t2 > idle_threshold)
+	if(delta_jiffies > HARD_IDLE_TIMEOUT) {
+		unsigned int t = current->times.tms_stime - last_stime;
+		t *= 100;
+		t /= delta_jiffies;
+		if (t > idle_threshold)
 			use_apm_idle = 1;
 		else
 reset:			use_apm_idle = 0;
 		last_jiffies = jiffies;
 		last_stime = current->times.tms_stime;
 	}
 
-	t2 = IDLE_LEAKY_MAX;
+	leak = IDLE_LEAKY_MAX;
 
 	while (!current->need_resched) {
 		if(use_apm_idle) {
-			t1 = jiffies;
+			unsigned int jiffies_before = jiffies;
 			switch (apm_do_idle()) {
 			case 0:	apm_is_idle = 1;
-				if (t1 != jiffies) {
-					if (t2) {
-						t2 = IDLE_LEAKY_MAX;
+				if (jiffies_before != jiffies) {
+					if (leak) {
+						leak = IDLE_LEAKY_MAX;
 						continue;
 					}
-				} else if (t2) {
-					t2--;
+				} else if (leak) {
+					leak--;
 					continue;
 				}
 				break;
 			case 1:	apm_is_idle = 1;
 				break;
+			/* case -1: did not idle */
 			}
 		}
 
 		if (sys_idle)
 			sys_idle();
 
-		t1 = jiffies - last_jiffies;
-		if (t1 > HARD_IDLE_TIMEOUT)
+		delta_jiffies = jiffies - last_jiffies;
+		if (delta_jiffies > HARD_IDLE_TIMEOUT)
 			goto recalc;
 	}
 
 	if (apm_is_idle)
 		apm_do_busy();

