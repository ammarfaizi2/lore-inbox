Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275425AbTHIWpS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 18:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275426AbTHIWpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 18:45:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:11938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275425AbTHIWpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 18:45:14 -0400
Date: Sat, 9 Aug 2003 15:45:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "S.Coffin" <scoffin@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repeatable hard crash with 2.6.0.test[123]
Message-Id: <20030809154517.599b3de8.akpm@osdl.org>
In-Reply-To: <200308091912.h79JC8dl001879@yawn.gv.com>
References: <200308091912.h79JC8dl001879@yawn.gv.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"S.Coffin" <scoffin@comcast.net> wrote:
>
>         (unknown output at beginning)
>  [<c01cb601>] exit_io_context+0x21/0x90
>  [<c011a717>] printk+0x107/0x140
>  [<c011bd02>] do_exit+0x42/0x2e0
>  [<c011bd02>] do_divide_error+0x0/0x100
>  [<c0115bd7>] do_page_fault+0x277/0x43e
>  [<c0115960>] do_page_fault+0x010/0x43e
>  [<c0109155>] error_code+0x2d/0x38
>          (repeat about 1000 times)

Looks like you're getting recursive oopses.

Please apply this patch, see if you can capture a decent trace.

 arch/i386/kernel/traps.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/i386/kernel/traps.c~a arch/i386/kernel/traps.c
--- 25/arch/i386/kernel/traps.c~a	2003-08-09 15:43:15.000000000 -0700
+++ 25-akpm/arch/i386/kernel/traps.c	2003-08-09 15:43:53.000000000 -0700
@@ -270,6 +270,8 @@ void die(const char * str, struct pt_reg
 		schedule_timeout(5 * HZ);
 		panic("Fatal exception");
 	}
+	for ( ; ; )
+		schedule();
 	do_exit(SIGSEGV);
 }
 

_

If it still screws up, try just making it:

	for ( ; ; )
		;

(ie: remove the "schedule()").

Thanks.
