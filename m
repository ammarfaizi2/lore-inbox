Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUC1RAV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUC1RAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:00:21 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:18953 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262017AbUC1RAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:00:16 -0500
To: "Andrew Reiter" <areiter@preventsys.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: NULL pointer in proc_pid_stat -- oops.
References: <8758F8D58219684FAB0239EE8967048A4A7D5E@calculon.preventsys.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 29 Mar 2004 02:00:03 +0900
In-Reply-To: <8758F8D58219684FAB0239EE8967048A4A7D5E@calculon.preventsys.com>
Message-ID: <873c7sewks.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrew Reiter" <areiter@preventsys.com> writes:

> 0x000004d4 <proc_pid_stat+124>: test   %ecx,%ecx
> 0x000004d6 <proc_pid_stat+126>: je     0x510 <proc_pid_stat+184>
> 0x000004d8 <proc_pid_stat+128>: mov    0x98(%ecx),%eax
> 0x000004de <proc_pid_stat+134>: mov    %eax,0x20(%esp,1)
> 0x000004e2 <proc_pid_stat+138>: mov    0x4(%ecx),%edx
> 0x000004e5 <proc_pid_stat+141>: movswl 0x64(%edx),%eax
> 0x000004e9 <proc_pid_stat+145>: movswl 0x66(%edx),%edx
> 0x000004ed <proc_pid_stat+149>: shl    $0x14,%eax
> 0x000004f0 <proc_pid_stat+152>: or     %edx,%eax
> 0x000004f2 <proc_pid_stat+154>: add    0x8(%ecx),%eax
> 
> And from the oops trace output (that is attached), we can see that %edx
> is 0x0; so we can easily see here why we're crashing at least.  After
> examining the C source, I see that we're dying in the call to
> task_name() (inline) from proc_pid_stat().

Looks like this problem is same with BSD acct Oops.

	if (task->tty) {
		tty_pgrp = task->tty->pgrp;
		tty_nr = new_encode_dev(tty_devnum(task->tty));
	}

Some place doesn't take the any lock for ->tty. I think we need to
take the lock for ->tty.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
