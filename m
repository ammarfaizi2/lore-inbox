Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTILT6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbTILT6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:58:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:33451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261812AbTILT6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:58:37 -0400
Date: Fri, 12 Sep 2003 12:40:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [PATCH 2/3] netpoll: netconsole
Message-Id: <20030912124027.76306077.akpm@osdl.org>
In-Reply-To: <20030912053335.GJ41254@gaz.sfgoth.com>
References: <20030910074256.GD4489@waste.org.suse.lists.linux.kernel>
	<p73znhdhxkx.fsf@oldwotan.suse.de>
	<20030910082435.GG4489@waste.org>
	<20030910082908.GE29485@wotan.suse.de>
	<20030910090121.GH4489@waste.org>
	<20030910160002.GB84652@gaz.sfgoth.com>
	<20030912053335.GJ41254@gaz.sfgoth.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr <mitch@sfgoth.com> wrote:
>
> Mitchell Blank Jr wrote:
> > The netconsole problem is only if the net driver calls printk() with
> > its spinlock held (but when not called from netconsole).  Then printk()
> > won't know that it's unsafe to re-enter the network driver.
> 
> BTW, this isn't neccesarily a netconsole-only thing.  For instance, has
> anyone ever audited all of the serial and lp drivers to make sure that
> nothing they call can call printk() while holding a lock?  This sounds
> fairly serious - we could have any number of simple error cases that would
> cause a deadlock with the right "console=" setting.
> 
> It'd be interesting if we could do something like:
>   1. For every function that appears as a "struct console -> write()" call,
>      follow every possible code path and make a list of every lock that they
>      can try to acquire exclusively.
>   2. Then scan the entire code base see if we ever call can printk() while
>      holding that same lock.

If a driver calls printk() while in ->write(), printk will fail to acquire
the console_sem.  The printk output will be buffered in log_buf[].  When
->write() releases console_sem it will then display the buffered text.

So the deadlocks to which you refer can only happen when the console driver
calls printk while holding driver locks, in a code path where console_sem
is not held.

