Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275324AbTHSDYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 23:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275320AbTHSDY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 23:24:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:47536 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275319AbTHSDYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 23:24:24 -0400
Message-ID: <32789.4.4.25.4.1061263463.squirrel@www.osdl.org>
Date: Mon, 18 Aug 2003 20:24:23 -0700 (PDT)
Subject: Re: Debug: sleeping function called from invalid context
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <akpm@osdl.org>
In-Reply-To: <20030818171545.5aa630a0.akpm@osdl.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org>
        <20030815173246.GB9681@redhat.com>
        <20030815123053.2f81ec0a.rddunlap@osdl.org>
        <20030816070652.GG325@waste.org>
        <20030818140729.2e3b02f2.rddunlap@osdl.org>
        <20030819001316.GF22433@redhat.com>
        <20030818171545.5aa630a0.akpm@osdl.org>
X-Priority: 3
Importance: Normal
Cc: <davej@redhat.com>, <mpm@selenic.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dave Jones <davej@redhat.com> wrote:
>>
>> How spooky. now I got one too, (minus the noise).
>>
>> Call Trace:
>>  [<c0120022>] __might_sleep+0x5b/0x5f
>
> It would be useful to know whether this was triggered by in_atomic() or by
> irqs_disabled().  We're suspecting the latter.
>
>
> diff -puN kernel/sched.c~might_sleep-diags kernel/sched.c
> --- 25/kernel/sched.c~might_sleep-diags	Mon Aug 18 14:09:41 2003
> +++ 25-akpm/kernel/sched.c	Mon Aug 18 14:11:55 2003
> @@ -2795,13 +2795,19 @@ void __might_sleep(char *file, int line)
>  {
>  #if defined(in_atomic)
>  	static unsigned long prev_jiffy;	/* ratelimiting */
> +	char *msg = NULL;
>
> -	if (in_atomic() || irqs_disabled()) {
> +	if (in_atomic())
> +		msg = "in atomic section";
> +	else if (irqs_disabled())
> +		msg = "with interrupts disabled";
> +
> +	if (msg) {
>  		if (time_before(jiffies, prev_jiffy + HZ))
>  			return;
>  		prev_jiffy = jiffies;
> -		printk(KERN_ERR "Debug: sleeping function called from invalid"
> -				" context at %s:%d\n", file, line);
> +		printk(KERN_ERR "Debug: sleeping function "
> +				"called %s at %s:%d\n", msg, file, line);
>  		dump_stack();
>  	}
>  #endif

Took 5 tries of loading X to get it, and you got it.
(I'm using VGA_CONSOLE.)

Debug: sleeping function called with interrupts disabled at
include/asm/uaccess.h:473
Call Trace:
 [<c0120d93>] __might_sleep+0x53/0x74
 [<c010d001>] save_v86_state+0x71/0x1f0
 [<c010dbd5>] handle_vm86_fault+0xc5/0xa90
 [<c019cac8>] ext3_file_write+0x28/0xc0
 [<c011cd96>] __change_page_attr+0x26/0x220
 [<c010b310>] do_general_protection+0x0/0x90
 [<c010a69d>] error_code+0x2d/0x40
 [<c0109657>] syscall_call+0x7/0xb

~Randy



