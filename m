Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUJRXY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUJRXY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 19:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUJRXY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 19:24:27 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:61094 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267785AbUJRXYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 19:24:17 -0400
Subject: Re: [PATCH] add unschedule_delayed_work to the workqueue API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <20041018155727.3ba8cbea.akpm@osdl.org>
References: <1098117067.2011.64.camel@mulgrave>
	<20041018142524.5b81a09a.akpm@osdl.org>
	<1098134824.2011.322.camel@mulgrave> <1098134994.2792.325.camel@mulgrave>
	<20041018144354.2118138f.akpm@osdl.org>
	<1098136049.2792.329.camel@mulgrave>
	<20041018150217.0fbf714f.akpm@osdl.org>
	<1098137747.1714.351.camel@mulgrave> 
	<20041018155727.3ba8cbea.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Oct 2004 18:24:01 -0500
Message-Id: <1098141847.2011.364.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 17:57, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> You mean the scsi code wants to schedule a work some time in the future and
> that when it executes, the handler will then run for several seconds?
> 
> If so, it sounds like this is the wrong mechanism to use.  We certainly
> don't want keventd gone to lunch for that long, and even if the kernel
> threads were privately created by the scsi code, you'll have to create many
> such threads to get any sort of parallelism across many disks.  I suspect
> I'm missing something.

There is a case where this can happen, yes, but I admit it's not the
common one...most DV's are kicked off without a thread from user context
(either in the initial scan or by user request).  The common case where
we use a workqueue is if an asynchronous event that alters the transport
agreement comes in (mainly a bus reset) via an interrupt.

> > However, now there's a worse problem.  If I want to cancel a piece of
> > work synchronously, flush_scheduled_work() makes me dependent on the
> > execution of all the prior pieces of work.  If some of them are related,
> > like Domain Validation and device unlocking say, I have to now be
> > extremely careful that the place I cancel and flush from isn't likely to
> > deadlock with any other work scheduled on the device.  This makes it a
> > hard to use interface.
> 
> Well yes, the caller wouldn't want to be holding any locks which cause
> currently-queued works to block.

It's not just locks (hopefully there shouldn't be any of these).  It's
also device states.

For instance, DV will attempt to quiesce the device (i.e. wait for it's
currently outstanding commands to complete).  Thus, I can't use the
cancel/flush method in any code path (such as may be called from error
handling) which could itself be part of the completion path.

This dependence is caused by having to wait for everything that could
potentially be on the workqueue to complete.  I'd really prefer an API
that didn't have this potentially nasty entanglement, which is why I
coded mine to only do the wait if the piece of work being removed was in
the process of executing, but not otherwise.

> >  By contrast, the proposed patch will *only* wait
> > if the item of work is currently executing.  This is a (OK reasonably
> > given the aic del_timer_sync() issues) well understood deadlock
> > problem---the main point being I now don't have to consider any of the
> > other work that might be queued.
> 
> OK.

James


