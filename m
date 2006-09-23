Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWIWAHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWIWAHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWIWAHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:07:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964942AbWIWAHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:07:16 -0400
Date: Fri, 22 Sep 2006 17:06:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       "tony.luck@intel.com" <tony.luck@intel.com>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, GOTO <y-goto@jp.fujitsu.com>
Subject: Re: [BUGFIX][PATCH] cpu to node relationship fixup take2 [1/2]
 acpi_map_cpu2node
Message-Id: <20060922170655.bb812edd.akpm@osdl.org>
In-Reply-To: <20060922170604.745d662a.akpm@osdl.org>
References: <20060922152447.42a83860.kamezawa.hiroyu@jp.fujitsu.com>
	<20060922170604.745d662a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 17:06:04 -0700
Andrew Morton <akpm@osdl.org> wrote:

> cpu-to-node-relationship-fixup-take2.patch

From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Problem description:

  We have additional_cpus= option for allocating possible_cpus.  But nid
  for possible cpus are not fixed at boot time.  cpus which is offlined at
  boot or cpus which is not on SRAT is not tied to its node.  This will
  cause panic at cpu onlining.

Usually, pxm_to_nid() mapping is fixed at boot time by SRAT.

But, unfortunately, some system (my system!) do not include
full SRAT table for possible cpus.  (Then, I use
additiona_cpus= option.)

For such possible cpus, pxm<->nid should be fixed at
hot-add.  We now have acpi_map_pxm_to_node() which is also
used at boot.  It's suitable here.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ia64/kernel/acpi.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff -puN arch/ia64/kernel/acpi.c~cpu-to-node-relationship-fixup-take2 arch/ia64/kernel/acpi.c
--- a/arch/ia64/kernel/acpi.c~cpu-to-node-relationship-fixup-take2
+++ a/arch/ia64/kernel/acpi.c
@@ -771,16 +771,19 @@ int acpi_map_cpu2node(acpi_handle handle
 {
 #ifdef CONFIG_ACPI_NUMA
 	int pxm_id;
+	int nid;
 
 	pxm_id = acpi_get_pxm(handle);
-
 	/*
-	 * Assuming that the container driver would have set the proximity
-	 * domain and would have initialized pxm_to_node(pxm_id) && pxm_flag
+	 * We don't have cpu-only-node hotadd. But if the system equips
+	 * SRAT table, pxm is already found and node is ready.
+  	 * So, just pxm_to_nid(pxm) is OK.
+	 * This code here is for the system which doesn't have full SRAT
+  	 * table for possible cpus.
 	 */
-	node_cpuid[cpu].nid = (pxm_id < 0) ? 0 : pxm_to_node(pxm_id);
-
+	nid = acpi_map_pxm_to_node(pxm_id);
 	node_cpuid[cpu].phys_id = physid;
+	node_cpuid[cpu].nid = nid;
 #endif
 	return (0);
 }
_

