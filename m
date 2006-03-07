Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWCGBlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWCGBlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWCGBkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:40:49 -0500
Received: from fmr20.intel.com ([134.134.136.19]:56780 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932550AbWCGBko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:40:44 -0500
Subject: [PATCH] deterine xapic using apic version
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 09:39:49 +0800
Message-Id: <1141695589.19013.25.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checking APIC version instead of CPU family to determine XAPIC. Family 6
CPU could have xapic as well.

Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.16-rc5-root/arch/i386/kernel/io_apic.c |    3 ++-
 linux-2.6.16-rc5-root/arch/i386/kernel/mpparse.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/io_apic.c~xapic_id arch/i386/kernel/io_apic.c
--- linux-2.6.16-rc5/arch/i386/kernel/io_apic.c~xapic_id	2006-03-02 10:46:36.000000000 +0800
+++ linux-2.6.16-rc5-root/arch/i386/kernel/io_apic.c	2006-03-05 07:26:48.000000000 +0800
@@ -1759,7 +1759,8 @@ static void __init setup_ioapic_ids_from
 	 * Don't check I/O APIC IDs for xAPIC systems.  They have
 	 * no meaning without the serial APIC bus.
 	 */
-	if (!(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && boot_cpu_data.x86 < 15))
+	if (!(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		|| APIC_XAPIC(apic_version[boot_cpu_physical_apicid]))
 		return;
 	/*
 	 * This is broken; anything with a real cpu count has to
diff -puN arch/i386/kernel/mpparse.c~xapic_id arch/i386/kernel/mpparse.c
--- linux-2.6.16-rc5/arch/i386/kernel/mpparse.c~xapic_id	2006-03-05 07:23:25.000000000 +0800
+++ linux-2.6.16-rc5-root/arch/i386/kernel/mpparse.c	2006-03-05 07:27:09.000000000 +0800
@@ -935,7 +935,8 @@ void __init mp_register_ioapic (
 	mp_ioapics[idx].mpc_apicaddr = address;
 
 	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
-	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 < 15))
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		&& !APIC_XAPIC(apic_version[boot_cpu_physical_apicid]))
 		tmpid = io_apic_get_unique_id(idx, id);
 	else
 		tmpid = id;
_


