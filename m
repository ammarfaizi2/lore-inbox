Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTJRSV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTJRSV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:21:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:30345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261939AbTJRSVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:21:55 -0400
Date: Sat, 18 Oct 2003 11:22:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olivier NICOLAS <olivn@trollprod.org>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.0-test8: panic on boot
Message-Id: <20031018112217.19841708.akpm@osdl.org>
In-Reply-To: <3F917EFC.7020102@trollprod.org>
References: <3F917EFC.7020102@trollprod.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier NICOLAS <olivn@trollprod.org> wrote:
>
>  NULL pointer dereference at virtual address 00000004
>    printing eip:
>  c01de05e
>  *pde = 00000000
>  Oops: 0000 [#1]
>  CPU:    0
>  EIP:    0060:[<c01de05e>]    Not tainted
>  EFLAGS: 00010213
>  EIP is at vsnprintf+0x28e/0x4e0
>  eax: 00000004   ebx: 0000000a   ecx: 00000004   edx: 00000003
>  esi: c03efae7   edi: ffffffff   ebp: 00000000   esp: c114bac0
>  ds: 007b   es: 007b   ss: 0068
>  Process swapper (pid: 1, threadinfo=c114a000 task=c117b8c0)
>  Stack: c114bb08 ffffffff 000004a0 00000000 0000000a ffffffff 00000003 
>  00000002
>          00000004 00000004 ffffffff 00000001 c114bb68 c7f02c48 c7f02ee8 
>  c01de307
>          c03efac0 3fc10540 c03292ea c114bb60 c01e6579 c03efac0 c03292c0 
>  c114bb54
>  Call Trace:
>    [<c01de307>] vsprintf+0x27/0x30
>    [<c01e6579>] acpi_os_vprintf+0x12/0x2a
>    [<c020992b>] acpi_ut_debug_print+0x97/0x9d
>    [<c01e91d2>] acpi_ds_init_buffer_field+0x18d/0x20c
>    [<c01e93ac>] acpi_ds_eval_buffer_field_operands+0x15b/0x17d
>    [<c01e9f8f>] acpi_ds_exec_end_op+0x22c/0x409

Well clearly one of the strings in this debug message in
acpi_ds_init_buffer_field() is null:

	/* Entire field must fit within the current length of the buffer */

	if ((bit_offset + bit_count) >
		(8 * (u32) buffer_desc->buffer.length)) {
		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,
			"Field [%4.4s] size %d exceeds Buffer [%4.4s] size %d (bits)\n",



It is perhaps desirable to make printk() a bit more robust about this sort
of thing.


diff -puN lib/vsprintf.c~printk-handle-bad-pointers lib/vsprintf.c
--- 25/lib/vsprintf.c~printk-handle-bad-pointers	2003-10-18 11:19:05.000000000 -0700
+++ 25-akpm/lib/vsprintf.c	2003-10-18 11:19:25.000000000 -0700
@@ -348,7 +348,7 @@ int vsnprintf(char *buf, size_t size, co
 
 			case 's':
 				s = va_arg(args, char *);
-				if (!s)
+				if ((unsigned long)s < PAGE_SIZE)
 					s = "<NULL>";
 
 				len = strnlen(s, precision);

_

