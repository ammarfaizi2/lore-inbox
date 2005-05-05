Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVEENsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVEENsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 09:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVEENsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 09:48:32 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:10143 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262108AbVEENs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 09:48:27 -0400
Subject: Re: A patch for the file kernel/fork.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org, cw@f00f.org, andre@cachola.com.br,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1115241687.2562.50.camel@localhost.localdomain>
References: <4278E03A.1000605@cachola.com.br>
	 <20050504175457.GA31789@taniwha.stupidest.org>
	 <427913E4.3070908@cachola.com.br>
	 <20050504184318.GA644@taniwha.stupidest.org>
	 <42791CD2.5070408@cachola.com.br>
	 <1115234213.2562.28.camel@localhost.localdomain>
	 <20050504124104.3573e7f3.akpm@osdl.org>
	 <1115241687.2562.50.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 05 May 2005 09:48:07 -0400
Message-Id: <1115300887.21180.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-04 at 23:21 +0200, Alexander Nyberg wrote:

> This patch is very crude but it is quite resistant to recursive faults
> in do_exit(), survives the LTP hammering I've given it. The problem is
> not knowing where in the previous path it broke down so I'd rather just
> leave it lying around and try a graceful reset/power off. But if anyone
> has a better suggestion than the msleep() I'm all ears but this area is
> sensitive.
> 
> Where is that anonymous patch hot-line...
> 

> +	/* We're taking recursive faults originating here in do_exit. Safest 
> +	 * is to just leave this task alone and wait for reboot. */
> +	if (tsk->flags & PF_EXITING) {
> +		printk(KERN_ALERT "\nFixing recursive fault but reboot is needed!\n");
> +		for (;;)
> +			msleep(1000 * 10);
> +	}
> +
>  	tsk->flags |= PF_EXITING;
>  

Instead of the for(;;) msleep, why not just take it permanently off the
run queue? With the following:

   set_current_state(TASK_UNINTERRUPTIBLE);
   schedule();

It basically gives the same effect, but is cleaner.

-- Steve


