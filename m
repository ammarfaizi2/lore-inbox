Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUAHX6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUAHX6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:58:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:35008 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265045AbUAHX6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:58:34 -0500
Date: Thu, 8 Jan 2004 15:59:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: ramon.rey@hispalinux.es
Cc: ramon.rey@augcyl.org, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [2.6.1-rc2-mm1][BUG] Badness in unblank_screen at
 drivers/char/vt.c:2793
Message-Id: <20040108155940.68ab047a.akpm@osdl.org>
In-Reply-To: <1073605532.1070.6.camel@debian>
References: <1073605532.1070.6.camel@debian>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramon Rey Vicente <ramon.rey@augcyl.org> wrote:
>
> ...
> Jan  8 23:12:29 debian kernel: Badness in unblank_screen at drivers/char/vt.c:2793
> Jan  8 23:12:29 debian kernel: Call Trace:
> Jan  8 23:12:29 debian kernel:  [unblank_screen+250/288] unblank_screen+0xfa/0x120
> Jan  8 23:12:29 debian kernel:  [bust_spinlocks+37/96] bust_spinlocks+0x25/0x60
> Jan  8 23:12:29 debian kernel:  [die+120/224] die+0x78/0xe0
> Jan  8 23:12:29 debian kernel:  [do_invalid_op+145/160] do_invalid_op+0x91/0xa0
> Jan  8 23:12:29 debian kernel:  [try_to_unmap_one+456/480] try_to_unmap_one+0x1c8/0x1e0
> Jan  8 23:12:29 debian kernel:  [slab_destroy+170/256] slab_destroy+0xaa/0x100
> Jan  8 23:12:29 debian kernel:  [free_pages_bulk+350/640] free_pages_bulk+0x15e/0x280
> Jan  8 23:12:29 debian kernel:  [free_hot_cold_page+224/256] free_hot_cold_page+0xe0/0x100
> Jan  8 23:12:29 debian kernel:  [error_code+47/64] error_code+0x2f/0x40
> Jan  8 23:12:29 debian kernel:  [try_to_unmap_one+456/480] try_to_unmap_one+0x1c8/0x1e0
> Jan  8 23:12:29 debian kernel:  [try_to_unmap+322/384] try_to_unmap+0x142/0x180
> Jan  8 23:12:29 debian kernel:  [shrink_list+579/1408] shrink_list+0x243/0x580
> Jan  8 23:12:29 debian kernel:  [do_timer+197/224] do_timer+0xc5/0xe0
> Jan  8 23:12:29 debian kernel:  [do_softirq+140/160] do_softirq+0x8c/0xa0
> Jan  8 23:12:29 debian kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> Jan  8 23:12:29 debian kernel:  [__pagevec_release+24/64] __pagevec_release+0x18/0x40
> Jan  8 23:12:29 debian kernel:  [shrink_cache+409/864] shrink_cache+0x199/0x360
> Jan  8 23:12:29 debian kernel:  [shrink_zone+107/128] shrink_zone+0x6b/0x80
> Jan  8 23:12:29 debian kernel:  [balance_pgdat+359/480] balance_pgdat+0x167/0x1e0
> Jan  8 23:12:29 debian kernel:  [kswapd+254/288] kswapd+0xfe/0x120
> Jan  8 23:12:29 debian kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
> Jan  8 23:12:29 debian kernel:  [ret_from_fork+6/32] ret_from_fork+0x6/0x20
> Jan  8 23:12:29 debian kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
> Jan  8 23:12:29 debian kernel:  [kswapd+0/288] kswapd+0x0/0x120
> Jan  8 23:12:29 debian kernel:  [kernel_thread_helper+5/36] kernel_thread_helper+0x5/0x24
> Jan  8 23:12:29 debian kernel: 
> Jan  8 23:12:29 debian kernel:  <6>note: kswapd0[8] exited with preempt_count 1
> 

Ben, your debug stuff tripped up when we were oopsing.  bust_spinlocks()
calls unblank_screen() without console_sem.  I'll change it to

	WARN_ON(!is_console_locked() && !oops_in_progress);

(Weren't you going to update that patch anyway?)

As for the oops itself: 2.6.1-rc2-mm1 VM is kaput, sorry.  It works OK here
without the fremap changes.

