Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUAROYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 09:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUAROYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 09:24:23 -0500
Received: from [202.181.197.10] ([202.181.197.10]:34052 "EHLO
	gandalf.gnupilgrims.org") by vger.kernel.org with ESMTP
	id S261681AbUAROYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 09:24:21 -0500
Date: Sun, 18 Jan 2004 22:23:38 +0800
To: Pedro Larroy <piotr@member.fsf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1 MCE falseness?] Hardware reports non-fatal error
Message-ID: <20040118142338.GA11517@gandalf.chinesecodefoo.org>
References: <200401181430.48997.piotr@member.fsf.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <200401181430.48997.piotr@member.fsf.org>
User-Agent: Mutt/1.3.28i
From: glee@gnupilgrims.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 18, 2004 at 02:30:48PM +0100, Pedro Larroy wrote:
> I also have been getting apparently false MCEs since 2.5.xx 
> I even had kernel panics in early 2.5 with MCE enabled. Now in 2.6.0-xx
> and in 2.6.1 I just get them from time to time but none fatal.
> most of the time in CPU 0
> 


I get them too, so I applied this patch.


	- g.


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mce-fix.patch"

--- linux-2.6.0-test9/arch/i386/kernel/cpu/mcheck/non-fatal.c.orig	2003-11-02 13:31:43.000000000 +0800
+++ linux-2.6.0-test9/arch/i386/kernel/cpu/mcheck/non-fatal.c	2003-11-02 21:50:36.000000000 +0800
@@ -21,6 +21,7 @@
 
 static struct timer_list mce_timer;
 static int timerset;
+static int startbank;
 
 #define MCE_RATE	15*HZ	/* timer rate is 15s */
 
@@ -30,7 +31,7 @@
 	int i;
 
 	preempt_disable(); 
-	for (i=0; i<nr_mce_banks; i++) {
+	for (i=startbank; i<nr_mce_banks; i++) {
 		rdmsr (MSR_IA32_MC0_STATUS+i*4, low, high);
 
 		if (high & (1<<31)) {
@@ -68,6 +69,19 @@
 
 static int __init init_nonfatal_mce_checker(void)
 {
+	/*
+	   Certain Athlons would cause spurious MCE non-fatal
+	   exception check to be reported, if we poke at bank 0.
+	   Avoid this if the running machine is an Athlon.
+
+	   -- geoff.
+	*/
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD && 
+	    boot_cpu_data.x86 == 6)
+		startbank = 1;
+	else
+		startbank = 0;
+
 	if (timerset == 0) {
 		/* Set the timer to check for non-fatal
 		   errors every MCE_RATE seconds */

--0OAP2g/MAC+5xKAE--
