Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWGGXjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWGGXjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWGGXjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:39:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:36562 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932411AbWGGXjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:39:43 -0400
Subject: Re: Hang and Soft Lockup problems with generic time code
From: john stultz <johnstul@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1152313879.3866.53.camel@mulgrave.il.steeleye.com>
References: <1152313879.3866.53.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 16:39:39 -0700
Message-Id: <1152315579.7493.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 18:11 -0500, James Bottomley wrote:
> Ever since the 2.6.17 kernel pulled in the generic timer code, I've been
> experiencing hangs and softlockups with the aic94xx driver (which I
> thought were driver related).  Finally, after a lot of debugging I've
> isolated the culprit to linux/time.h:timespec_add_ns()
> 
> What is happening is that a->tv_nsec is coming in here negative and
> looping for huge amounts of time.

Yep. This has been seen where a large number of ticks are lost. Roman
and I are working on a solution for this (I sent a patch out to the list
earlier today for it, and Roman *just* posted his version a moment ago -
if you can give one or both of them a try it would be appreciated).

> Why tv_nsec is negative appears to be related to massive cycle
> adjustments in kernel/timer.c:update_wall_time().  With the TSC as my
> clocksource I've seen the clocksource_read() return increments of in the
> 200s range.  No idea why this is happening.  The same strange
> discontinuous jumps in cycle count also occurs with pm_acpi as the clock
> source.

Did you really mean jumps of 200 seconds? Hmmm. The issue Roman and I
have been looking into does occur when we lose a number of ticks and
that confuses the clocksource adjustment code. The fix we're working on
corrects the adjustment confusion, but doesn't fix the lost ticks.

However 200 seconds of lost ticks sounds very off. Could the driver be
disabling interrupt for such a long period of time?

> I can't get a good enough handle on all the generic time code changes to
> reverse them.  However, this machine is a P4, so I was able to boot it
> with an x86_64 kernel (which doesn't yet use the generic time code) and
> confirm that all the hangs and softlockups go away.
> 
> The machine in question is an IBM x206m dual core P4.

I appreciate the report and apologize for the trouble.

thanks
-john

