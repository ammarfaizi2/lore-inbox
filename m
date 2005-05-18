Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVERAGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVERAGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVERAGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:06:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22401 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262008AbVERAEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:04:44 -0400
Message-ID: <428A8697.4010606@us.ibm.com>
Date: Tue, 17 May 2005 17:04:39 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505161602460.20110@graphe.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010305020203020806060803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010305020203020806060803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Christoph Lameter wrote:
> On Mon, 16 May 2005, Martin J. Bligh wrote:
> 
> 
>>ppc64 box
>>
>>drivers/ide/ide-probe.c: In function `ide_init_queue':
>>drivers/ide/ide-probe.c:982: warning: implicit declaration of function `pcibus_to_node'
>>drivers/ide/ide-disk.c: In function `ide_disk_probe':
>>drivers/ide/ide-disk.c:1225: warning: implicit declaration of function `pcibus_to_node'
>>drivers/built-in.o(.text+0xaee4c): In function `.init_irq':
>>: undefined reference to `.pcibus_to_node'
>>drivers/built-in.o(.text+0xaf01c): In function `.init_irq':
>>: undefined reference to `.pcibus_to_node'
>>drivers/built-in.o(.text+0xb7808): In function `.ide_disk_probe':
>>: undefined reference to `.pcibus_to_node'
>>make: *** [.tmp_vmlinux1] Error 1
>>05/16/05-07:36:03 Build the kernel. Failed rc = 2
>>05/16/05-07:36:03 build: kernel build Failed rc = 1
> 
> 
> There was a prior discussion with the ppc64 folks about the way that 
> asm-generic/topology.h was included only for CONFIG_NUMA. I thought that 
> was fixed?
> 
> asm-generic/topology.h must also be included if CONFIG_NUMA is not set 
> inorder to provide the fall back pcibus_to_node function.
> 
> patch follows. Cannot test since I do not have a ppc64.
> 
> Index: linux-2.6.12-rc4/include/asm-ppc64/topology.h
> ===================================================================
> --- linux-2.6.12-rc4.orig/include/asm-ppc64/topology.h	2005-03-01 23:38:32.000000000 -0800
> +++ linux-2.6.12-rc4/include/asm-ppc64/topology.h	2005-05-16 16:06:24.000000000 -0700
> @@ -59,10 +59,8 @@
>  	.nr_balance_failed	= 0,			\
>  }
>  
> -#else /* !CONFIG_NUMA */
> +#endif /* CONFIG_NUMA */
>  
>  #include <asm-generic/topology.h>
>  
> -#endif /* CONFIG_NUMA */
> -
>  #endif /* _ASM_PPC64_TOPOLOGY_H */

Not a big fan of this patch.  It's not wrong, per-se, but it just doesn't
sit right with me.  asm-generic/topology.h should be a fallback file for
the arches that just want some sort of sane UP/SMP defaults.  The better
(IMHO) solution is this patch.  Builds fine on PPC64.

-Matt

--------------010305020203020806060803
Content-Type: text/x-patch;
 name="ppc64_topology-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64_topology-fix.patch"

--- linux-2.6.12-rc4-mm1/include/asm-ppc64/topology.h	2005-05-12 11:15:46.000000000 -0700
+++ linux-2.6.12-rc4-mm1/include/asm-ppc64/topology.h.fixed	2005-05-17 15:40:40.630853728 -0700
@@ -33,6 +33,8 @@ static inline int node_to_first_cpu(int 
 	return first_cpu(tmp);
 }
 
+#define pcibus_to_node(bus)	(-1)
+
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
 
 #define nr_cpus_node(node)	(nr_cpus_in_node[node])

--------------010305020203020806060803--
