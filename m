Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUJ1S2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUJ1S2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUJ1S2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:28:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:14490 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263085AbUJ1S1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:27:19 -0400
Date: Thu, 28 Oct 2004 11:27:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: jamesclv@us.ibm.com, ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] clustered apic patch missing APIC_DFR_CLUSTER def
Message-ID: <20041028112715.D14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cluster apic support does not compile.  I added the APIC_DFR_CLUSTER
def to asm-x86_64/apicdef.h (stolen from i386 one).  Also added
APIC_DFR_FLAT while there.  This may only be papering over real fix.

Additionally, cluster_cpu_present_to_apicid() is defined but not used
anywhere.  So remove it.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== include/asm-x86_64/apicdef.h 1.6 vs edited =====
--- 1.6/include/asm-x86_64/apicdef.h	2004-10-28 00:39:50 -07:00
+++ edited/include/asm-x86_64/apicdef.h	2004-10-28 11:15:19 -07:00
@@ -32,6 +32,8 @@
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
 #define			APIC_ALL_CPUS		0xFFu
 #define		APIC_DFR	0xE0
+#define			APIC_DFR_CLUSTER		0x0FFFFFFFu
+#define			APIC_DFR_FLAT			0xFFFFFFFFu
 #define		APIC_SPIV	0xF0
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
===== arch/x86_64/kernel/genapic_cluster.c 1.1 vs edited =====
--- 1.1/arch/x86_64/kernel/genapic_cluster.c	2004-10-28 00:39:50 -07:00
+++ edited/arch/x86_64/kernel/genapic_cluster.c	2004-10-28 11:18:10 -07:00
@@ -57,14 +57,6 @@
 	apic_write_around(APIC_LDR, val);
 }
 
-static int cluster_cpu_present_to_apicid(int mps_cpu)
-{
-	if ((unsigned)mps_cpu < NR_CPUS)
-		return (int)bios_cpu_apicid[mps_cpu];
-	else
-		return BAD_APICID;
-}
-
 /* Start with all IRQs pointing to boot CPU.  IRQ balancing will shift them. */
 
 static cpumask_t cluster_target_cpus(void)
