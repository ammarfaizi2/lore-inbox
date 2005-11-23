Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVKWTXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVKWTXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVKWTXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:23:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932209AbVKWTXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:23:00 -0500
Date: Wed, 23 Nov 2005 11:22:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@netfilter.org>,
       netdev@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
Message-Id: <20051123112218.73f68926.akpm@osdl.org>
In-Reply-To: <6bffcb0e0511230615y7531e268n@mail.gmail.com>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
	<6bffcb0e0511230615y7531e268n@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
>  Debug: sleeping function called from invalid context at
>  include/asm/semaphore.h:123
>  in_atomic():1, irqs_disabled():0
>   [<c0103be6>] dump_stack+0x17/0x19
>   [<c011a0c3>] __might_sleep+0x9c/0xae
>   [<fd9a090d>] translate_table+0x147/0xc14 [ip_tables]
>   [<fd9a2b2a>] ipt_register_table+0x93/0x20d [ip_tables]
>   [<f98fe027>] init+0x27/0x9e [iptable_filter]
>   [<c01376d0>] sys_init_module+0xd7/0x26c
>   [<c0102cc7>] sysenter_past_esp+0x54/0x75
>  ---------------------------
>  | preempt count: 00000001 ]
>  | 1 level deep critical section nesting:
>  ----------------------------------------
>  .. [<fd9a2aca>] .... ipt_register_table+0x33/0x20d [ip_tables]
>  .....[<f98fe027>] ..   ( <= init+0x27/0x9e [iptable_filter])
> 

ipt_register_table() does get_cpu() then calls translate_table(), and
somewhere under translate_table() we do something which sleeps, only I'm not
sure what it is - netfilter likes to hide things in unexpected places.

check_entry() will do sleepy things under that get_cpu(), but that doesn't
seem to be in this particular call chain.

Anyway, the new get_cpu() in ipt_register_table() is the problem.
