Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTFOAgo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 20:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTFOAgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 20:36:44 -0400
Received: from mail.ccur.com ([208.248.32.212]:780 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261568AbTFOAgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 20:36:43 -0400
Date: Sat, 14 Jun 2003 20:50:20 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Lars Unin <lars_unin@linuxmail.org>
Cc: hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: kernel spinlocks; when to use; when appropriate?
Message-ID: <20030615005020.GA16776@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20030614164144.8583.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030614164144.8583.qmail@linuxmail.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I wrote a while ago (thanks to you guys on LKML I almost 
> understand now):

I missed the start of this thread, so forgive me if I state what was
stated before.

Use semaphores when the average hold time will be much longer than
two context switches, spinlocks for everything else.  Semaphores when
contended force the process to go to sleep (one context switch), later,
the process will be switched back in when it gets the semaphore (another
context switch).  This double context switch takes a fixed amount of
time and if you can get through your critical region much faster than
that fixed time, then it should be protected by a spinlock.

There are places where you have to use spinlocks irrespective of the
above: when in interrupt code (where sleeping is not allowed), and in
regions of code where some other spinlock is held (where sleeping is also
not allowed).  The latter is especially insideous -- the more kernel
code protected by spinlocks, the more likely those existing spinlocks
will force new code to have to use spinlocks instead of semaphores.

Joe
