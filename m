Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUBNIVW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 03:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUBNIVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 03:21:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:21444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261188AbUBNIVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 03:21:18 -0500
Date: Sat, 14 Feb 2004 00:21:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael D'Halleweyn (List)" <list@noduck.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-Id: <20040214002148.77237320.akpm@osdl.org>
In-Reply-To: <1076729590.30432.4.camel@bigboy>
References: <1076729590.30432.4.camel@bigboy>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael D'Halleweyn (List)" <list@noduck.net> wrote:
>
> I sometimes get the following BUG (transcribed from a digital camera
>  snapshot, so it might contain errors). I did not copy the stack trace,
>  let me know if you want it.
> 
>  kernel BUG at kernel/timer.c:370!
>  invalid operand: 0000 [#1]
>  CPU:    0
>  EIP:    0060:[<c01284f8>]    Not tainted
>  EFLAGS: 00010003
>  EIP is at cascade+0x50/0x70
>  eax: d0a77724   ebx: d0a77724   ecx: c04aaa28   edx: 0000001c
>  esi: c04aab08   edi: c04aa220   ebp: 0000001c   esp: c0457e9e
>  ds: 007b   es: 007b   ss: 0068
>  Process swapper (pid: 0, threadinfo=c0456000 task=c03d2de0)
>  Stack: ...
>  Call Trace:
>   [<c01289e4>] update_process_times+0x44/0x50
>   [<c0128b3f>] run_timer_softirq+0x12f/0x1c0
>   [<c0124695>] do_softirq+0x95/0xa0
>   [<c010d2fb>] do_IRQ+0xfb/0x130
>   [<c010b5e8>] common_interrupt+0x18/0x20

This could be a hardware problem.  Or it could be a bug basically anywhere
in the kernel.

Are you using CONFIG_DEBUG_SLAB?

Could you please apply the below patch, wait for the problem to reoccur,
then let us know?

diff -puN kernel/timer.c~a kernel/timer.c
--- 25/kernel/timer.c~a	2004-02-14 00:14:46.000000000 -0800
+++ 25-akpm/kernel/timer.c	2004-02-14 00:20:09.000000000 -0800
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/kallsyms.h>
 
 #include <asm/uaccess.h>
 #include <asm/div64.h>
@@ -367,7 +368,15 @@ static int cascade(tvec_base_t *base, tv
 		struct timer_list *tmp;
 
 		tmp = list_entry(curr, struct timer_list, entry);
-		BUG_ON(tmp->base != base);
+		if (tmp->base != base) {
+			printk("%s: %p != %p\n",
+				__FUNCTION__, tmp->base, base);
+			printk("handler=%p", tmp->function);
+			print_symbol(" (%s)", (unsigned long)tmp->function);
+			printk("\n");
+			dump_stack();
+			tmp->base = base;
+		}
 		curr = curr->next;
 		internal_add_timer(base, tmp);
 	}

_


