Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVJYHrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVJYHrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVJYHrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:47:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34271 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932069AbVJYHra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:47:30 -0400
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] i386 mpparse: Only ignore lapic information we can't store
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
	<20051021133306.GC3799@in.ibm.com>
	<m1ach3dj47.fsf@ebiederm.dsl.xmission.com>
	<20051022145207.GA4501@in.ibm.com>
	<m11x2deft5.fsf@ebiederm.dsl.xmission.com>
	<20051024130311.GA5853@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 25 Oct 2005 01:47:08 -0600
In-Reply-To: <20051024130311.GA5853@in.ibm.com> (Vivek Goyal's message of
 "Mon, 24 Oct 2005 18:33:11 +0530")
Message-ID: <m1irvmca2r.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After staring at mpparse.c for a little longer I noticed that
when we hit our limit of num_processors we are filtering out
information about other processors that we can still store.

This patch just reorders the code so we store everything we
can.  

This should avoid the incorrect warning about our boot CPU
not being listed by the BIOS that we are now getting in
the kexec on panic case, and it should allow us to detect
all apicid conflicts even when our physical number of
cpus exceeds maxcpus.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/i386/kernel/mpparse.c |   35 +++++++++++++++++++----------------
 1 files changed, 19 insertions(+), 16 deletions(-)

applies-to: cf16f96fe9347e42dd2fc6b305005a52783195d4
192f11c9442be11c6535b38d371aa3771fd9513e
diff --git a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
index 27aabfc..07555a4 100644
--- a/arch/i386/kernel/mpparse.c
+++ b/arch/i386/kernel/mpparse.c
@@ -182,17 +182,6 @@ static void __init MP_processor_info (st
 		boot_cpu_physical_apicid = m->mpc_apicid;
 	}
 
-	if (num_processors >= NR_CPUS) {
-		printk(KERN_WARNING "WARNING: NR_CPUS limit of %i reached."
-			"  Processor ignored.\n", NR_CPUS); 
-		return;
-	}
-
-	if (num_processors >= maxcpus) {
-		printk(KERN_WARNING "WARNING: maxcpus limit of %i reached."
-			" Processor ignored.\n", maxcpus); 
-		return;
-	}
 	ver = m->mpc_apicver;
 
 	if (!MP_valid_apicid(apicid, ver)) {
@@ -201,11 +190,6 @@ static void __init MP_processor_info (st
 		return;
 	}
 
-	cpu_set(num_processors, cpu_possible_map);
-	num_processors++;
-	phys_cpu = apicid_to_cpu_present(apicid);
-	physids_or(phys_cpu_present_map, phys_cpu_present_map, phys_cpu);
-
 	/*
 	 * Validate version
 	 */
@@ -216,6 +200,25 @@ static void __init MP_processor_info (st
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
+
+	phys_cpu = apicid_to_cpu_present(apicid);
+	physids_or(phys_cpu_present_map, phys_cpu_present_map, phys_cpu);
+
+	if (num_processors >= NR_CPUS) {
+		printk(KERN_WARNING "WARNING: NR_CPUS limit of %i reached."
+			"  Processor ignored.\n", NR_CPUS); 
+		return;
+	}
+
+	if (num_processors >= maxcpus) {
+		printk(KERN_WARNING "WARNING: maxcpus limit of %i reached."
+			" Processor ignored.\n", maxcpus); 
+		return;
+	}
+
+	cpu_set(num_processors, cpu_possible_map);
+	num_processors++;
+
 	if ((num_processors > 8) &&
 	    APIC_XAPIC(ver) &&
 	    (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL))
