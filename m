Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWAWCH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWAWCH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 21:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWAWCH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 21:07:58 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:48583
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751386AbWAWCH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 21:07:57 -0500
Date: Sun, 22 Jan 2006 18:04:21 -0800
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
Message-ID: <20060123020421.GA21208@gnuppy.monkey.org>
References: <Pine.LNX.4.44L0.0601181120100.1993-201000@lifa02.phys.au.dk> <Pine.LNX.4.44L0.0601230047290.31387-201000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601230047290.31387-201000@lifa01.phys.au.dk>
User-Agent: Mutt/1.5.11
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 01:20:12AM +0100, Esben Nielsen wrote:
> Here is the problem:
> 
> Task B (non-RT) takes BKL. It then takes mutex 1. Then B
> tries to lock mutex 2, which is owned by task C. B goes blocks and releases the
> BKL. Our RT task A comes along and tries to get 1. It boosts task B
> which boosts task C which releases mutex 2. Now B can continue? No, it has
> to reaquire BKL! The netto effect is that our RT task A waits for BKL to
> be released without ever calling into a module using BKL. But just because
> somebody in some non-RT code called into a module otherwise considered
> safe for RT usage with BKL held, A must wait on BKL!

True, that's major suckage, but I can't name a single place in the kernel that
does that. Remember, BKL is now preemptible so the place that it might sleep similar 
to the above would be in spinlock_t definitions. But BKL is held across schedules()s
so that the BKL semantics are preserved. Contending under a priority inheritance
operation isn't too much of a problem anyways since the use of it already makes that
path indeterminant. Even under contention, a higher priority task above A can still
run since the kernel is preemptive now even when manipulating BKL.

bill

