Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbUKRFCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbUKRFCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 00:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbUKRFCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 00:02:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:62414 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262553AbUKRFCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 00:02:34 -0500
Date: Wed, 17 Nov 2004 21:02:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: cliff white <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.10-rc1-mm5 - badness in enable_irg, BUG
Message-Id: <20041117210219.43a36302.akpm@osdl.org>
In-Reply-To: <20041115093759.721ac964.cliffw@osdl.org>
References: <20041115093759.721ac964.cliffw@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cliff white <cliffw@osdl.org> wrote:
>
> 
> 
> This is on the 2.6.10-rc1-mm5 kernel with one compile fix patch
> 
> Machines are the OSDl 2 and 4 CPU boxes. 
> Test is reaim with the 'new_fserver' workload. The 'compute' and 'database' workloads aren't 
> showing this.
> 
> I see the BUG on ext3, reiserfs, xfs and jfs. 
> 
> System usually completes the test run, and performance isn't off too much :)
> --------------------------------
> With ext3, get this at the start of the run 
> ( Full run at: http://khack.osdl.org/stp/298664 )
> ---------------------------------
>  kernel: Badness in enable_irq at kernel/irq/manage.c:106
>  kernel:  [<c013e6ac>] enable_irq+0xdc/0xf0
>  kernel:  [<c025e7fa>] e100_up+0x10a/0x200
>  kernel:  [<c025dbc0>] e100_intr+0x0/0x160
>  kernel:  [<c025fa51>] e100_open+0x31/0x80
>  kernel:  [<c02c9c4c>] dev_open+0x8c/0xa0
>  kernel:  [<c02cb49a>] dev_change_flags+0x12a/0x150
>  kernel:  [<c02c9aed>] dev_load+0x2d/0x80
>  kernel:  [<c0306de3>] devinet_ioctl+0x273/0x670
>  kernel:  [<c020a31e>] copy_to_user+0x3e/0x50
>  kernel:  [<c03093c6>] inet_ioctl+0x66/0xb0
>  kernel:  [<c02c0619>] sock_ioctl+0xc9/0x250
>  kernel:  [<c0170c8a>] sys_ioctl+0xca/0x230
>  kernel:  [<c0104681>] sysenter_past_esp+0x52/0x71

yeah, this is due to a known-to-be-dodgy e100 patch in -mm.

> ------------------------------------
> Then, when the test runs:
> -----------------------------------------
> BUG: using smp_processor_id() in preemptible [00000001] code: mkdir/11768
> caller is munmap_notify+0x7b/0x90 [oprofile]
>  [<c020a465>] smp_processor_id+0xb5/0xc0
>  [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
>  [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
>  [<c012b55d>] notifier_call_chain+0x2d/0x50
>  [<c011dd93>] profile_munmap+0x33/0x50
>  [<c01536f7>] sys_munmap+0x27/0x80
>  [<c01046d3>] syscall_call+0x7/0xb

ho hum, I guess we should suppress these oprofile warnings somehow.

Ingo, is there an smp_processor_id() variant which bypasses the warning?

btw, this:

#if !defined(__smp_processor_id) || !defined(CONFIG_PREEMPT)
# define smp_processor_id()			0
#endif
...
#endif /* !SMP */

#ifdef __smp_processor_id
# if defined(CONFIG_PREEMPT) && defined(CONFIG_DEBUG_PREEMPT)
  /*
   * temporary debugging check detecting places that use
   * smp_processor_id() in a potentially unsafe way:
   */
   extern unsigned int smp_processor_id(void);
# else
#  define smp_processor_id() __smp_processor_id()
# endif
# define _smp_processor_id() __smp_processor_id()
#else
# define _smp_processor_id() smp_processor_id()
#endif

is insane.   Any chance of simplifying it all?
