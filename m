Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTEOJge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 05:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTEOJge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 05:36:34 -0400
Received: from holomorphy.com ([66.224.33.161]:19916 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263918AbTEOJgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 05:36:32 -0400
Date: Thu, 15 May 2003 02:48:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 kernels fail to start second CPU
Message-ID: <20030515094834.GO8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <24021.1052989062@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24021.1052989062@warthog.warthog>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 09:57:42AM +0100, David Howells wrote:
> I've got a computer here with a pair of Pentium Pro CPUs in it. 2.4 kernels
> have no problem starting both CPUs, only later 2.5 kernels (with or without
> noapic passed on the kernel cmdline).
> Can anyone suggest what might need to be done to fix the problem?
> The motherboard sports a fairly standard Intel chipset and there's a Matrox
> graphics card plugged in:

Sparse physical APIC ID's are not handled properly. This should correct
them.


-- wli


diff -prauN linux-2.5.69-1/arch/i386/kernel/smpboot.c dhowells-2.5.69-1/arch/i386/kernel/smpboot.c
--- linux-2.5.69-1/arch/i386/kernel/smpboot.c	Mon May 12 11:09:21 2003
+++ dhowells-2.5.69-1/arch/i386/kernel/smpboot.c	Thu May 15 02:46:59 2003
@@ -935,7 +935,7 @@
 
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
-	int apicid, cpu, bit;
+	int apicid, cpu, bit, kicked;
 
 	/*
 	 * Setup boot CPU information
@@ -1018,7 +1018,8 @@
 	 */
 	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
 
-	for (bit = 0; bit < NR_CPUS; bit++) {
+	kicked = 0;
+	for (bit = 0; kicked < NR_CPUS && bit < BITS_PER_LONG; bit++) {
 		apicid = cpu_present_to_apicid(bit);
 		/*
 		 * Don't even attempt to start the boot CPU!
@@ -1034,6 +1035,8 @@
 		if (do_boot_cpu(apicid))
 			printk("CPU #%d not responding - cannot use it.\n",
 								apicid);
+		else
+			++kicked;
 	}
 
 	/*
