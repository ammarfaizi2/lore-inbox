Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTADUmb>; Sat, 4 Jan 2003 15:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTADUma>; Sat, 4 Jan 2003 15:42:30 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:9858 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261456AbTADUm2>;
	Sat, 4 Jan 2003 15:42:28 -0500
Message-ID: <3E174936.4080000@colorfullife.com>
Date: Sat, 04 Jan 2003 21:51:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [CFT,PATCH] Do not taint AMD non-MP cpus if only one cpu is present
Content-Type: multipart/mixed;
 boundary="------------040305030701050900030805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040305030701050900030805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

smp_store_cpu_info() sets TAINT_UNSAFE_SMP as soon as it finds an K7 cpu 
that doesn't support SMP, even if only one cpu is present. This is wrong 
- it's ok to run an SMP kernel with a non-MP cpu, as long as only one 
cpu is present.
Unfortunately neither num_online_cpus() nor num_booting_cpu() work when 
smp_store_cpu_info() is called.

The attached patch moves that check into an __initcall.
It's tested on my uniprocessor Duron, but not on real SMP.

Could someone with an Athlon-non-MP SMP setup check that the kernel 
still complains about the non-certified setup?

Thanks,
    Manfred

--------------040305030701050900030805
Content-Type: text/plain;
 name="patch-fix-taint"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fix-taint"

--- 2.5/arch/i386/kernel/smpboot.c	2003-01-04 10:18:05.000000000 +0100
+++ build-2.5/arch/i386/kernel/smpboot.c	2003-01-04 10:53:15.000000000 +0100
@@ -132,41 +132,57 @@
 		 * Remember we have B step Pentia with bugs
 		 */
 		smp_b_stepping = 1;
+}
 
-	/*
-	 * Certain Athlons might work (for various values of 'work') in SMP
-	 * but they are not certified as MP capable.
-	 */
-	if ((c->x86_vendor == X86_VENDOR_AMD) && (c->x86 == 6)) {
+static int __init check_smp_support(void)
+{
+	int i;
+
+	if (num_online_cpus() == 1)
+		return 0;
 
-		/* Athlon 660/661 is valid. */	
-		if ((c->x86_model==6) && ((c->x86_mask==0) || (c->x86_mask==1)))
-			goto valid_k7;
-
-		/* Duron 670 is valid */
-		if ((c->x86_model==7) && (c->x86_mask==0))
-			goto valid_k7;
+	for(i=0;i<NR_CPUS;i++) {
+		struct cpuinfo_x86 *c = cpu_data + i;
 
+		if (!cpu_online(i))
+			continue;
 		/*
-		 * Athlon 662, Duron 671, and Athlon >model 7 have capability bit.
-		 * It's worth noting that the A5 stepping (662) of some Athlon XP's
-		 * have the MP bit set.
-		 * See http://www.heise.de/newsticker/data/jow-18.10.01-000 for more.
+		 * Certain Athlons might work (for various values of 'work') in SMP
+		 * but they are not certified as MP capable.
 		 */
-		if (((c->x86_model==6) && (c->x86_mask>=2)) ||
-		    ((c->x86_model==7) && (c->x86_mask>=1)) ||
-		     (c->x86_model> 7))
-			if (cpu_has_mp)
+		if ((c->x86_vendor == X86_VENDOR_AMD) && (c->x86 == 6)) {
+
+			/* Athlon 660/661 is valid. */	
+			if ((c->x86_model==6) && ((c->x86_mask==0) || (c->x86_mask==1)))
 				goto valid_k7;
 
-		/* If we get here, it's not a certified SMP capable AMD system. */
-		printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
-		tainted |= TAINT_UNSAFE_SMP;
-	}
+			/* Duron 670 is valid */
+			if ((c->x86_model==7) && (c->x86_mask==0))
+				goto valid_k7;
+
+			/*
+			 * Athlon 662, Duron 671, and Athlon >model 7 have capability bit.
+			 * It's worth noting that the A5 stepping (662) of some Athlon XP's
+			 * have the MP bit set.
+			 * See http://www.heise.de/newsticker/data/jow-18.10.01-000 for more.
+			 */
+			if (((c->x86_model==6) && (c->x86_mask>=2)) ||
+			    ((c->x86_model==7) && (c->x86_mask>=1)) ||
+			     (c->x86_model> 7))
+				if (cpu_has_mp)
+					goto valid_k7;
+
+			/* If we get here, it's not a certified SMP capable AMD system. */
+			printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
+			tainted |= TAINT_UNSAFE_SMP;
+		}
 
-valid_k7:
-	;
+	valid_k7:
+		;
+	}
+	return 0;
 }
+__initcall(check_smp_support);
 
 /*
  * TSC synchronization.

--------------040305030701050900030805--

