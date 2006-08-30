Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWH3WBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWH3WBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWH3WBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:01:20 -0400
Received: from www.osadl.org ([213.239.205.134]:16312 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932151AbWH3WBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:01:19 -0400
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Frank v Waveren <fvw@var.cx>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060830214441.GA21353@var.cx>
References: <1156927468.29250.113.camel@localhost.localdomain>
	 <20060830214441.GA21353@var.cx>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 00:05:02 +0200
Message-Id: <1156975503.29250.220.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 23:44 +0200, Frank v Waveren wrote:
> On Wed, Aug 30, 2006 at 10:44:28AM +0200, Thomas Gleixner wrote:
> > Frank v. Waveren pointed out that on 64bit machines the timespec to
> > ktime_t conversion might overflow. This is also true for timeval to
> > ktime_t conversions. This breaks a "sleep inf" on 64bit machines.
> ...
> > Check the seconds argument to the conversion and limit it to the maximum
> > time which can be represented by ktime_t.
> 
> It's a solution, and it more or less fixes things without any changes
> to userspace, which is nice. I still prefer my patch in
> <20060827083438.GA6931@var.cx> though, possibly with modifications so
> it doesn't affect all timespec users but only nanosleep (we'd have to
> check if the other timespec users aren't converting to ktime_t). 
> 
> With this patch, we sleep shorter than specified, and don't signal
> this in any way. Returning EINVAL for anything except negative tv_sec
> or invalid tv_nsec breaks the spec too, but I prefer errors to
> silently sleeping too short.

I really don't care whether we sleep 100 or 5000 years in the case of
"sleep MAX_LONG"

> I'll grant this is more of an aesthetic point than something that'll
> cause real-world problems (300 years is a long time for any sleep),
> but if things break I like them to do so as loudly as possible, as a
> general rule.

One thing you ignore is that your patch does not cure the introduced
user space breakage, it just replaces the overflow caused very short
sleep by a return -EINVAL, which is breaking existing userspace in a
different way. We have to preserve user space interfaces even when they
violate your aesthetic well-being.

	tglx


