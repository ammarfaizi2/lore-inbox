Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbVKYTsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVKYTsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVKYTsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:48:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33191 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751469AbVKYTsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:48:30 -0500
Date: Fri, 25 Nov 2005 11:47:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: linux-kernel@vger.kernel.org, Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [BUG linux-2.6.15-rc] process events connector - soft lockup
 detected
Message-Id: <20051125114741.6549ef3a.akpm@osdl.org>
In-Reply-To: <20051125144226.37778246@frecb000711.frec.bull.fr>
References: <20051125144226.37778246@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
> Hello,
> 
>   I compiled a kernel 2.6.15-rc1 and a 2.6.15-rc2 with Process Events
> Connector enabled. The machine has two processors. When I use the
> process events connector, a soft lockup is detected (for both releases):
> 
> ---------B<---------------------------------------
> Pid: 2770, comm:                   sh
> EIP: 0060:[<c039ae28>] CPU: 1
> EIP is at __read_lock_failed+0x8/0x14
>  EFLAGS: 00000297    Not tainted  (2.6.15-rc2)
> EAX: c046fc00 EBX: f5946000 ECX: f5947f7c EDX: 00000286
> ESI: 00000000 EDI: ffffffff EBP: f5946000 DS: 007b ES: 007b
> CR0: 8005003b CR2: 080e173c CR3: 358a0000 CR4: 000006d0
>  [<c039c566>] _read_lock+0xb/0xc
>  [<c011e7ee>] do_wait+0x9d/0x40c
>  [<c0116fd0>] default_wake_function+0x0/0x12
>  [<c0116fd0>] default_wake_function+0x0/0x12
>  [<c011ec32>] sys_wait4+0x43/0x45
>  [<c0102e39>] syscall_call+0x7/0xb
> BUG: soft lockup detected on CPU#1!
> 
> ...
>
>   I think that the problem is in kernel/fork.c. The function
> proc_fork_connector(p) is called inside a
> write_lock_irq(&tasklist_lock). The
> cn_netlink_send(msg,CN_IDX_PROC,GFP_KERNEL) is called by the
> proc_fork_connector(). Thus, the alloc_skb(size,GFP_KERNEL) is called
> within a write_lock_irq(&tasklist_lock)... is it the problem? 
> 
>   If I replace GFP_KERNEL by GFP_ATOMIC the soft lockup disappear (but I
> don't know if this solution is right...)

Gad, how ddd that get in there?

--- devel/kernel/fork.c~forkc-proc_fork_connector-called-under-write_lock	2005-11-25 11:46:36.000000000 -0800
+++ devel-akpm/kernel/fork.c	2005-11-25 11:46:36.000000000 -0800
@@ -1135,13 +1135,13 @@ static task_t *copy_process(unsigned lon
 			__get_cpu_var(process_counts)++;
 	}
 
-	proc_fork_connector(p);
 	if (!current->signal->tty && p->signal->tty)
 		p->signal->tty = NULL;
 
 	nr_threads++;
 	total_forks++;
 	write_unlock_irq(&tasklist_lock);
+	proc_fork_connector(p);
 	retval = 0;
 
 fork_out:
_


