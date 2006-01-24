Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbWAXNdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbWAXNdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 08:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbWAXNdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 08:33:12 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:40011 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030479AbWAXNdM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 08:33:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nI9VQSPtp++3/PBEmass/At7hYX7n03W2JHvEsCiRqLexd1C3XbbB9RzroivW/rNhZ/538xs/EdpzybN0iJ577bJA/VdIlbhiAam+HY9vsrhsTM/6/8ZA/GUL7iSxqMxG45r+ESmMeUDG1jOmc7TJib7Bpw+qlODSXfn+yeaOtM=
Message-ID: <6bffcb0e0601240533h3ba1a01ci@mail.gmail.com>
Date: Tue, 24 Jan 2006 14:33:11 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] kstopmachine has legit preempt_enable_no_resched (was: 2.6.15-rt12 bugs)
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1138065822.6695.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
	 <1138065822.6695.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/01/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> Here Ingo,
>
> The kstop_machine has a legitimate preempt_enable_no_resched.
>
> -- Steve
>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>
> Index: linux-2.6.15-rt12/kernel/stop_machine.c
> ===================================================================
> --- linux-2.6.15-rt12.orig/kernel/stop_machine.c        2006-01-23 09:15:37.000000000 -0500
> +++ linux-2.6.15-rt12/kernel/stop_machine.c     2006-01-23 19:58:26.000000000 -0500
> @@ -134,7 +134,7 @@
>  {
>         stopmachine_set_state(STOPMACHINE_EXIT);
>         raw_local_irq_enable();
> -       preempt_enable_no_resched();
> +       __preempt_enable_no_resched();
>  }
>
>  struct stop_machine_data
>
>
>

Great thanks!

Now 2.6.15-rt14 works fine (after disabling CONFIG_DEBUG_STACKOVERFLOW).

I have noticed only one warning
WARNING: softirq-tasklet/8 changed soft IRQ-flags.
 [<c0103b1b>] dump_stack+0x1b/0x1f (20)
 [<c0135218>] illegal_API_call+0x41/0x46 (20)
 [<c0135267>] local_irq_disable+0x1d/0x1f (8)
  [<f886dbd5>] skge_extirq+0x117/0x138 [skge] (32)
 [<c01202d5>] tasklet_action+0x8a/0xf1 (24)
  [<c01205c1>] ksoftirqd+0x10f/0x19e (32)
  [<c012d7ca>] kthread+0x7b/0xa9 (36)
 [<c01010c5>] kernel_thread_helper+0x5/0xb (1047875612)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (softirq-tasklet/8 [c18a97d0,  98]):
------------------------------

And problems while loading ipv6 module
Running ntpdate to synchronize clockCould not allocate 4 bytes percpu data
modprobe: FATAL: Error inserting ipv6
(/lib/modules/2.6.15-rt14/kernel/net/ipv6/ipv6.ko): Cannot allocate
memory

Could not allocate 4 bytes percpu data
modprobe: FATAL: Error inserting ipv6
(/lib/modules/2.6.15-rt14/kernel/net/ipv6/ipv6.ko): Cannot allocate
memory

Here is my dmesg:
http://www.stardust.webpages.pl/files/rt/2.6.15-rt14/rt-dmesg
Here is my config:
http://www.stardust.webpages.pl/files/rt/2.6.15-rt14/rt-config

Regards,
Michal Piotrowski
