Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWHaGqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWHaGqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 02:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWHaGqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 02:46:47 -0400
Received: from hera.kernel.org ([140.211.167.34]:50861 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750731AbWHaGqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 02:46:46 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: "Moore, Robert" <robert.moore@intel.com>
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Thu, 31 Aug 2006 02:48:29 -0400
User-Agent: KMail/1.8.2
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "Mattia Dongili" <malattia@linux.it>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Keith Mannthey <kmannth@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608310248.29861.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 16:04, Moore, Robert wrote:
> As far as the unknown exception,
> 
> >[    9.392729]  [<c0246fb6>] acpi_ut_status_exit+0x31/0x5e
> >[    9.393453]  [<c0243352>] acpi_walk_resources+0x10e/0x11b
> >[    9.394174]  [<c025697e>] acpi_motherboard_add+0x22/0x31
> 
> I would guess that the callback routine for walk_resources is returning
> a non-zero status value which is causing an immediate abort of the walk
> with that value -- and the value is bogus.

Yep, see -EINVAL below.

-Len

http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patch



From: Keith Mannthey <kmannth@us.ibm.com>

This patch set allow SPARSEMEM and RESERVE based hot-add to work.  I have
test both options and they work as expected.  I am adding memory to the
2nd node of a numa system (x86_64).

Major changes from last set is the config change and RESERVE enablment.


This patch:


Make ACPI motherboard driver not attach to devices/handles it dosen't expect.
Fix a bug where the motherboard driver attached to hot-add memory event and
caused the add memory call to fail.

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---


diff -puN drivers/acpi/motherboard.c~hot-add-mem-x86_64-acpi-motherboard-fix drivers/acpi/motherboard.c
--- a/drivers/acpi/motherboard.c~hot-add-mem-x86_64-acpi-motherboard-fix
+++ a/drivers/acpi/motherboard.c
@@ -87,6 +87,7 @@ static acpi_status acpi_reserve_io_range
 		}
 	} else {
 		/* Memory mapped IO? */
+		 return -EINVAL;
 	}
 
 	if (requested_res)
@@ -96,11 +97,16 @@ static acpi_status acpi_reserve_io_range
 
 static int acpi_motherboard_add(struct acpi_device *device)
 {
+	acpi_status status;
 	if (!device)
 		return -EINVAL;
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 			    acpi_reserve_io_ranges, NULL);
 
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
 	return 0;
 }
 
_
