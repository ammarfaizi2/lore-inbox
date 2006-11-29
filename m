Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758771AbWK2Eam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758771AbWK2Eam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758775AbWK2Eam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:30:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1992 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1758771AbWK2Eal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:30:41 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: David Miller <davem@davemloft.net>
cc: nmiell@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away 
In-reply-to: Your message of "Tue, 28 Nov 2006 20:04:53 -0800."
             <20061128.200453.104036587.davem@davemloft.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Nov 2006 15:30:27 +1100
Message-ID: <23328.1164774627@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller (on Tue, 28 Nov 2006 20:04:53 -0800 (PST)) wrote:
>From: Keith Owens <kaos@ocs.com.au>
>Date: Wed, 29 Nov 2006 14:56:20 +1100
>
>> Secondly, I believe that this is a separate problem from bug 22278.
>> hpet_readl() is correctly using volatile internally, but its result is
>> being assigned to a pair of normal integers (not declared as volatile).
>> In the context of wait_hpet_tick, all the variables are unqualified so
>> gcc is allowed to optimize the comparison away.
>> 
>> The same problem may exist in other parts of arch/i386/kernel/time_hpet.c,
>> where the return value from hpet_readl() is assigned to a normal
>> variable.  Nothing in the C standard says that those unqualified
>> variables should be magically treated as volatile, just because the
>> original code that extracted the value used volatile.  IOW, time_hpet.c
>> needs to declare any variables that hold the result of hpet_readl() as
>> being volatile variables.
>
>I disagree with this.
>
>readl() returns values from an opaque source, and it is declared
>as such to show this to GCC.  It's like a function that GCC
>cannot see the implementation of, which it cannot determine
>anything about wrt. return values.
>
>The volatile'ness does not simply disappear the moment you
>assign the result to some local variable which is not volatile.
>
>Half of our drivers would break if this were true.

This is definitely a gcc bug, 4.1.0 is doing something weird.  Compile
with CONFIG_CC_OPTIMIZE_FOR_SIZE=n and the bug appears,
CONFIG_CC_OPTIMIZE_FOR_SIZE=y has no problem.

Compile with CONFIG_CC_OPTIMIZE_FOR_SIZE=n and _either_ of the patches
below and the problem disappears.

Index: linux/arch/i386/kernel/time_hpet.c
===================================================================
--- linux.orig/arch/i386/kernel/time_hpet.c	2006-11-29 13:51:33.900462088 +1100
+++ linux/arch/i386/kernel/time_hpet.c	2006-11-29 15:25:47.853245938 +1100
@@ -35,7 +35,8 @@ static void __iomem * hpet_virt_address;
 
 int hpet_readl(unsigned long a)
 {
-	return readl(hpet_virt_address + a);
+	volatile int v = readl(hpet_virt_address + a);
+	return v;
 }
 
 static void hpet_writel(unsigned long d, unsigned long a)


Index: linux-2.6/arch/i386/kernel/time_hpet.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/time_hpet.c
+++ linux-2.6/arch/i386/kernel/time_hpet.c
@@ -51,7 +51,7 @@ static void hpet_writel(unsigned long d,
  */
 static void __devinit wait_hpet_tick(void)
 {
-	unsigned int start_cmp_val, end_cmp_val;
+	unsigned volatile int start_cmp_val, end_cmp_val;
 
 	start_cmp_val = hpet_readl(HPET_T0_CMP);
 	do {

