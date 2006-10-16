Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWJPNje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWJPNje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWJPNje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:39:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62119 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750747AbWJPNjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:39:33 -0400
Message-ID: <45338B92.9000201@redhat.com>
Date: Mon, 16 Oct 2006 09:39:30 -0400
From: Prarit Bhargava <prarit@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] ->signal->tty locking
References: <1160992420.22727.14.camel@taijtu>
In-Reply-To: <1160992420.22727.14.camel@taijtu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Zijlstra wrote:
> Oleg wrote:
> "Historically ->signal/->sighand (both ptrs and their contents) were globally
> protected by tasklist_lock. 'current' can use these pointers lockless, they
> can't be changed under him.
>
> Nowadays ->signal/->sighand are _also_ protected by ->sighand->siglock.
> Unless you are current, you can't lock ->siglock directly (without holding
> tasklist_lock), you should use lock_task_sighand()."
>
> Then, to be consistent with the rest of the kernel, ->signal->tty
> locking should look like so:
>
>   mutex_lock(&tty_mutex)
>     read_lock(&tasklist_lock)
>       lock_task_sighand(p, &flags)
>   

It would be nice if we could clean up some of the complicated locking in 
this code.  For example, from do_tty_hangup,

 *
 *      Locking:
 *              BKL
 *              redirect lock for undoing redirection
 *              file list lock for manipulating list of ttys
 *              tty_ldisc_lock from called functions
 *              termios_sem resetting termios data
 *              tasklist_lock to walk task list for hangup event

P.

