Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWH3WTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWH3WTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWH3WTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:19:01 -0400
Received: from www.osadl.org ([213.239.205.134]:28856 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932189AbWH3WSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:18:53 -0400
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Frank v Waveren <fvw@var.cx>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060830220836.GA21987@var.cx>
References: <1156927468.29250.113.camel@localhost.localdomain>
	 <20060830214441.GA21353@var.cx>
	 <1156975503.29250.220.camel@localhost.localdomain>
	 <20060830220836.GA21987@var.cx>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 00:22:36 +0200
Message-Id: <1156976556.29250.230.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 00:08 +0200, Frank v Waveren wrote:
> On Thu, Aug 31, 2006 at 12:05:02AM +0200, Thomas Gleixner wrote:
> > > With this patch, we sleep shorter than specified, and don't signal
> > > this in any way. Returning EINVAL for anything except negative tv_sec
> > > or invalid tv_nsec breaks the spec too, but I prefer errors to
> > > silently sleeping too short.
> > 
> > I really don't care whether we sleep 100 or 5000 years in the case of
> > "sleep MAX_LONG"
> Don't sell your patch short, it still manages nearly 300 years..

Hehe

> > > I'll grant this is more of an aesthetic point than something that'll
> > > cause real-world problems (300 years is a long time for any sleep),
> > > but if things break I like them to do so as loudly as possible, as a
> > > general rule.
> > 
> > One thing you ignore is that your patch does not cure the introduced
> > user space breakage, it just replaces the overflow caused very short
> > sleep by a return -EINVAL, which is breaking existing userspace in a
> > different way. We have to preserve user space interfaces even when they
> > violate your aesthetic well-being.
> 
> The userspace interface gets broken either way. The error might
> actually serve as a decent portability wake up call, solaris 64 bit
> also silently overflows in nanosleep, and since I've only had the
> opportunity to check on solaris and linux, I wouldn't be surprised if
> other OSes had the same problem.

Well, the point is that pre hrtimer kernels did just sleep as long as
they internaly could. So the hrtimers / ktime_t merge changed the
userspace interface behaviour, which is breakage. We need to restore the
old behaviour and I consider it to be better than 

1. silent overflows (even if solaris does the same)
2. returning -EINVAL without giving a minimum 1 year warning/fixup time
(see the paragraph about "Usage of invalid timevals in setitimer" in
Documentation/feature-removal-schedule.txt)

	tglx


