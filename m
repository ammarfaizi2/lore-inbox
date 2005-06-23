Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVFWXxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVFWXxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVFWXxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:53:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262915AbVFWXwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:52:36 -0400
Date: Thu, 23 Jun 2005 16:52:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: James@superbug.demon.co.uk, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: 2.6.12-rc6-mm1 oops on startup.
Message-Id: <20050623165200.3990ea60.akpm@osdl.org>
In-Reply-To: <42BB2BE8.1050608@superbug.co.uk>
References: <42B46C18.2030101@superbug.demon.co.uk>
	<20050621235144.15fc55c6.akpm@osdl.org>
	<42BB0DBE.3070003@superbug.demon.co.uk>
	<42BB2BE8.1050608@superbug.co.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton <James@superbug.co.uk> wrote:
>
> Ok, it now boots, but I now get a new problem.
>  after "modprobe yenta-socket", and then "cat /proc/iomem" I get the
>  attached kernel segfault.
> 
>  Extract below:
>  Unable to handle kernel NULL pointer dereference at virtual address 00000010
>   printing eip:
>  c0126fc0
>  *pde = 00000000
>  Oops: 0000 [#1]
>  PREEMPT SMP DEBUG_PAGEALLOC
>  Modules linked in: yenta_socket rsrc_nonstatic pcmcia_core usbcore
>  CPU:    0
>  EIP:    0060:[<c0126fc0>]    Not tainted VLI
>  EFLAGS: 00010297   (2.6.12-mm1)
>  EIP is at r_show+0x30/0x90
>  eax: 00000000   ebx: 00000008   ecx: 00000003   edx: c03ca87c
>  esi: f7fafaa8   edi: f4f7af78   ebp: f4fabf28   esp: f4fabef8
>  ds: 007b   es: 007b   ss: 0068
>  Process cat (pid: 1750, threadinfo=f4faa000 task=f4f55af0)
>  Stack: f4f7af78 c0389e8b 00000000 c038d590 00000008 3fffc000 00000008
>  3fffffff
>         c03883a3 00000000 f4f7af78 f7fafaa8 f4fabf60 c018b702 f4f7af78
>  f7fafaa8
>         f4fabf44 000001a7 00000000 0000000d 00000000 0000000c 00000000
>  00000400
>  Call Trace:
>   [<c01040df>] show_stack+0x7f/0xa0
>   [<c0104284>] show_registers+0x164/0x1e0
>   [<c01044cd>] die+0x10d/0x1a0
>   [<c011749c>] do_page_fault+0x4bc/0x6b8
>   [<c0103d0f>] error_code+0x4f/0x54
>   [<c018b702>] seq_read+0x242/0x2f0
>   [<c01667f3>] vfs_read+0xe3/0x1b0
>   [<c0166bcb>] sys_read+0x4b/0x80
>   [<c01031f9>] syscall_call+0x7/0xb
>  Code: 53 83 ec 24 8b 7d 08 8b 75 0c 8b 57 40 8b 42 08 3d 00 00 01 00 19
>  db 89 f0 83 e3 fc 31 c9 83 c3 08 8d 76 00 8d bc 27 00 00 00 00 <8b> 40
>  10 39 d0 74 06 41 83 f9 04 7e f3 8b 06 ba 85 9e 38 c0 85

Me too.  binary search indicates that it's introduced by
gregkh-pci-pci-assign-unassigned-resources.patch.

Unfortunately that patch does three seemingly-unrelated things and none of
them are directly related to /proc handling.  Splitting the patch into
three pieces indicates that this hunk alone is sufficient to cause the
crash:


diff -puN arch/i386/pci/common.c~a arch/i386/pci/common.c
--- 25/arch/i386/pci/common.c~a	2005-06-23 16:48:42.000000000 -0700
+++ 25-akpm/arch/i386/pci/common.c	2005-06-23 16:48:42.000000000 -0700
@@ -165,6 +165,7 @@ static int __init pcibios_init(void)
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
 #endif
+	pci_assign_unassigned_resources();
 	return 0;
 }
 
_

