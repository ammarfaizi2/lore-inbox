Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264337AbUDTX2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUDTX2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUDTXZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:25:05 -0400
Received: from holomorphy.com ([207.189.100.168]:1691 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264337AbUDTXXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:23:38 -0400
Date: Tue, 20 Apr 2004 16:23:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.26 released
Message-ID: <20040420232312.GQ743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo@hera.kernel.org>,
	linux-kernel@vger.kernel.org
References: <200404141314.i3EDEbxv023592@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404141314.i3EDEbxv023592@hera.kernel.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 06:14:37AM -0700, Marcelo Tosatti wrote:
> final:
> - 2.4.26-rc4 was released as 2.4.26 with no changes.

Spotted by Joel Becker. Lookup through raw_phys_apicid[] needs bounds
checks, otherwise the APIC ID returned may be fetched from memory
beyond the end of the array resulting in various boot-time catastrophes.
I took the liberty of slightly rearranging cpu_present_to_apicid() in
the interest of clarity and/or Documentation/CodingStyle in the process.


-- wli


diff -puN include/asm-i386/smpboot.h~smp_boot_cpus include/asm-i386/smpboot.h
--- linux-2.4.21/include/asm-i386/smpboot.h~smp_boot_cpus	2004-04-20 15:52:15.000000000 -0700
+++ linux-2.4.21-wli/include/asm-i386/smpboot.h	2004-04-20 16:00:02.000000000 -0700
@@ -73,11 +73,18 @@ extern unsigned char raw_phys_apicid[NR_
  */
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
-		return raw_phys_apicid[mps_cpu];
-	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
-		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
-	return mps_cpu;
+	switch (clustered_apic_mode) {
+		case CLUSTERED_APIC_XAPIC:
+			if (mps_cpu >= NR_CPUS)
+				return BAD_APICID;
+			else
+				return raw_phys_apicid[mps_cpu];
+		case CLUSTERED_APIC_NUMAQ:
+			return (mps_cpu & ~0x3) << 2 | 1 << (mps_cpu & 0x3);
+		case CLUSTERED_APIC_NONE:
+		default:
+			return mps_cpu;
+	}
 }
 
 static inline unsigned long apicid_to_phys_cpu_present(int apicid)

_
