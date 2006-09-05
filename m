Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWIEXT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWIEXT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 19:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWIEXT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 19:19:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56502 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932212AbWIEXT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 19:19:57 -0400
Date: Tue, 5 Sep 2006 19:19:42 -0400
From: Alan Cox <alan@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       alan@redhat.com, arjan@linux.intel.com, viro@zeniv.linux.org.uk
Subject: Re: + audit-accounting-tty-locking.patch added to -mm tree
Message-ID: <20060905231942.GA10997@devserv.devel.redhat.com>
References: <200609052013.k85KDRWx010062@shell0.pdx.osdl.net> <20060905230753.GA613@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905230753.GA613@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 03:07:53AM +0400, Oleg Nesterov wrote:
> Nowadays ->signal/->sighand are _also_ protected by ->sighand->siglock.
> Unless you are current, you can't lock ->siglock directly (without holding
> tasklist_lock), you should use lock_task_sighand().

Gack, that makes current controlling tty locking horrible (and wrong almost
everywhere still across a clone)

> tty_io.c:
> 	->tty is set under task_lock()
> 
> 	->tty is cleared under lock_kernel() + tasklist_lock
> 
> 	except TIOCNOTTY, cleared under task_lock()
> 
> Note that include/linux/sched.h doesn't document that ->alloc_lock
> protects ->tty, it is only used in tty_io.c for that purpose, why?

Work in progress

> Btw, I think tiocsctty()/tty_open() is racy wrt to sys_setsid().
> tiocsctty() can see the result of '->signal->leader = 1' before
> sys_setsid() changed ->session/->pgrp and passed '->tty = NULL'.

Correct. I'm doing them bit by bit as I unpick them and check they
don't deadlock. If we need to take task_lock as well then its time
for set_controlling_tty() to get added.

Thanks for the signal lock explanation though. Now I've more idea wtf
is going on below the tty layer


