Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVCGDds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVCGDds (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 22:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVCGDds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 22:33:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:45954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261489AbVCGDdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 22:33:07 -0500
Date: Sun, 6 Mar 2005 19:32:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
Subject: Re: [patch 05/14] char/hvsi: use wait_event_timeout()
Message-Id: <20050306193236.1dd2b3de.akpm@osdl.org>
In-Reply-To: <20050306223630.55D7C1ED3D@trashy.coderock.org>
References: <20050306223630.55D7C1ED3D@trashy.coderock.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> Please consider applying. This is my first wait-queue related patch, so comments
>  are very welcome.
> 
>  Use wait_event_timeout() in place of custom wait-queue code. The
>  code is not changed in any way (I don't think), but is cleaned up quite a bit
>  (will get expanded to almost identical code).
> 
> ...
>  diff -puN drivers/char/hvsi.c~wait_event_timeout-drivers_char_hvsi drivers/char/hvsi.c
>  --- kj/drivers/char/hvsi.c~wait_event_timeout-drivers_char_hvsi	2005-03-05 16:11:27.000000000 +0100
>  +++ kj-domen/drivers/char/hvsi.c	2005-03-05 16:11:27.000000000 +0100
>  @@ -44,6 +44,7 @@
>   #include <linux/sysrq.h>
>   #include <linux/tty.h>
>   #include <linux/tty_flip.h>
>  +#include <linux/wait.h>
>   #include <asm/hvcall.h>
>   #include <asm/hvconsole.h>
>   #include <asm/prom.h>
>  @@ -631,27 +632,10 @@ static int __init poll_for_state(struct 
>   /* wait for irq handler to change our state */
>   static int wait_for_state(struct hvsi_struct *hp, int state)
>   {
>  -	unsigned long end_jiffies = jiffies + HVSI_TIMEOUT;
>  -	unsigned long timeout;
>   	int ret = 0;
>   
>  -	DECLARE_WAITQUEUE(myself, current);
>  -	set_current_state(TASK_INTERRUPTIBLE);
>  -	add_wait_queue(&hp->stateq, &myself);
>  -
>  -	for (;;) {
>  -		set_current_state(TASK_INTERRUPTIBLE);
>  -		if (hp->state == state)
>  -			break;
>  -		timeout = end_jiffies - jiffies;
>  -		if (time_after(jiffies, end_jiffies)) {
>  -			ret = -EIO;
>  -			break;
>  -		}
>  -		schedule_timeout(timeout);
>  -	}
>  -	remove_wait_queue(&hp->stateq, &myself);
>  -	set_current_state(TASK_RUNNING);
>  +	if(!wait_event_timeout(hp->stateq, (hp->state == state), jiffies + HVSI_TIMEOUT))
>  +		ret = -EIO;

wait_event_timeout()'s `timeout' arg is number-of-milliseconds-to-wait,
not an absolute time, yes?

Also, it's conventional to put a space between the `if' and the `('.

It's nice to squeeze the code into an 80-column xterm, too.
