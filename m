Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWCBTVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWCBTVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWCBTVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:21:42 -0500
Received: from fmr22.intel.com ([143.183.121.14]:24969 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932469AbWCBTVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:21:41 -0500
Date: Thu, 2 Mar 2006 11:21:19 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Dave Jones <davej@redhat.com>
Cc: Ashok Raj <ashok.raj@intel.com>, "Brown, Len" <len.brown@intel.com>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060302112119.A13035@unix-os.sc.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com> <20060302083038.A11407@unix-os.sc.intel.com> <20060302184428.GB7304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060302184428.GB7304@redhat.com>; from davej@redhat.com on Thu, Mar 02, 2006 at 01:44:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 01:44:28PM -0500, Dave Jones wrote:
> I thought I already posted that..
> 

Sorry.. i noticed it later...

I think the problem is the return type u8, and -1 being treated as error
return.

You probably missed the warning that flew by...

could you check if the attached patch works for you?

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
 drivers/acpi/processor_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.16-rc5-mm1/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16-rc5-mm1.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16-rc5-mm1/drivers/acpi/processor_core.c
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
