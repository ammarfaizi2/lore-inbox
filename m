Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUIVN1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUIVN1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 09:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUIVN1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 09:27:37 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:16588 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265161AbUIVN10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 09:27:26 -0400
Date: Wed, 22 Sep 2004 22:23:40 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[3/6]-Mapping lsapic to cpu
In-reply-to: <20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com>
To: anil.s.keshavamurthy@intel.com
Cc: tokunaga.keiich@jp.fujitsu.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <20040922222340.586de6ae.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920093819.E14208@unix-os.sc.intel.com>
 <20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 22:15:38 +0900 Keiichiro Tokunaga wrote:
> On Mon, 20 Sep 2004 09:38:19 -0700 Keshavamurthy Anil S wrote:
> > ---
> > Name:acpi_hotplug_arch.patch
> > Status: Tested on 2.6.9-rc2
> > Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > Depends:	
> > Version: applies on 2.6.9-rc2	
> > Description: 
> > This patch provides the architecture specifice support for mapping lsapic to cpu array.
> > Currently this supports just IA64. Support for IA32 and x86_64 is in progress
> > ---
> 
> I would like to suggest introducing a new function 'acpi_get_pxm()'
> since other drivers might need it in the future.  Acutally, ACPI container
> hotplug will be use it soon.

I have made a patch to modify your code to use acpi_get_pxm()
that I just posted earlier.  I hope it does not break your code:)
What do you think of it?

Thanks,
Keiichiro Tokunaga



Name: acpi_cpu_pxm_fix.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Description:
Modify acpi_map_cpu2node() to use acpi_get_pxm().


---

 linux-2.6.9-rc2-fix-kei/arch/ia64/kernel/acpi.c |   31 +++++-------------------
 1 files changed, 7 insertions(+), 24 deletions(-)

diff -puN arch/ia64/kernel/acpi.c~acpi_cpu_pxm_fix arch/ia64/kernel/acpi.c
--- linux-2.6.9-rc2-fix/arch/ia64/kernel/acpi.c~acpi_cpu_pxm_fix	2004-09-22 22:20:53.797821495 +0900
+++ linux-2.6.9-rc2-fix-kei/arch/ia64/kernel/acpi.c	2004-09-22 22:20:53.800751203 +0900
@@ -659,36 +659,20 @@ int
 acpi_map_cpu2node(acpi_handle handle, int cpu, long physid)
 {
 #ifdef CONFIG_ACPI_NUMA
-	int 			pxm_id = 0;
-	union acpi_object 	*obj;
-	struct acpi_buffer 	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	int 			pxm_id;
 
-	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_PXM", NULL, &buffer)))
-		goto pxm_id_0;
+	pxm_id = acpi_get_pxm(handle);
 
-	if ((!buffer.length) || (!buffer.pointer))
-		goto pxm_id_0;
-
-	obj = buffer.pointer;
-	if (obj->type != ACPI_TYPE_INTEGER) {
-		acpi_os_free(buffer.pointer);
-		goto pxm_id_0;
-	}
-
-	pxm_id = obj->integer.value;
-
-pxm_id_0:
 	/*
 	 * Assuming that the container driver would have set the proximity
 	 * domain and would have initialized pxm_to_nid_map[pxm_id] && pxm_flag
 	 */
 
-	/* Return Error if proximity domain is not set */
-	if (!pxm_bit_test(pxm_id))
-		return -EINVAL;
-
 	node_cpuid[cpu].phys_id =  physid;
-	node_cpuid[cpu].nid = pxm_to_nid_map[pxm_id];
+	if (pxm_id < 0)
+		node_cpuid[cpu].nid = 0;
+	else
+		node_cpuid[cpu].nid = pxm_to_nid_map[pxm_id];
 
 #endif
 	return(0);
@@ -737,8 +721,7 @@ acpi_map_lsapic(acpi_handle handle, int 
 	if(cpu >= NR_CPUS)
 		return -EINVAL;
 
-	if (ACPI_FAILURE(acpi_map_cpu2node(handle, cpu, physid)))
-	return -ENODEV;
+	acpi_map_cpu2node(handle, cpu, physid);
 
  	cpu_set(cpu, cpu_present_map);
 	ia64_cpu_to_sapicid[cpu] = physid;

_
