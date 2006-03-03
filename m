Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWCCRmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWCCRmB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWCCRmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:42:01 -0500
Received: from fmr22.intel.com ([143.183.121.14]:10423 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751346AbWCCRmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:42:00 -0500
Date: Fri, 3 Mar 2006 09:41:37 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, davej@redhat.com, len.brown@intel.com,
       ak@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060303094137.A26387@unix-os.sc.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com> <20060302083038.A11407@unix-os.sc.intel.com> <20060302184428.GB7304@redhat.com> <20060302112119.A13035@unix-os.sc.intel.com> <20060302231452.440a91c8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060302231452.440a91c8.akpm@osdl.org>; from akpm@osdl.org on Thu, Mar 02, 2006 at 11:14:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 11:14:52PM -0800, Andrew Morton wrote:
> On a uniprocessor build this causes a crash in acpi_processor_start():
> 
> 	BUG_ON((pr->id >= NR_CPUS) || (pr->id < 0));
> 
> pr->id is 255.
> 
> I could bodge around this in various ways, but the semantics of cpu IDs in
> there seem to be a bit opaque, and I suspect some more thought needs to go
> into it all.
> 
> As well as uniprocessor testing ;)

The UP definition of convert_acpiid_to_cpu() was left as (0xff), i should
have converted that to (-1) now that its an "int".

Here is the updated one, this time i also testbooted the UP kernel. :-)

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


Local apic entries are only 8 bits, but it seemed to not be caught with 
u8 return value result in the check

cpu_index >= NR_CPUS becomming always false.

drivers/acpi/processor_core.c: In function `acpi_processor_get_info':
drivers/acpi/processor_core.c:483: warning: comparison is always false due to limited range of data type


Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------
 drivers/acpi/processor_core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.16-rc5-mm1/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16-rc5-mm1.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16-rc5-mm1/drivers/acpi/processor_core.c
@@ -382,7 +382,7 @@ static int acpi_processor_remove_fs(stru
 
 /* Use the acpiid in MADT to map cpus in case of SMP */
 #ifndef CONFIG_SMP
-#define convert_acpiid_to_cpu(acpi_id) (0xff)
+#define convert_acpiid_to_cpu(acpi_id) (-1)
 #else
 
 #ifdef CONFIG_IA64
@@ -395,7 +395,7 @@ static int acpi_processor_remove_fs(stru
 #define ARCH_BAD_APICID		(0xff)
 #endif
 
-static u8 convert_acpiid_to_cpu(u8 acpi_id)
+static int convert_acpiid_to_cpu(u8 acpi_id)
 {
 	u16 apic_id;
 	int i;
@@ -421,7 +421,7 @@ static int acpi_processor_get_info(struc
 	acpi_status status = 0;
 	union acpi_object object = { 0 };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
-	u8 cpu_index;
+	int cpu_index;
 	static int cpu0_initialized;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_get_info");
@@ -466,7 +466,7 @@ static int acpi_processor_get_info(struc
 	cpu_index = convert_acpiid_to_cpu(pr->acpi_id);
 
 	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
-	if (!cpu0_initialized && (cpu_index == 0xff) &&
+	if (!cpu0_initialized && (cpu_index == -1) &&
 	    (num_online_cpus() == 1)) {
 		cpu_index = 0;
 	}
@@ -480,7 +480,7 @@ static int acpi_processor_get_info(struc
 	 *  less than the max # of CPUs. They should be ignored _iff
 	 *  they are physically not present.
 	 */
-	if (cpu_index >= NR_CPUS) {
+	if (cpu_index == -1) {
 		if (ACPI_FAILURE
 		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
 			ACPI_ERROR((AE_INFO,
