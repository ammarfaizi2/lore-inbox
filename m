Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWEFABD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWEFABD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 20:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWEFABD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 20:01:03 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:1481 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S1751079AbWEFABB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 20:01:01 -0400
Message-ID: <445BE729.80903@am.sony.com>
Date: Fri, 05 May 2006 17:00:41 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Arnd Bergmann <arnd@arndb.de>, cbe-oss-dev@ozlabs.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 04/13] cell: remove broken __setup_cpu_be function
References: <17498.60066.92373.6527@cargo.ozlabs.ibm.com>
In-Reply-To: <17498.60066.92373.6527@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> Arnd Bergmann writes:
> 
>>  From: Geoff Levand <geoffrey.levand@am.sony.com>
>> 
>> This patch removes the incorrect Cell processor setup routine
>> __setup_cpu_be.  This routine improperly accesses the hypervisor
>> page size configuration at SPR HID6.  The correct behavior is for
>> firmware, or if needed, platform setup code, to set the correct
>> page size.
> 
>> -		.cpu_setup		= __setup_cpu_be,
>> +		.cpu_setup		= __setup_cpu_power4,
> 
> That looks a bit dodgy.  Either just remove the contents of
> __setup_cpu_be (leaving only the blr), or define a __setup_cpu_null
> that does nothing, or make the identify_cpu not call the cpu setup
> function if the pointer is NULL.


OK, I set it up with __setup_cpu_null.  An updated patch follows.

It falls out from this that we can replace the do-nothing routines
__setup_cpu_power3 and __setup_cpu_power4 with __setup_cpu_null also.
I'll post a separate patch for consideration.

-Geoff


Replaced the Cell processor specific routine __setup_cpu_be with
a new generic routine __setup_cpu_null.  __setup_cpu_be improperly
accessed the hypervisor page size configuration at SPR HID6.  Correct
behavior is for firmware, or if needed, platform setup code, to set
the correct page size.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Index: cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/cpu_setup_power4.S	2006-04-26 19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S	2006-05-05 15:59:58.000000000 -0700
@@ -76,20 +76,6 @@
 _GLOBAL(__setup_cpu_power4)
 	blr

-_GLOBAL(__setup_cpu_be)
-        /* Set large page sizes LP=0: 16MB, LP=1: 64KB */
-        addi    r3, 0,  0
-        ori     r3, r3, HID6_LB
-        sldi    r3, r3, 32
-        nor     r3, r3, r3
-        mfspr   r4, SPRN_HID6
-        and     r4, r4, r3
-        addi    r3, 0, 0x02000
-        sldi    r3, r3, 32
-        or      r4, r4, r3
-        mtspr   SPRN_HID6, r4
-	blr
-
 _GLOBAL(__setup_cpu_ppc970)
 	mfspr	r0,SPRN_HID0
 	li	r11,5			/* clear DOZE and SLEEP */
Index: cell--alp--3/arch/powerpc/kernel/cputable.c
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/cputable.c	2006-04-26 19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/cputable.c	2006-05-05 16:29:06.000000000 -0700
@@ -31,9 +31,9 @@
  * and ppc64
  */
 #ifdef CONFIG_PPC64
+extern void __setup_cpu_null(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_power3(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_power4(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_be(unsigned long offset, struct cpu_spec* spec);
 #else
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
@@ -273,7 +273,7 @@
 			PPC_FEATURE_SMT,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.cpu_setup		= __setup_cpu_be,
+		.cpu_setup		= __setup_cpu_null,
 		.platform		= "ppc-cell-be",
 	},
 	{	/* default match */
Index: cell--alp--3/arch/powerpc/kernel/misc_64.S
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/misc_64.S	2006-04-26 19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/misc_64.S	2006-05-05 16:04:59.000000000 -0700
@@ -768,6 +768,9 @@

 #endif /* CONFIG_ALTIVEC */

+_GLOBAL(__setup_cpu_null)
+	blr
+
 _GLOBAL(__setup_cpu_power3)
 	blr

