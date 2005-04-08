Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVDHXwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVDHXwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVDHXwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:52:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:55974 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261203AbVDHXwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:52:47 -0400
Subject: Re: [PATCH] bootmem.c clean up bad pfn convertions
From: Dave Hansen <haveblue@us.ibm.com>
To: franck.bui-huu@innova-card.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <425687DB.4000205@innova-card.com>
References: <425687DB.4000205@innova-card.com>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 16:52:39 -0700
Message-Id: <1113004359.16633.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 15:32 +0200, Franck Bui-Huu wrote:
> As I described in my previous email, bootmem.c does improper
> pfn convertions into phys addr. This simple patch fixes that.
...
> -       bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
> -       bdata->node_boot_start = (start << PAGE_SHIFT);
> +       bdata->node_bootmem_map = phys_to_virt(pfn_to_phys(mapstart));
> +       bdata->node_boot_start = pfn_to_phys(start);

The only arch with phys_to_pfn() defined is UML, so the patch simply
won't compile anything but UML on current kernels (unless I'm missing
something).

Could you try to give us a more complete description of your problem?  I
know your memory doesn't start at 0x0, but what problems does that
cause?  Does the mem_map[] allocation blow up, etc...  

If it's just mem_map[], That calculation could be fixed pretty easily.
Something like

+#ifdef CONFIG_CRAZY_MIPS_FOO_MEM_MAP_START... 
+extern unsigned long mem_map_start_pfn
+#else
+#define mem_map_start_pfn 0UL
+#endif
-#define pfn_to_page(pfn)        (mem_map + (pfn))
+#define pfn_to_page(pfn)        (mem_map + (pfn) - mem_map_start_pfn)

(those names are horrid, please improve them, if you plan to do this)

All of the zone (and allocator) calculations should be just fine,
because it already has a zone_start_pfn.

-- Dave

