Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269202AbUIIAX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269202AbUIIAX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUIIAX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 20:23:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:37625 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269202AbUIIAXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 20:23:22 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions
To: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [PATCH][2.6.8.1-mm4]  phys_proc_id change for x86-64
Date: Wed, 8 Sep 2004 17:23:16 -0700
User-Agent: KMail/1.5.4
Cc: "Martin J. Bligh" <mbligh@aracnet.com>
References: <200409081647.46980.jamesclv@us.ibm.com>
In-Reply-To: <200409081647.46980.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0J6PB9vpAf1ZxkB"
Message-Id: <200409081723.16929.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0J6PB9vpAf1ZxkB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The value that cpuinfo returns for command 1 in ebx is the
physical APIC ID latched when the system comes out of reset.

Ordinarily, this is identical to the value in the local APIC's ID
register, because nearly all BIOSes accept the HW assigned value.

Our systems, made up of individual building blocks, can't do
that.  Each node boots as a separate system and is joined
together by the BIOS.  Thus, the BIOS rewrites the local APIC ID
register with a new value.

Potomac and Nocona chips have a mechanism by which the BIOS
writer can change bits 7:5 to match the assigned cluster ID. 
Bits 2:0 come from the thread ID.  However, bits 4:3 are still
those latched at reset.  Oops!

Summary:  Large clustered systems can't use cpuid to derive the
sibling information.

Fix:  Use the local APIC ID.  That's the value we use to online
the CPUs, so it had better be OK.  For non-clustered systems,
cpuid == local APIC, so nothing but large boxes should be
affected.






diff -pruN 2.6.8.1-mm4/arch/x86_64/kernel/setup.c w8.1m4/arch/x86_64/kernel/setup.c
--- 2.6.8.1-mm4/arch/x86_64/kernel/setup.c	2004-08-25 14:48:21.000000000 -0700
+++ w8.1m4/arch/x86_64/kernel/setup.c	2004-09-02 15:51:55.000000000 -0700
@@ -724,7 +724,7 @@ static void __init detect_ht(struct cpui
 		}
 		if (index_lsb != index_msb )
 			index_msb++;
-		initial_apic_id = ebx >> 24 & 0xff;
+		initial_apic_id = hard_smp_processor_id();
 		phys_proc_id[cpu] = initial_apic_id >> index_msb;
 		
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",


-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

--Boundary-00=_0J6PB9vpAf1ZxkB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cpu_sibling_map_2004-08-31_2.6.8.1-mm4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpu_sibling_map_2004-08-31_2.6.8.1-mm4"

diff -pruN 2.6.8.1-mm4/arch/x86_64/kernel/setup.c w8.1m4/arch/x86_64/kernel/setup.c
--- 2.6.8.1-mm4/arch/x86_64/kernel/setup.c	2004-08-25 14:48:21.000000000 -0700
+++ w8.1m4/arch/x86_64/kernel/setup.c	2004-09-02 15:51:55.000000000 -0700
@@ -724,7 +724,7 @@ static void __init detect_ht(struct cpui
 		}
 		if (index_lsb != index_msb )
 			index_msb++;
-		initial_apic_id = ebx >> 24 & 0xff;
+		initial_apic_id = hard_smp_processor_id();
 		phys_proc_id[cpu] = initial_apic_id >> index_msb;
 		
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",

--Boundary-00=_0J6PB9vpAf1ZxkB--

