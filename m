Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTJCUyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 16:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTJCUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 16:54:39 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:23505 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261217AbTJCUyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 16:54:37 -0400
Date: Fri, 3 Oct 2003 21:54:08 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: backport AMD K7 MCE changes.
Message-ID: <20031003205408.GA17829@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're still accessing MCE bank 0 on Athlons in 2.4 when we shouldn't.
(We don't enable it, but we still check it in the exception handler)
This is fixed differently in 2.6, but is a minimal change
to reproduce the same effect.

		Dave

--- linux-2.4.22/arch/i386/kernel/bluesmoke.c~	2003-10-03 21:47:11.000000000 +0100
+++ linux-2.4.22/arch/i386/kernel/bluesmoke.c	2003-10-03 21:49:55.000000000 +0100
@@ -16,6 +16,7 @@
  */
 
 static int banks;
+static int startbank;
 
 static void intel_machine_check(struct pt_regs * regs, long error_code)
 {
@@ -30,7 +31,7 @@
 
 	printk(KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n", smp_processor_id(), mcgsth, mcgstl);
 	
-	for(i=0;i<banks;i++)
+	for(i=startbank;i<banks;i++)
 	{
 		rdmsr(MSR_IA32_MC0_STATUS+i*4,low, high);
 		if(high&(1<<31))
@@ -219,10 +220,13 @@
 	{
 		case X86_VENDOR_AMD:
 			/*
-			 *	AMD K7 machine check is Intel like
+			 *	AMD K7/K8 machine check is Intel like.
 			 */
-			if(c->x86 == 6 || c->x86 == 15)
+			
+			if(c->x86 == 6 || c->x86 == 15) {
+				startbank = 1;
 				intel_mcheck_init(c);
+			}
 			break;
 		case X86_VENDOR_INTEL:
 			intel_mcheck_init(c);

-- 
 Dave Jones     http://www.codemonkey.org.uk
