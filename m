Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266060AbSKFTZ6>; Wed, 6 Nov 2002 14:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266061AbSKFTZ6>; Wed, 6 Nov 2002 14:25:58 -0500
Received: from host194.steeleye.com ([66.206.164.34]:7180 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266060AbSKFTZz>; Wed, 6 Nov 2002 14:25:55 -0500
Message-Id: <200211061932.gA6JWKa03782@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, jejb@SteelEye.com,
       Andrew Morton <akpm@zip.com.au>, dipankar@in.ibm.com
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent 
 2.5)
In-Reply-To: Message from "Martin J. Bligh" <Martin.Bligh@us.ibm.com> 
   of "Wed, 06 Nov 2002 12:11:09 PST." <116630000.1036613469@flay> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 14:32:20 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin.Bligh@us.ibm.com said:
> Conversations on IRC revealed that jejb has hit the same thing on
> voyager ... as I understood him, he felt the cause was the CPU was
> taking an interrupt before cpu_up was called, and the interrupt was
> going back through a non existent tasklet structure (tasklets now
> have per_cpu areas which are allocated as the cpu comes up) I'll let
> him discuss what he did to fix that, but the ensuing discussion made
> me think that taking this out to a wider audience for an appropriate
> long-term solution would be prudent. 

Yes, this caused for me, a completely reliable boot time panic with 2.5.46.  
The problem is that per_cpu areas aren't initiallised until cpu_up is called, 
so a cpu cannot now take an interrupt before cpu_up is called.  My hack was 
this:

# --------------------------------------------
# 02/11/04	jejb@mulgrave.(none)	1.819
# [VOYAGER] CPU bring up changes for new per_cpu softirqs
# --------------------------------------------
#
diff -Nru a/arch/i386/mach-voyager/voyager_smp.c b/arch/i386/mach-voyager/voyag
er_smp.c
--- a/arch/i386/mach-voyager/voyager_smp.c	Wed Nov  6 14:27:11 2002
+++ b/arch/i386/mach-voyager/voyager_smp.c	Wed Nov  6 14:27:11 2002
@@ -507,6 +508,11 @@
 	/* if we're a quad, we may need to bootstrap other CPUs */
 	do_quad_bootstrap();
 
+	/* FIXME: this is rather a poor hack to prevent the CPU
+	 * activating softirqs while it's supposed to be waiting for
+	 * permission to proceed.  Without this, the new per CPU stuff
+	 * in the softirqs will fail */
+	local_irq_disable();
 	set_bit(cpuid, &cpu_callin_map);
 
 	/* signal that we're done */
@@ -514,6 +520,7 @@
 
 	while (!test_bit(cpuid, &smp_commenced_mask))
 		rep_nop();
+	local_irq_enable();
 
 	local_flush_tlb();
 
All it's really doing is disabling the interrupts before the booting secondary 
cpu waits on the smp_commenced_mask.

It's a hack because on voyager (and APIC) any interrupt will remain 
permanently pending at the CPU.  If the interrupt were vital to the boot 
sequence, we could be in trouble.  The correct way to fix this is probably to 
raise the CPUs external interrupt mask so any pending interrupt is pushed off 
onto the boot CPU.

James


