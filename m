Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVKVBEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVKVBEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVKVBEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:04:53 -0500
Received: from fmr21.intel.com ([143.183.121.13]:31952 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751077AbVKVBEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:04:53 -0500
Date: Mon, 21 Nov 2005 17:04:11 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: ashok.raj@intel.com, akpm@osdl.org, ak@muc.de, gregkh@suse.de,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [patch 2/2] Convert bigsmp to use flat physical mode
Message-ID: <20051121170411.A15347@unix-os.sc.intel.com>
References: <20051122000204.890352000@araj-sfield-2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051122000204.890352000@araj-sfield-2>; from ashok.raj@intel.com on Mon, Nov 21, 2005 at 03:39:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 03:39:16PM -0800, Ashok Raj wrote:
> 
>    -       if ((num_processors > 8) &&
>    -           APIC_XAPIC(ver) &&
>    -           (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL))
>    +       if (APIC_XAPIC(ver) &&
>    +               (CPU_HOTPLUG_ENABLED ||
>    +               ((num_processors > 8) &&
>    +                                      (boot_cpu_data.x86_vendor    ==
>    X86_VENDOR_INTEL))))
>                    def_to_bigsmp = 1;

Noticed that Andi send one more patch do enable bigsmp for AMD (i386), and the 
APIC_XAPIC() check was not properly placed to factor this in. This updated
patch should work for AMD as well, and switch to bigsmp when we have hotplug 
enabled.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


If we are using hotplug enabled kernel, then make bigsmp the default mode.


Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
-------------------------------------------------------
 arch/i386/kernel/mpparse.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

Index: linux-2.6.15-rc1-mm2/arch/i386/kernel/mpparse.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/arch/i386/kernel/mpparse.c
+++ linux-2.6.15-rc1-mm2/arch/i386/kernel/mpparse.c
@@ -38,6 +38,12 @@
 int smp_found_config;
 unsigned int __initdata maxcpus = NR_CPUS;
 
+#ifdef CONFIG_HOTPLUG_CPU
+#define CPU_HOTPLUG_ENABLED	(1)
+#else
+#define CPU_HOTPLUG_ENABLED	(0)
+#endif
+
 /*
  * Various Linux-internal data structures created from the
  * MP-table.
@@ -219,13 +225,18 @@ static void __devinit MP_processor_info 
 	cpu_set(num_processors, cpu_possible_map);
 	num_processors++;
 
-	if ((num_processors > 8) &&
-	    APIC_XAPIC(ver) &&
-	    (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL))
-		def_to_bigsmp = 1;
-	else
-		def_to_bigsmp = 0;
-
+	if (CPU_HOTPLUG_ENABLED || (num_processors > 8)) {
+		switch (boot_cpu_data.x86_vendor) {
+			case X86_VENDOR_INTEL:
+				if (!APIC_XAPIC(ver)) {
+					def_to_bigsmp = 0;
+					break;
+				}
+				/* If P4 and above fall through */
+			case X86_VENDOR_AMD:
+				def_to_bigsmp = 1;
+		}
+	}
 	bios_cpu_apicid[num_processors - 1] = m->mpc_apicid;
 }
 
