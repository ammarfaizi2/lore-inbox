Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUIOVbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUIOVbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUIOV1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:27:40 -0400
Received: from holomorphy.com ([207.189.100.168]:13471 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267543AbUIOVZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:25:14 -0400
Date: Wed, 15 Sep 2004 14:25:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040915212508.GY9106@holomorphy.com>
References: <20040915151815.GA30138@elte.hu> <Pine.LNX.4.58.0409150826150.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409150826150.2333@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Ingo Molnar wrote:
>> the attached patch is a new approach to get rid of Linux's Big Kernel
>> Lock as we know it today.
>
On Wed, Sep 15, 2004 at 08:40:55AM -0700, Linus Torvalds wrote:
> I really think this is wrong.
> Maybe not from a conceptual standpoint, but that implementation with the
> scheduler doing "reaquire_kernel_lock()" and doing a down() there is just
> wrong, wrong, wrong.
> If we're going to do a down() and block immediately after being scheduled,
> I don't think we should have been picked in the first place.

Well, I'm more concerned that the users all need to be swept anyway.
This could make sense to do anyway, but the sweeps IMHO are necessary
because the users almost universally are those that haven't been taught
to do any locking yet, stale and crusty code that needs porting, or
things where the locking hasn't quite been debugged or straightened out.

One thing I like is that this eliminates the implicit dropping on sleep
as a source of bugs (e.g. it was recently pointed out to me that setfl()
uses the BKL to protect ->f_flags in a codepath spanning a sleeping
call to ->fasync()), where the semaphore may be retained while sleeping.
I originally wanted to make sleeping under the BKL illegal and sweep
users to repair when it is, but maybe that's unrealistic, particularly
considering that the sum of my BKL sweeps to date are one removal from
procfs "protecting" its access of nr_threads.


-- wli
