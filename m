Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUCAKzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUCAKzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:55:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:55425 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261203AbUCAKz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:55:26 -0500
Date: Mon, 1 Mar 2004 02:56:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [start_kernel] Suggest to move parse_args() before trap_init()
Message-Id: <20040301025637.338f41cf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0403011721220.2367-100000@mazda.sh.intel.com>
References: <Pine.LNX.4.44.0403011721220.2367-100000@mazda.sh.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhu, Yi" <yi.zhu@intel.com> wrote:
>
> I'm not sure it is _correct_ to move parse_args() before trap_init() in
>  start_kernel(). Is there any potencial dependencies? I did this on my P4 UP
>  box, it boots OK.
> 
>  My issue is if the parse_args() runs after trap_init(), the kernel
>  parameter "lapic" and "nolapic" takes no effect. Because lapic_enable()
>  is called after init_apic_mappings().
> 
> 
>  --- init/main.c.orig    2004-03-01 16:54:23.000000000 +0800
>  +++ init/main.c 2004-03-01 16:54:45.000000000 +0800
>  @@ -416,11 +416,11 @@
> 
>          build_all_zonelists();
>          page_alloc_init();
>  -       trap_init();
>          printk("Kernel command line: %s\n", saved_command_line);
>          parse_args("Booting kernel", command_line, __start___param,
>                     __stop___param - __start___param,
>                     &unknown_bootoption);
>  +       trap_init();
>          sort_main_extable();
>          rcu_init();
>          init_IRQ();

I think the only problem with this is if we get a fault during
parse_args(), the kernel flies off into outer space.  So you lose some
debuggability when using an early console.

But 2.4 does trap_init() after parse_args() and nobody has complained, as
did 2.6 until recently.  So the change is probably OK.

