Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbTC3RBz>; Sun, 30 Mar 2003 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbTC3RBz>; Sun, 30 Mar 2003 12:01:55 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:35970 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261498AbTC3RBz>;
	Sun, 30 Mar 2003 12:01:55 -0500
Date: Sun, 30 Mar 2003 19:12:57 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Andrew Morton <akpm@digeo.com>, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - New OOPS w/ timer
Message-ID: <20030330171257.GC26557@vana.vc.cvut.cz>
References: <000b01c2f6d6$f843eab0$030aa8c0@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c2f6d6$f843eab0$030aa8c0@unknown>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 11:10:48AM -0500, Shawn Starr wrote:
> Function found was: delayed_work_timer_fn (kernel/workqueue.c)
> 
> free of pending timer at c7411150
> function=c0138ba0
> Call Trace:
>  [<c014d4b4>] timer_hunt+0x84/0x90
>  [<c0138ba0>] delayed_work_timer_fn+0x0/0x170
>  [<c014fb08>] kfree+0x1c8/0x320
>  [<c024f8a6>] release_dev+0x696/0x840
>  [<c024f8a6>] release_dev+0x696/0x840

drivers/char/tty_io.c schedules flush_to_ldisc work. This
work can potentially reschedule itself, making call to
flush_scheduled_work() at the end of release_dev()
useless :-( 

Unfortunately I have no idea what is that code trying to do -
we already did tty->ldisc.close() and replaced
tty->ldisc with something else when we call flush_scheduled_work(),
so I doubt that work we are waiting for can do anything
useful even if TTY_DONT_FLIP is not set...
					Petr Vandrovec
					vandrove@vc.cvut.cz

