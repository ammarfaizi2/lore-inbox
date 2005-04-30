Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVD3MgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVD3MgI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 08:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVD3MgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 08:36:08 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:9907 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261209AbVD3Mfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 08:35:44 -0400
Message-ID: <42737D3A.ABEF2022@tv-sign.ru>
Date: Sat, 30 Apr 2005 16:42:34 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Maneesh Soni <maneesh@in.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Juergen Kreileder <jk@blackdown.de>
Subject: Re: Fw: [Bug 4559] New: cfq scheduler lockup: NMI oops while runningltp 
 - 20050207  on 2.6.12-rc2-mm3 with kdump enabled
References: <20050429000038.1da6f2e1.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
>  http://bugme.osdl.org/show_bug.cgi?id=4559
> 
> Timer bug, I guess.

Yes, the new timer code is racy. Example:

spinlock_t LOCK;

void void timer_func()
{
	spin_lock(&LOCK);
}

timer_list TIMER = TIMER_INITIALIZER(timer_func);

-------------------------------------------------------------------
CPU_0					CPU_1

					add_timer(&TIMER);
spin_lock(&LOCK);
					__run_timers:
						sets ->running_timer = &TIMER;
						calls timer_func()
							waits for &LOCK

__mod_timer(&TIMER);
	/* Ensure the timer is serialized. */
	retries while ->running_timer == &TIMER


Many thanks to Maneesh Soni for his excellent analysis in
http://bugme.osdl.org/show_bug.cgi?id=4559.

Note that del_timer_sync has this problem too, but this
situation is forbidden by synchronization rules.

At the moment I don't have a proper solution.

One option is to change __mod_timer() so that it would not
switch ->base when the timer is already running. But this
would be behavioural change: currently __mod_timer() guarantees
that the timer would be armed on the local cpu.

I'll try to find a solution, but perhaps it's better to drop
this patch for now.

Oleg.
