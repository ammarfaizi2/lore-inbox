Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUJRWyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUJRWyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUJRWyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:54:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:20959 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267713AbUJRWx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:53:28 -0400
Date: Mon, 18 Oct 2004 15:57:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] add unschedule_delayed_work to the workqueue API
Message-Id: <20041018155727.3ba8cbea.akpm@osdl.org>
In-Reply-To: <1098137747.1714.351.camel@mulgrave>
References: <1098117067.2011.64.camel@mulgrave>
	<20041018142524.5b81a09a.akpm@osdl.org>
	<1098134824.2011.322.camel@mulgrave>
	<1098134994.2792.325.camel@mulgrave>
	<20041018144354.2118138f.akpm@osdl.org>
	<1098136049.2792.329.camel@mulgrave>
	<20041018150217.0fbf714f.akpm@osdl.org>
	<1098137747.1714.351.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> > 
> > The probability that the handler is running when you call
> > cancel_delayed_work() is surely very low.  And the probability that there
> > is more than one thing pending in the queue at that time is also low. 
> > Multiplying them both together, then multiplying that by the relative
> > expense of the handler makes me say "show me" ;)
> 
> OK.  In the current code, domain validation is done from the workqueue
> interface.  This can take several seconds per target to complete.  Why
> should I have to wait this extra time.  As I move other SCSI daemon
> threads to being work queue items, these times rise.

You mean the scsi code wants to schedule a work some time in the future and
that when it executes, the handler will then run for several seconds?

If so, it sounds like this is the wrong mechanism to use.  We certainly
don't want keventd gone to lunch for that long, and even if the kernel
threads were privately created by the scsi code, you'll have to create many
such threads to get any sort of parallelism across many disks.  I suspect
I'm missing something.

> However, now there's a worse problem.  If I want to cancel a piece of
> work synchronously, flush_scheduled_work() makes me dependent on the
> execution of all the prior pieces of work.  If some of them are related,
> like Domain Validation and device unlocking say, I have to now be
> extremely careful that the place I cancel and flush from isn't likely to
> deadlock with any other work scheduled on the device.  This makes it a
> hard to use interface.

Well yes, the caller wouldn't want to be holding any locks which cause
currently-queued works to block.

>  By contrast, the proposed patch will *only* wait
> if the item of work is currently executing.  This is a (OK reasonably
> given the aic del_timer_sync() issues) well understood deadlock
> problem---the main point being I now don't have to consider any of the
> other work that might be queued.

OK.
