Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264161AbSIRAVp>; Tue, 17 Sep 2002 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSIRAVo>; Tue, 17 Sep 2002 20:21:44 -0400
Received: from holomorphy.com ([66.224.33.161]:25063 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264161AbSIRAVo>;
	Tue, 17 Sep 2002 20:21:44 -0400
Date: Tue, 17 Sep 2002 17:22:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918002240.GB2179@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 01:06:11AM +0200, Ingo Molnar wrote:
> then i found one of wli's older patches for 2.5.23 [grr, it was not
> announced anywhere, i almost started coding the same problem], which
> provides the right (and much harder to implement) approach: it cleans up
> PID-space allocation to provide a generic hash for PIDs, session IDs,
> process group IDs and TGIDs, properly allocated and freed. This approach,
> besides paving the way for a scalable and time-bounded get_pid()
> implementation, also got rid of roughly half of for_each_process()
> (do_each_thread()) iterations done in the kernel, which alone is worth the
> effort. Now we can cleanly iterate through all processes in a session
> group or process group.
> i took the patch, adopted it to the recent ->ptrace_children and threading
> related changes, fixed a couple of bugs and made it work. It really worked
> well, nice work William!

Thank you for taking up the completion of development on and maintenance
of this patch. I have not had the time resources to advance it myself,
though now with your help I would be glad to contribute to the effort.
If you would like to assume ownership, I'd be glad to hand it over, and
send patches removing additional instances of for_each_process() to you
as I find the time.


On Wed, Sep 18, 2002 at 01:06:11AM +0200, Ingo Molnar wrote:
> I also wrote a new alloc_pid()/free_pid() implementation from scratch,
> which provides lockless, time-bounded PID allocation. This new PID
> allocator has a worst-case latency of 10 microseconds on a cache-cold P4,
> the cache-hot worst-case latency is 2 usecs, if pid_max is set to 1
> million.

This is necessary regardless in order to address the larger PID space.
In the brief review of it I've done thus far, the new algorithm appears
to be both sound and efficient.

The issues addressed here are extremely important for the workloads I
must support. The algorithmic breakdown of the prior algorithms with
larger task counts was severe enough to trip the NMI oopser and deceives
users into power cycling when they are not running the NMI oopser. This
issue in fact obstructs my testing and development on other subsystems.


Thanks,
Bill
