Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWCEAo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWCEAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWCEAo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 19:44:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4579 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932312AbWCEAo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 19:44:26 -0500
Date: Sat, 4 Mar 2006 16:42:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, ak@suse.de, Ashok Raj <ashok.raj@intel.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-Id: <20060304164238.37d2ea49.akpm@osdl.org>
In-Reply-To: <20060302010953.GA19755@redhat.com>
References: <200603011957_MC3-1-B99B-8FFE@compuserve.com>
	<20060302010953.GA19755@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Wed, Mar 01, 2006 at 07:55:25PM -0500, Chuck Ebbert wrote:
>  > In-Reply-To: <20060301230317.GF1440@redhat.com>
>  > 
>  > On Wed, 1 Mar 2006 18:03:17, Dave Jones wrote:
>  > 
>  > > (17:59:38:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu0/topology/core_siblings
>  > > 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
>  > > (17:59:47:davej@nemesis:~)$ cat /sys/devices/system/cpu/cpu1/topology/core_siblings
>  > > 00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002
>  > > 
>  > > Neither of these CPUs are HT / dual-core, so shouldn't these be the same ?
>  > 
>  > Those are bitmaps. 1 => only bit 0 is set => CPU 0 is all alone.
>  > 
>  > Did you really build a 256-CPU SMP kernel or is ACPI ignoring CONFIG_NR_CPUS
>  > or something?
> 
> Yes, it's =256.
> 

Is that the only way in which to trigger the bug?

If so, I'd be inclined to hold the fix back for 2.6.17.


From: Ashok Raj <ashok.raj@intel.com>

Local apic entries are only 8 bits, but it seemed to not be caught with u8
return value result in the check cpu_index >= NR_CPUS becomming always false.

drivers/acpi/processor_core.c: In function `acpi_processor_get_info':
drivers/acpi/processor_core.c:483: warning: comparison is always false due to limited range of data type

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/acpi/processor_core.c~acpi-signedness-fix-2 drivers/acpi/processor_core.c
--- 25/drivers/acpi/processor_core.c~acpi-signedness-fix-2	Fri Mar  3 16:25:09 2006
+++ 25-akpm/drivers/acpi/processor_core.c	Fri Mar  3 16:25:09 2006
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
_

