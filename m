Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWC1X6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWC1X6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWC1X6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:58:25 -0500
Received: from www.osadl.org ([213.239.205.134]:16549 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964851AbWC1X6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:58:24 -0500
Subject: Re: PI patch against 2.6.16-rt9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0603290006290.32655-100000@lifa02.phys.au.dk>
References: <Pine.LNX.4.44L0.0603290006290.32655-100000@lifa02.phys.au.dk>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 01:59:23 +0200
Message-Id: <1143590363.5344.257.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 00:34 +0100, Esben Nielsen wrote:
> > Your method is tempting, but I do not see how it works out right now
> 
> It works for PI.

Well, works and effective are two things. In the worst case it
introduces scheduler floods.

> It might give false positives for deadlock detection even
> without signals involved. But that might be solved by simply checking
> again.

Which is even more broken. Rechecking is less deterministic as the
global lock fall back solution.

> If it is stored on a task when they blocked on a lock it
> could be seen if they had released and reobtained the task since the last
> traversal.

-ENOPARSE

> If I should choose between a 100% certain deadlock detection and
> rescheduling while doing PI I would choose that latter as that gives a
> deterministic RT system. Are there at all applications depending on
> deadlock detection or is it only for debug perposes anyway?

No, userspace can request deadlock checking and we have to return
-EDEADLK in that case.

[EDEADLK]
        A deadlock condition was detected or the current thread already
        owns the mutex.
        
Returning false positives might break well designed applications and
prevent real deadlock detection.

Btw, your get/put_task proposal adds two atomic ops. Atomic ops are
implicit memory barriers and therefor you add two extra slow downs into
the non conflict case.

	tglx


