Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264722AbUD1KXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbUD1KXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUD1KXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:23:52 -0400
Received: from [203.14.152.115] ([203.14.152.115]:55821 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264722AbUD1KXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:23:18 -0400
Date: Wed, 28 Apr 2004 20:19:21 +1000
To: Ruben Porras <nahoo82@telefonica.net>, 246149@bugs.debian.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Bug#246149: kernel-image-2.6.5-1-686: pci_hotplug fails at boot
Message-ID: <20040428101921.GA15248@gondor.apana.org.au>
References: <E1BITou-0002ZM-8K@nahoo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <E1BITou-0002ZM-8K@nahoo>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tags 246149 pending
quit

On Tue, Apr 27, 2004 at 04:44:23PM +0200, Ruben Porras wrote:
> Package: kernel-image-2.6.5-1-686
> Version: 2.6.5-2
> Severity: normal
>
> shpchp: acpi_shpchprm:\_SB_.PCI0 _CRS fail=0x300b
> shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _CRS fail=0x300b

This means that the adding of the bridges failed and therefore
we don't have any bridges.

> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: shpc_init : shpc_cap_offset == 0
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> Unable to handle kernel NULL pointer dereference at virtual address 00000050
>  printing eip:
> e0a79719
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> CPU:    0
> EIP:    0060:[<e0a79719>]    Not tainted
> EFLAGS: 00010292   (2.6.5-1-686) 
> EIP is at print_acpi_resources+0x9/0x140 [shpchp]
> eax: 00000000   ebx: 00000000   ecx: c02b5ef0   edx: 00000000
> esi: 00000000   edi: df736000   ebp: c02b7658   esp: df737f58
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 659, threadinfo=df736000 task=dfd0e660)
> Stack: c0120ce0 0000000a 00000400 e0a7c000 df737f90 de392680 c02e7e40 00000000 
>        e0a83560 e0a7986a 00000000 df736000 e0936070 e0a7c000 e0a8356c c02b7670 
>        e0a83560 c02b7670 c01371c0 c034e688 00000001 e0a83560 40164000 0804ee38 
> Call Trace:
>  [<c0120ce0>] printk+0x130/0x190
>  [<e0a7986a>] shpchprm_print_pirt+0x1a/0x40 [shpchp]
>  [<e0936070>] shpcd_init+0x70/0x96 [shpchp]
>  [<c01371c0>] sys_init_module+0x100/0x210
>  [<c0109319>] sysenter_past_esp+0x52/0x71
> 
> Code: 8b 46 50 85 c0 0f 84 e3 00 00 00 48 0f 84 9f 00 00 00 89 34 

Now it tries to print the bridges which is NULL.

The following patch should fix the crash.

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/pci/hotplug/shpchprm_acpi.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/pci/hotplug/shpchprm_acpi.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 shpchprm_acpi.c
--- a/drivers/pci/hotplug/shpchprm_acpi.c	11 Mar 2004 02:55:25 -0000	1.1.1.1
+++ b/drivers/pci/hotplug/shpchprm_acpi.c	28 Apr 2004 10:10:31 -0000
@@ -1267,7 +1267,8 @@
 int shpchprm_print_pirt(void)
 {
 	dbg("SHPCHPRM ACPI Slots\n");
-	print_acpi_resources (acpi_bridges_head);
+	if (acpi_bridges_head)
+		print_acpi_resources (acpi_bridges_head);
 	return 0;
 }
 

--82I3+IH0IqGh5yIs--
