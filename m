Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTJaTvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 14:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263534AbTJaTvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 14:51:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:15241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263533AbTJaTvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 14:51:39 -0500
Date: Fri, 31 Oct 2003 11:48:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: bruce@perens.com (Bruce Perens)
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org
Subject: [PATCH/RFC] Re: Crash-on-boot in init_l440gx SMP
Message-Id: <20031031114849.3e2c5425.rddunlap@osdl.org>
In-Reply-To: <20031030200203.159BD321@workstation.perens.com>
References: <20031030200203.159BD321@workstation.perens.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003 12:02:03 -0800 (PST) bruce@perens.com (Bruce Perens) wrote:

| Hi,
| 
| Using -test9, I'm hitting BUG_ON(phys_addr + size < phys_addr) in ioremap.c,
| called from init_l440gx with a dual Pentum 3 SMP motherboard. Boot log with
| oops, and ksymoops output are attached. This system is main server for
| perens.com, and thus hasn't exercised 2.6 much. Please email me if I can be
| of any further assistance.
| 
| ------------[ cut here ]------------
| kernel BUG at arch/i386/mm/ioremap.c:202!
| invalid operand: 0000 [#1]
| CPU:    0
| EIP:    0060:[<c011e778>]    Not tainted
| EFLAGS: 00010207
| EIP is at ioremap_nocache+0xb8/0xd0
| eax: c37fd800   ebx: cc000000   ecx: 00000000   edx: 00000100
| esi: cc814000   edi: 00100000   ebp: fff00000   esp: cbfc1f84
| ds: 007b   es: 007b   ss: 0068
| Process swapper (pid: 1, threadinfo=cbfc0000 task=c11ff900)
| Stack: fff00000 00100000 00000010 c37fd800 00007113 cbf23000 cbf23c00 00000000 
|        c040b465 fff00000 00100000 00000000 00000000 c04145f0 c04145f4 00000001 
|        00000000 c03f29ab 00000000 00000000 c013739f 00000000 cbfc0000 c01050f6 
| Call Trace:
|  [<c040b465>] init_l440gx+0x65/0x290
|  [<c03f29ab>] do_initcalls+0x2b/0xa0
|  [<c013739f>] init_workqueues+0xf/0x24
|  [<c01050f6>] init+0x56/0x180
|  [<c01050a0>] init+0x0/0x180
|  [<c01092b9>] kernel_thread_helper+0x5/0xc
| 
| Code: 0f 0b ca 00 f8 db 33 c0 eb af 0f 0b c9 00 f8 db 33 c0 eb a1 
|  <0>Kernel panic: Attempted to kill init!

drivers/mtd/maps/l440gx.c:

	l440gx_map.virt = (unsigned long)ioremap_nocache(WINDOW_ADDR, WINDOW_SIZE);

where WINDOW_ADDR + WINDOW_SIZE == 0 (i.e., wraps to 0).


I can see why it would be a problem to wrap around and above 0,
but is it a problem to wrap exactly to 0?  I.e., to use the very
top of the address space?

Is the patch below sufficient for this case, or does it need
to call change_page_attr() also?

--
~Randy


description:	allow ioremap_nocache() to reach to the very top of
		physical memory (i.e., allow the wrapped address to be 0)
product_versions: Linux 2.6.0-test9
patch_name:	ioremap-wrap.patch
author:		Randy.Dunlap <rddunlap@osdl.org>
patch_version:	2003-10-31.11:36:14

diffstat:=
 arch/i386/mm/ioremap.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -Naurp ./arch/i386/mm/ioremap.c~ioremap-wrap ./arch/i386/mm/ioremap.c
--- ./arch/i386/mm/ioremap.c~ioremap-wrap	2003-10-25 11:43:13.000000000 -0700
+++ ./arch/i386/mm/ioremap.c	2003-10-31 11:27:32.000000000 -0800
@@ -191,15 +191,18 @@ void * __ioremap(unsigned long phys_addr
 void *ioremap_nocache (unsigned long phys_addr, unsigned long size)
 {
 	void *p = __ioremap(phys_addr, size, _PAGE_PCD);
+	unsigned long next_addr;
+
 	if (!p) 
 		return p; 
 
-	if (phys_addr + size < virt_to_phys(high_memory)) { 
+	next_addr = phys_addr + size;
+	if (next_addr != 0 && next_addr < virt_to_phys(high_memory)) { 
 		struct page *ppage = virt_to_page(__va(phys_addr));		
 		unsigned long npages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-		BUG_ON(phys_addr+size > (unsigned long)high_memory);
-		BUG_ON(phys_addr + size < phys_addr);
+		BUG_ON(next_addr > (unsigned long)high_memory);
+		BUG_ON(next_addr < phys_addr);
 
 		if (change_page_attr(ppage, npages, PAGE_KERNEL_NOCACHE) < 0) { 
 			iounmap(p); 
