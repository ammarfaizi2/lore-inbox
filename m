Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWHSPTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWHSPTP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 11:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWHSPTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 11:19:15 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:8607 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751459AbWHSPTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 11:19:14 -0400
Date: Sat, 19 Aug 2006 23:43:13 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] for 2.6.18, revert "Drop tasklist lock in do_sched_setscheduler"
Message-ID: <20060819194313.GA9170@oleg>
References: <20060819193026.GA7449@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819193026.GA7449@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19, Oleg Nesterov wrote:
>
> sched_setscheduler() looks at ->signal->rlim[]. It is unsafe do dereference
> ->signal unless tasklist_lock or ->siglock is held (or p == current). We pin
> the task structure, but this can't prevent from release_task()->__exit_signal()
> which sets ->signal = NULL.

See the testcase below, 2.6.18-rc4 oopses. The stable tree is ok, the problem
was introduced during 2.6.18 development.

Oleg.

#!/usr/bin/perl

pipe R, W;

if (fork) {
	while (sysread R, $_, 4) {
		do {
			syscall 156, unpack('i', $_), 1, pack('i', 1);
		} while $! == 1; # EPERM
	}
} else {
	wait while fork;
	syswrite W, pack 'i', $$;
}

