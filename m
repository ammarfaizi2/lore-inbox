Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVEPXHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVEPXHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 19:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVEPXHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 19:07:45 -0400
Received: from graphe.net ([209.204.138.32]:62987 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261763AbVEPXHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 19:07:35 -0400
Date: Mon, 16 May 2005 16:07:33 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
In-Reply-To: <734820000.1116277209@flay>
Message-ID: <Pine.LNX.4.62.0505161602460.20110@graphe.net>
References: <734820000.1116277209@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Martin J. Bligh wrote:

> ppc64 box
> 
> drivers/ide/ide-probe.c: In function `ide_init_queue':
> drivers/ide/ide-probe.c:982: warning: implicit declaration of function `pcibus_to_node'
> drivers/ide/ide-disk.c: In function `ide_disk_probe':
> drivers/ide/ide-disk.c:1225: warning: implicit declaration of function `pcibus_to_node'
> drivers/built-in.o(.text+0xaee4c): In function `.init_irq':
> : undefined reference to `.pcibus_to_node'
> drivers/built-in.o(.text+0xaf01c): In function `.init_irq':
> : undefined reference to `.pcibus_to_node'
> drivers/built-in.o(.text+0xb7808): In function `.ide_disk_probe':
> : undefined reference to `.pcibus_to_node'
> make: *** [.tmp_vmlinux1] Error 1
> 05/16/05-07:36:03 Build the kernel. Failed rc = 2
> 05/16/05-07:36:03 build: kernel build Failed rc = 1

There was a prior discussion with the ppc64 folks about the way that 
asm-generic/topology.h was included only for CONFIG_NUMA. I thought that 
was fixed?

asm-generic/topology.h must also be included if CONFIG_NUMA is not set 
inorder to provide the fall back pcibus_to_node function.

patch follows. Cannot test since I do not have a ppc64.

Index: linux-2.6.12-rc4/include/asm-ppc64/topology.h
===================================================================
--- linux-2.6.12-rc4.orig/include/asm-ppc64/topology.h	2005-03-01 23:38:32.000000000 -0800
+++ linux-2.6.12-rc4/include/asm-ppc64/topology.h	2005-05-16 16:06:24.000000000 -0700
@@ -59,10 +59,8 @@
 	.nr_balance_failed	= 0,			\
 }
 
-#else /* !CONFIG_NUMA */
+#endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
 
-#endif /* CONFIG_NUMA */
-
 #endif /* _ASM_PPC64_TOPOLOGY_H */
