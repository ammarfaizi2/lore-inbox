Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268020AbUHKKtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268020AbUHKKtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUHKKtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:49:25 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:59569 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268020AbUHKKtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:49:21 -0400
Date: Wed, 11 Aug 2004 11:47:35 +0100
From: Dave Jones <davej@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][trivial] line up 'ESR value before/after enabling vector' messages
Message-ID: <20040811104735.GA24149@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Jesper Juhl <juhl-lkml@dif.dk>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.61.0408110145030.2690@dragon.hygekrogen.localhost> <20040811062314.GA32700@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811062314.GA32700@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 08:23:14AM +0200, Ingo Molnar wrote:
 > 
 > * Jesper Juhl <juhl-lkml@dif.dk> wrote:
 > 
 > > -				" %08lx\n", value);
 > > +				"  %08lx\n", value);
 > 
 > > -		Dprintk("ESR value after enabling vector: %08x\n", value);
 > > +		Dprintk("ESR value after enabling vector:  %08x\n", value);
 > 
 > Signed-off-by: Ingo Molnar <mingo@elte.hu>

Has this printk actually been useful ? ever ?
I notice a majority of the time, it never changes too.
If it is useful, how about changing it so it prints something
if the value changed ?  (Something like patch below maybe?)
Or is possible for the APIC to lock up between the two printk's ?

		Dave


Only print out the ESR value if it changes after enabling vector.

Signed-off-by: Dave Jones <davej@redhat.com>

--- 1/arch/i386/kernel/apic.c~	2004-08-11 11:43:32.022485536 +0100
+++ 2/arch/i386/kernel/apic.c	2004-08-11 11:45:10.824465352 +0100
@@ -335,7 +335,7 @@
 
 void __init setup_local_APIC (void)
 {
-	unsigned long value, ver, maxlvt;
+	unsigned long oldvalue, value, ver, maxlvt;
 
 	/* Pound the ESR really hard over the head with a big hammer - mbligh */
 	if (esr_disable) {
@@ -449,9 +449,7 @@
 		maxlvt = get_maxlvt();
 		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP. */
 			apic_write(APIC_ESR, 0);
-		value = apic_read(APIC_ESR);
-		printk("ESR value before enabling vector: %08lx\n", value);
-
+		oldvalue = apic_read(APIC_ESR);
 		value = ERROR_APIC_VECTOR;      // enables sending errors
 		apic_write_around(APIC_LVTERR, value);
 		/*
@@ -460,7 +458,9 @@
 		if (maxlvt > 3)
 			apic_write(APIC_ESR, 0);
 		value = apic_read(APIC_ESR);
-		printk("ESR value after enabling vector: %08lx\n", value);
+		if (value != oldvalue)
+			printk("ESR value before enabling vector: %08lx  after: %08lx\n",
+							oldvalue, value);
 	} else {
 		if (esr_disable)	
 			/* 
