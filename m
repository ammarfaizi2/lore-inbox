Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUFVBaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUFVBaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 21:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUFVBaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 21:30:10 -0400
Received: from zero.aec.at ([193.170.194.10]:46086 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266513AbUFVBaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 21:30:04 -0400
To: "Kirill Korotaev" <kksx@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: can TSC tick with different speeds on SMP?
References: <29Cl9-2Uu-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 22 Jun 2004 05:30:30 +0200
In-Reply-To: <29Cl9-2Uu-13@gated-at.bofh.it> (Kirill Korotaev's message of
 "Mon, 21 Jun 2004 21:10:07 +0200")
Message-ID: <m34qp4i815.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kirill Korotaev"  <kksx@mail.ru> writes:

> I've got some stupid question to SMP gurus and would be very
> thankful for the details. I suddenly faced an SMP system where
> different P4 cpus were installed (with different steppings). This
> resulted in different CPU clock speeds and different speeds of time
> stamp counters on these CPUs. I faced the problem during some
> timings I measured in the kernel.

Yes, it is a quite common problem. You'll have to deal with it
somehow.  Somehow it can be fixed by disabling "cross spectrum
clocking" or similar in the BIOS setup, but on others it 
is unfixable.

Ultimatively the kernel will need to move to a per CPU time base
to deal with this better, but that is a future project.

For user space I would suggest to use gettimeofday() or better
clock_gettime(CLOCK_MONOTONIC, ...) in 2.6 to get time stamps
and let the kernel deal with it.

>
> So the question is "is such system compliant with SMP
> specification?".  In old kernels there was a code to syncronize TSCs
> and to detect if they were screwed up. Current kernels do not have
> such code. Is it intentional? I suppose there is some code in kernel
> which won't work find on such systems (real-time threads timing
> accounting and so on).

The usual way to is to turn off tsc support in gettimeofday.  This can
be done by booting with "notsc" That should be the only code relying
on it. The scheduler did in some 2.6 versions, but that has been also
fixed (it can tolerate non monotonous times now). Other code
who reads the TSC directly has to deal with it.

e.g. x86-64 just forces HPET gettimeofday when SMP is on, which slows
down gettimeofday greatly.

-Andi

