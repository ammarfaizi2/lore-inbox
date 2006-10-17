Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWJQMbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWJQMbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWJQMbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:31:31 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:11684 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1750796AbWJQMba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:31:30 -0400
Date: Tue, 17 Oct 2006 16:33:07 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Prarit Bhargava <prarit@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] ->signal->tty locking
Message-ID: <20061017123307.GA209@oleg>
References: <1160992420.22727.14.camel@taijtu> <20061017081018.GA115@oleg> <1161080221.3036.38.camel@taijtu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161080221.3036.38.camel@taijtu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17, Peter Zijlstra wrote:
>
> On Tue, 2006-10-17 at 12:10 +0400, Oleg Nesterov wrote:
> > 
> > We don't need lock_task_sighand() here, we can use spin_lock_irq(->siglock).
> > 
> > We are holding tasklist_lock. This means that all tasks found by
> > do_each_task_pid() have a valid ->signal/->sighand != NULL.
> > tasklist_lock protects against release_task()->__exit_signal() and
> > from changing ->sighand by de_thread().
> 
> I think sys_unshare() spoils the game here; it changes ->sighand in
> midair without holding tasklist_lock. So any ->sighand but current's is
> fair game.
> 
> Hmm, either sys_unshare() is broken in that it doesn't take the
> tasklist_lock or a lot of other code is broken.

Yes, it is broken, please look at
	http://marc.theaimsgroup.com/?t=114253118100003

I sent a patch,
	http://marc.theaimsgroup.com/?l=linux-kernel&m=114268787415193

but it was ignored. Probably I should re-send it.

> Right, use tty_mutex when using the tty, use ->sighand when changing
> signal->tty.

I think that things like do_task_stat()/do_acct_process() do not need
global tty_mutex, they can use ->siglock.

Oleg.

