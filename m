Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbWFTJcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbWFTJcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWFTJcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:32:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965233AbWFTJcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:32:31 -0400
Date: Tue, 20 Jun 2006 02:32:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org, Dave Olson <olson@unixfolk.com>
Subject: Re: [patch] fix spinlock-debug looping
Message-Id: <20060620023216.4995edb9.akpm@osdl.org>
In-Reply-To: <20060620091505.GA9749@elte.hu>
References: <20060619070229.GA8293@elte.hu>
	<20060619005955.b05840e8.akpm@osdl.org>
	<20060619081252.GA13176@elte.hu>
	<20060619013238.6d19570f.akpm@osdl.org>
	<20060619083518.GA14265@elte.hu>
	<20060619021314.a6ce43f5.akpm@osdl.org>
	<20060619113943.GA18321@elte.hu>
	<20060619125531.4c72b8cc.akpm@osdl.org>
	<20060620084001.GC7899@elte.hu>
	<20060620015259.dab285d5.akpm@osdl.org>
	<20060620091505.GA9749@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 11:15:05 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Tue, 20 Jun 2006 10:40:01 +0200
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > i obviously agree that any such crash is a serious problem, but is 
> > > it caused by the spinlock-debugging code?
> > 
> > Judging from Dave Olson <olson@unixfolk.com>'s report: no.  He's 
> > getting hit by NMI watchdog expiry on write_lock(tree_lock) in a 
> > !CONFIG_DEBUG_SPINLOCK kernel.
> 
> hm, that means 5 seconds of looping with irqs off?

Yup.

> That's really insane. 

Yup.

> Is there any definitive testcase or testsystem where we could try a 
> simple tree_lock rwlock -> spinlock conversion?

Not that I'm aware of.  I just tried three CPUs doing
fadvise(FADV_WILLNEED, 1GB) with the fourth CPU trying to write the file,
but it didn't lock up as I expected.

> Spinlocks are alot 
> fairer. Or as a simple experiment, s/read_lock/write_lock, as the patch 
> below (against rc6-mm2) does. This is phase #1, if it works out we can 
> switch tree_lock to a spinlock. [write_lock()s are roughly as fair to 
> each other as spinlocks - it's a bit more expensive but not 
> significantly] Builds & boots fine here.

tree_lock was initially an rwlock.  Then we made it a spinlock.  Then we
made it an rwlock.  We change the dang thing so often we should make it a
macro ;)

Let's just make it a spinlock and be done with it.  Hopefully Dave or
ccb@acm.org (?) will be able to test it.  I was planning on doing a patch
tomorrowish.
