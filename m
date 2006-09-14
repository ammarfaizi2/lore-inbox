Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWINVe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWINVe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWINVe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:34:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:39884 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750769AbWINVe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:34:58 -0400
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in
	get_memcfg_from_srat
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Vivek goyal <vgoyal@in.ibm.com>, ebiederm@xmission.com,
       andrew <akpm@osdl.org>, dave hansen <haveblue@us.ibm.com>
In-Reply-To: <1158113895.9562.13.camel@keithlap>
References: <1158113895.9562.13.camel@keithlap>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 14 Sep 2006 14:34:56 -0700
Message-Id: <1158269696.15745.5.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 19:18 -0700, keith mannthey wrote: 
> Hello,
>   I am trying to use i386 SRAT and it is not working.  The srat code
> (get_memcfg_from_srat) needs to map in the SRAT table during boot to see
> all the numa information.  It gets the RSDP just fine but when it looks
> up the RSDT the header is empty (I tried to print out RSDT header and it
> was empty) and it exits :( 
> 
> Excerpts from my boot log.... 
> 
> get_memcfg_from_srat: assigning address to rsdp
> RSD PTR  v0 [IBM   ]
> ACPI: RSDT signature incorrect
> failed to get NUMA memory information from SRAT table
> NUMA - single node, flat memory mode
> Node: 0, start_pfn: 0, end_pfn: 156
> 
> Something is wrong.
> 
> A while later in the boot I see. 
> 
> Using APIC driver default
> ACPI: RSDP (v000 IBM                                   ) @ 0x000fdfc0
> ACPI: RSDT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xeff9c2c0
> ACPI: FADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xeff9c240
> ACPI: MADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xeff9c0c0
> ACPI: SRAT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xeff9bf40
> ACPI: DSDT (v001 IBM    SERVIGIL 0x00001000 INTL 0x02002025) @ 0x00000000
>  
> Looks like the RSDT table it there.... 
> 
> I haven't booted i386 numa Summit in a while and was wondering if anyone
> had any ideas?

I found something odd. I went back to a kernels that I knew had booted
(2.6.16) and it was still broken.  I realized that I was running my
kernel builds with a new config file so I started poking around. In the
end changing the config like (dropping kdump)

@@ -232,8 +232,8 @@
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
-CONFIG_CRASH_DUMP=y
-CONFIG_PHYSICAL_START=0x1000000
+# CONFIG_CRASH_DUMP is not set
+CONFIG_PHYSICAL_START=0x100000
CONFIG_HOTPLUG_CPU=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
@@ -2872,7 +2872,6 @@
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
-CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y



allowed the SRAT to be mapped during boot. I highly suspect the change
in CONFIG_PHYSICAL_START from 0x100000 to 0x1000000 is to blame for the
change if functionally of boot_ioremap.

The SRAT code uses boot_ioremap to map in the table.  With the change of
the the kernel start the mappings that boot_ioremap are returning are
messed up (the data is *not* mapped at the address it returns). 

There is some disconnect between boot_ioremap and different
CONFIG_PHYSICAL_START values. I suspect efi (it uses boot_ioremap) will
also be broken with kdump.

Well that is what I found and it is not a new problem just a previous
unused config. 

Any ideas?

Thanks,
  Keith 



