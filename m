Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUIVIhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUIVIhw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 04:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUIVIhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 04:37:51 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:20960 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262418AbUIVIhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 04:37:45 -0400
Date: Wed, 22 Sep 2004 17:34:00 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[4/6]-Dynamic cpu
 register/unregister support
In-reply-to: <20040920094106.F14208@unix-os.sc.intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: tokunaga.keiich@jp.fujitsu.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <20040922173400.4e717946.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920094106.F14208@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004 09:41:07 -0700 Keshavamurthy Anil S wrote:
> ---
> Name:topology.patch
> Status:Tested on 2.6.9-rc2
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Depends:	
> Version: applies on 2.6.9-rc2	
> Description:
> Extends support for dynamic registration and unregistration of the cpu,
> by implementing and exporting arch_register_cpu()/arch_unregister_cpu().
> Also combines multiple implementation of topology_init() functions to
> single topology_init() in case of ia64 architecture.
> ---

> +void arch_unregister_cpu(int num)
> +{
> +	struct node *parent = NULL;
> +
> +#ifdef CONFIG_NUMA
> +	int node = cpu_to_node(num);
> +	if (node_online(node))
> +		parent = &sysfs_nodes[node];
> +#endif /* CONFIG_NUMA */
> +
> +	return unregister_cpu(&sysfs_cpus[num].cpu, parent);
> +}

I don't think that the check 'if (node_online(node))' is necessary
because sysfs_nodes[node] is there no matter if the node is online
or offline.  sysfs_nodes[] is cleared only when unregister_node()
is called and it would be always called after unregister_cpu().

Thanks,
Keiichiro Tokunaga


Name: arch_register_cpu_fix.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>

---

 linux-2.6.9-rc2-fix-kei/arch/ia64/kernel/topology.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/ia64/kernel/topology.c~arch_register_cpu_fix arch/ia64/kernel/topology.c
--- linux-2.6.9-rc2-fix/arch/ia64/kernel/topology.c~arch_register_cpu_fix	2004-09-22 11:56:58.793274256 +0900
+++ linux-2.6.9-rc2-fix-kei/arch/ia64/kernel/topology.c	2004-09-22 11:56:58.795227390 +0900
@@ -46,8 +46,7 @@ void arch_unregister_cpu(int num)
 
 #ifdef CONFIG_NUMA
 	int node = cpu_to_node(num);
-	if (node_online(node))
-		parent = &sysfs_nodes[node];
+	parent = &sysfs_nodes[node];
 #endif /* CONFIG_NUMA */
 
 	return unregister_cpu(&sysfs_cpus[num].cpu, parent);

_
