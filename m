Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUJRWP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUJRWP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUJRWP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:15:57 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:8856 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267543AbUJRWPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:15:54 -0400
Subject: Re: [PATCH] add unschedule_delayed_work to the workqueue API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <20041018150217.0fbf714f.akpm@osdl.org>
References: <1098117067.2011.64.camel@mulgrave>
	<20041018142524.5b81a09a.akpm@osdl.org>
	<1098134824.2011.322.camel@mulgrave> <1098134994.2792.325.camel@mulgrave>
	<20041018144354.2118138f.akpm@osdl.org>
	<1098136049.2792.329.camel@mulgrave> 
	<20041018150217.0fbf714f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Oct 2004 17:15:41 -0500
Message-Id: <1098137747.1714.351.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 17:02, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > > > OK, found it in the headers, sorry .. it's not synchronous, so it can't
> > > > really be used in most of the cases where we use del_timer_sync().
> > > 
> > > cancel_delayed_work() will tell you whether it successfully cancelled the
> > > timer.  If it didn't, you should run flush_workqueue() to wait on the final
> > > handler.  The combination of the two is synchronous.
> > 
> > Right, but it potentially does too much work for my purposes.
> 
> Are you sure?

I'm positive the potential is there.

> >  I want to
> > cancel the work if it's cancellable or wait for it if it's already
> > executing.  I don't want to have to wait for all the work in the queue
> > just because the timer fired and it got added to the workqueue schedule.
> 
> The probability that the handler is running when you call
> cancel_delayed_work() is surely very low.  And the probability that there
> is more than one thing pending in the queue at that time is also low. 
> Multiplying them both together, then multiplying that by the relative
> expense of the handler makes me say "show me" ;)

OK.  In the current code, domain validation is done from the workqueue
interface.  This can take several seconds per target to complete.  Why
should I have to wait this extra time.  As I move other SCSI daemon
threads to being work queue items, these times rise.

However, now there's a worse problem.  If I want to cancel a piece of
work synchronously, flush_scheduled_work() makes me dependent on the
execution of all the prior pieces of work.  If some of them are related,
like Domain Validation and device unlocking say, I have to now be
extremely careful that the place I cancel and flush from isn't likely to
deadlock with any other work scheduled on the device.  This makes it a
hard to use interface.  By contrast, the proposed patch will *only* wait
if the item of work is currently executing.  This is a (OK reasonably
given the aic del_timer_sync() issues) well understood deadlock
problem---the main point being I now don't have to consider any of the
other work that might be queued.

James


