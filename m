Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268401AbUIMPRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268401AbUIMPRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268304AbUIMPMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:12:50 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:42454 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268092AbUIMO5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:57:17 -0400
Subject: Re: /proc/sys/kernel/pid_max issues
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       anton@samba.org
In-Reply-To: <20040913142437.GB9106@holomorphy.com>
References: <1095045628.1173.637.camel@cube>
	 <20040913075743.GA15722@elte.hu> <1095083649.1174.1293.camel@cube>
	 <20040913142437.GB9106@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095087244.2191.1383.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Sep 2004 10:54:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 10:24, William Lee Irwin III wrote:
> On Mon, 2004-09-13 at 03:57, Ingo Molnar wrote:
> >> this is a pretty sweeping assertion. Would you
> >> care to mention a few examples of such hazards?
> 
> On Mon, Sep 13, 2004 at 09:54:09AM -0400, Albert Cahalan wrote:
> > kill(12345,9)
> > setpriority(PRIO_PROCESS,12345,-20)
> > sched_setscheduler(12345, SCHED_FIFO, &sp)
> > Prior to the call being handled, the process may
> > die and be replaced. Some random innocent process,
> > or a not-so-innocent one, will get acted upon by
> > mistake. This is broken and dangerous.
> > Well, it's in the UNIX standard. The best one can
> > do is to make the race window hard to hit, with LRU.
> 
> How do you propose to queue pid's? This is space constrained. I don't
> believe it's feasible and/or desirable to attempt this, as there are
> 4 million objects to track independent of machine size.

As we've seen elsewhere in this thread, things break
when you go above 0xffff anyway. So 128 KiB of RAM
should do the job. With a 4-digit PID, 20000 bytes
would be enough.

Supposing you fix rwsem counts and /proc inodes and so on,
a large machine could handle 4 million objects easily.
A small machine has far, far, less need to support that.

> The general
> tactic of cyclic order allocation is oriented toward making this rare
> and/or hard to trigger by having a reuse period long enough that what
> processes there are after a pid wrap are likely to have near-indefinite
> lifetimes. i.e. it's the closest feasible approximation of LRU. If you
> truly want/need reuse to be gone, 64-bit+ pid's are likely best.

That's too unwieldy for the users, it breaks glibc,
and you'll still hit the problems after wrap-around.
Besides, Linus vetoed this a year or two ago.

Reducing the dangers of a small PID space allows for
just the opposite size change, which is much nicer for
the users.


