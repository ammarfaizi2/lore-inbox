Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWC2BMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWC2BMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 20:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWC2BMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 20:12:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:36377 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750739AbWC2BMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 20:12:18 -0500
X-IronPort-AV: i="4.03,140,1141632000"; 
   d="scan'208"; a="16348481:sNHT9470464304"
Date: Tue, 28 Mar 2006 16:58:18 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Some section mismatch in acpi_processor_power_init on ia64 build
Message-ID: <20060329005818.GA7461@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0613EDAB@scsmsx401.amr.corp.intel.com> <200603290200.56023.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603290200.56023.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 02:00:55AM +0200, Andi Kleen wrote:
> > WARNING: drivers/acpi/processor.o - Section mismatch: reference to
> > .init.data: from .text between 'acpi_processor_power_init' (at offset
> > 0x5040) and 'acpi_processor_power_exit'
> > WARNING: drivers/acpi/processor.o - Section mismatch: reference to
> > .init.data: from .text between 'acpi_processor_power_init' (at offset
> > 0x5050) and 'acpi_processor_power_exit'
> 
> These functions need to be marked __cpuinit I guess. I doubt they
> run without new CPUs.

Marking acpi_processor_power_init() as __cpuinit produced a complaint about
a section mismatch in acpi_processor_start().  Marking that __cpuinit fixed
things for me (patch at end of this e-mail, only compile tested on one ia64
config).
> >   /* Actually this shouldn't be __cpuinitdata, would be better to fix the
> >      callers to only run once -AK */
> 
> Yes that's me. What is cryptic?

Perhaps it wasn't the comment that was baffling me, I was just generally
confused at this point.


diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 713b763..2dedc59 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -533,7 +533,7 @@ #endif
 
 static void *processor_device_array[NR_CPUS];
 
-static int acpi_processor_start(struct acpi_device *device)
+static int __cpuinit acpi_processor_start(struct acpi_device *device)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 80fa434..106d6f3 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1077,7 +1077,7 @@ static struct file_operations acpi_proce
 	.release = single_release,
 };
 
-int acpi_processor_power_init(struct acpi_processor *pr,
+int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
 	acpi_status status = 0;
