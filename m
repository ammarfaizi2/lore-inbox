Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313297AbSDOVZW>; Mon, 15 Apr 2002 17:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313299AbSDOVZV>; Mon, 15 Apr 2002 17:25:21 -0400
Received: from zero.tech9.net ([209.61.188.187]:46353 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313297AbSDOVZU>;
	Mon, 15 Apr 2002 17:25:20 -0400
Subject: Re: [PATCH] 2.5: don't miss a preemption
From: Robert Love <rml@tech9.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0204152144320.1833-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 Apr 2002 17:25:24 -0400
Message-Id: <1018905925.3399.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-15 at 16:50, Hugh Dickins wrote:

> On 15 Apr 2002, Robert Love wrote:
> > 
> > This patch checks for need_resched in preempt_schedule after setting
> > preempt_count back to zero, before returning.  The overhead is
> > negligible and it is crucial to never miss a preemption opportunity.
> 
> I'm curious: why is it crucial to never miss a preemption opportunity?

Two main reasons:

(1) In 2.5, we have a kernel preemption model that makes the
    fully preemptible, subject to SMP locking constraints and
    a few other rules.  Without this patch, we break this model
    and do not allow preemption when it is in fact legal.

(2) Like I said, it may be awhile before we can preempt again.
    If we take a lock after return from schedule but before the
    next interrupt, it can be many tens (or hundreds) of milliseconds
    before we release the lock and subsequently preempt.  If
    need_resched was set in response to an important real-time
    application, the wait can be detrimental.  Servicing apps
    as soon as they become runnable is the point of preempt-kernel,
    anyhow.

It is not crucial in the sense we break anything; merely that we are
working toward providing very efficient response and dispatch to
interactive and real-time applications and we _must_ respond to them as
soon as possible.

	Robert Love


