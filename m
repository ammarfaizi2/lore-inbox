Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTJ0RWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTJ0RWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:22:36 -0500
Received: from front2.chartermi.net ([24.213.60.124]:60087 "EHLO
	front2.chartermi.net") by vger.kernel.org with ESMTP
	id S263311AbTJ0RWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:22:33 -0500
Message-ID: <3F9D5458.9010704@didntduck.org>
Date: Mon, 27 Oct 2003 12:22:32 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: cat /proc/bus/pnp/escd -> kernel segfault (2.6 BK)
References: <20031027044204.GA23976@merlin.emma.line.org>
In-Reply-To: <20031027044204.GA23976@merlin.emma.line.org>
Content-Type: multipart/mixed;
 boundary="------------090109030006040908080703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090109030006040908080703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthias Andree wrote:
> Doing cat /proc/bus/pnp/escd on my Linux 2.6 (BK) crashes:
> 
> Unable to handle kernel paging request at virtual address ffffa00a
>  printing eip:
> 00007228
> *pde = 00002067
> *pte = 00000000
> Oops: 0000 [#2]
> CPU:    0
> EIP:    0098:[<00007228>]    Not tainted
> EFLAGS: 00010086
> EIP is at 0x7228
> eax: 000022ff   ebx: 00b06196   ecx: 000000a0   edx: 00000000
> esi: 0000000a   edi: d1e70000   ebp: d1e773cf   esp: d1e79e64
> ds: 00b0   es: 00a8   ss: 0068
> Process cat (pid: 23647, threadinfo=d1e78000 task=c43f6c80)
> Stack: 000a0002 00b00000 000600a8 73d9720a 00000000 5f0a00a0 61af9e98 007b0000 
>        8000007b 60040000 008200a8 d1e79eec 0090000b 00000042 00b000a8 000000a0 
>        00000000 c0220c50 00000060 00000082 00000000 00000000 0000007b 0000007b 
> Call Trace:
>  [<c0220c50>] __pnp_bios_read_escd+0x110/0x1a0
>  [<c0222080>] proc_read_escd+0x0/0x130
>  [<c0220cf9>] pnp_bios_read_escd+0x19/0x50
>  [<c0222080>] proc_read_escd+0x0/0x130
>  [<c02220ea>] proc_read_escd+0x6a/0x130
>  [<c0222080>] proc_read_escd+0x0/0x130
>  [<c018896e>] proc_file_read+0x16e/0x290
>  [<c0157e63>] vfs_read+0xd3/0x140
>  [<c015811f>] sys_read+0x3f/0x60
>  [<c010a41b>] syscall_call+0x7/0xb
> 
> Willing to provide further debug info, please send directions. This is
> an old Gigabyte 7ZX-R board (AMIBIOS).
> 

Does this patch fix it?

--
				Brian Gerst

--------------090109030006040908080703
Content-Type: text/plain;
 name="pnpsegs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpsegs-1"

diff -urN linux-2.6.0-test9-bk/arch/i386/mm/extable.c linux/arch/i386/mm/extable.c
--- linux-2.6.0-test9-bk/arch/i386/mm/extable.c	2003-07-27 13:11:40.000000000 -0400
+++ linux/arch/i386/mm/extable.c	2003-10-27 12:08:38.000000000 -0500
@@ -34,7 +34,7 @@
 	const struct exception_table_entry *fixup;
 
 #ifdef CONFIG_PNPBIOS
-	if (unlikely((regs->xcs | 8) == 0x88)) /* 0x80 or 0x88 */
+	if (unlikely((unsigned)(regs->xcs - (GDT_ENTRY_PNPBIOS_BASE * 8)) < 16))
 	{
 		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
 		extern u32 pnp_bios_is_utter_crap;

--------------090109030006040908080703--

