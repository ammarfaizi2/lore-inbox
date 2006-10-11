Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161428AbWJKVSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161428AbWJKVSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161429AbWJKVIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:08:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:27810 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161428AbWJKVIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:11 -0400
Date: Wed, 11 Oct 2006 14:07:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, tony.luck@intel.com,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 44/67] cpu to node relationship fixup: acpi_map_cpu2node
Message-ID: <20061011210731.GS16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cpu-to-node-relationship-fixup-acpi_map_cpu2node.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
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
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/ia64/kernel/acpi.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- linux-2.6.18.orig/arch/ia64/kernel/acpi.c
+++ linux-2.6.18/arch/ia64/kernel/acpi.c
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

--
