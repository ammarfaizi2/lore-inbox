Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTKIGXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 01:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTKIGWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 01:22:16 -0500
Received: from zeus.kernel.org ([204.152.189.113]:32708 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262190AbTKIGWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 01:22:01 -0500
Date: Sun, 2 Nov 2003 21:52:46 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] reproducible athlon mce fix
Message-ID: <20031102135246.GA1155@anakin.wychk.org>
References: <20031102055748.GA1218@anakin.wychk.org> <20031102125202.GA7992@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20031102125202.GA7992@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=big5
Content-Disposition: inline

On Sun, Nov 02, 2003 at 12:52:03PM +0000, Dave Jones wrote:
> On Sun, Nov 02, 2003 at 01:57:48PM +0800, Geoffrey Lee wrote:
> 
>  >  	preempt_disable(); 
>  > +#if CONFIG_MK7
>  > +	for (i=1; i<nr_mce_banks; i++) {
>  > +#else
>  >  	for (i=0; i<nr_mce_banks; i++) {
>  > +#endif
>  >  		rdmsr (MSR_IA32_MC0_STATUS+i*4, low, high);
> 
> This needs to be a runtime check. In 2.6, a K7 can boot
> a P4 kernel, and vice versa.
> 

Yes, of course.

Would it be sufficient to check for the boot_cpu_data.x86 == 6 and
boot_cpu_data.x86_vendor == X86_VENDOR_AMD?  This would seem to do
the right thing.  Updated patch attached.


	- g.

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=big5
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

--8t9RHnE3ZwKMSgU+--
