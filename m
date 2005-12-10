Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVLJWe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVLJWe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 17:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVLJWe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 17:34:59 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46801
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750738AbVLJWe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 17:34:59 -0500
Date: Sat, 10 Dec 2005 14:35:23 -0800 (PST)
Message-Id: <20051210.143523.106612727.davem@davemloft.net>
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512102314530.4626@lai.local.lan>
References: <Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
	<20051207.133236.97581111.davem@davemloft.net>
	<Pine.LNX.4.64.0512102314530.4626@lai.local.lan>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Sat, 10 Dec 2005 23:25:36 +0100 (CET)

> I have to say I don't have much knowledge about the kernel code, but in 
> arch/sparc64/mm/generic.c it looks for me that no matter what if 
> io_remap_pte_range() is called it will result in a bug output, is this 
> supposed to happen? Looking at arch/sparc/mm/generic.c I can't find any 
> similar functionality.

That's not true.  The bug triggers if the page table mapping
is valid already, which should never occur when we are setting
up new mappings.  We should always find the PTEs we are filling
in as empty at this point in time.  That is what that bug check
is making sure of.

It doesn't trigger for me here with the Xorg server, on an
Ultra60 with CreatorFB.  I do get the cursor in the corner
and a non-functional screen but I can switch around to other
VC's and kill the X server cleanly.  I definitely don't get
those kernel log messages.

Please retest with this debug tracing added:

--- a/arch/sparc64/mm/generic.c.~1~	2005-12-10 14:34:18.000000000 -0800
+++ b/arch/sparc64/mm/generic.c	2005-12-10 14:34:56.000000000 -0800
@@ -137,6 +137,12 @@
 	int space = GET_IOSPACE(pfn);
 	unsigned long offset = GET_PFN(pfn) << PAGE_SHIFT;
 
+#if 1
+	printk("IO[%s:%d]: remap_pfn_range(s[%lx]e[%lx],f[%lx],pfn[%lx],sz[%lx],prot[%lx])\n",
+	       current->comm, current->pid,
+	       vma->vm_start, vma->vm_end,
+	       from, pfn, size, pgprot_val(prot));
+#endif
 	/* See comment in mm/memory.c remap_pfn_range */
 	vma->vm_flags |= VM_IO | VM_RESERVED | VM_PFNMAP;
 
