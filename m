Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272278AbTHRTZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273027AbTHRTZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:25:43 -0400
Received: from [63.247.75.124] ([63.247.75.124]:54680 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272278AbTHRTZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:25:31 -0400
Date: Mon, 18 Aug 2003 15:25:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
Message-ID: <20030818192529.GC19067@gtf.org>
References: <20030818184403.GL24693@gtf.org> <Pine.LNX.4.44.0308181210430.5929-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308181210430.5929-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 12:12:19PM -0700, Linus Torvalds wrote:
> 
> On Mon, 18 Aug 2003, Jeff Garzik wrote:
> > 
> > schedule_work() is _not_ for that.  As currently implemented, you have
> > no guarantees that your schedule_work()-initiated work will even
> > begin in this century.
> 
> In theory yes. In practice no. schedule_work() tries to wake up the worker 
> process immediately, and as such usually gets the work done asap.
> 
> But hey, if you want to improve on the drivers, please go wild.  I care 
> more about "real life working" than "theoretical but doesn't work".

hehe ;-)  well,

* I've hit this situation in real life (waiting on a driver doing
  error handling, hogging the single shared workqueue on UP).  It 
  actually gets nasty if a bunch of drivers all throw errors at
  the same time... (more below)

* re "improve the drivers" -- if you mean "fixing" those hogging the
  shared workqueue, I think that's a workqueue API flaw.  If you mean
  further fix up the drivers you just modified, well... I think
  slackness on my part will win there :)

There was talk in another thread about fixing up workqueue to create
a new kernel thread, if one isn't available within five seconds.
That seemed reasonable to me.  Another useful addition to workqueue,
for drivers, would be a one-shot thread "runme(func, func_data)" API.
I think a lot of the device driver error handling is more appropriate
to this one-shot API than the current workqueue API.  Error handling is
already a slow path, so the overhead of thread creation on each call is
mitigated.

	Jeff



