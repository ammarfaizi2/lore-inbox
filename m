Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbTAKFZP>; Sat, 11 Jan 2003 00:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbTAKFZP>; Sat, 11 Jan 2003 00:25:15 -0500
Received: from holomorphy.com ([66.224.33.161]:29853 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267049AbTAKFZO>;
	Sat, 11 Jan 2003 00:25:14 -0500
Date: Fri, 10 Jan 2003 21:33:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, daniel.ritz@gmx.ch, hugh@veritas.com,
       ak@suse.de
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
Message-ID: <20030111053351.GD1147@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org, daniel.ritz@gmx.ch, hugh@veritas.com,
	ak@suse.de
References: <200301110414.h0B4El8138492@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301110414.h0B4El8138492@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 11:14:47PM -0500, Albert D. Cahalan wrote:
> I'm told that a simple "ls -lR /proc" will crash a NUMA box
> with more than about 4000 tasks. Locks get held for a long
> time, and then the NMI watchdog causes a reboot. In spite of
> this, reading /proc/ksyms and /proc/kcore would work fine.
> You know what I'm thinking.  :-(  For the really big systems,
> this is the only path to take. So I'll be needing addresses
> of various data structures as well. The LKCD patches would
> be really helpful.

It's filed in the bugzilla, too, but I think it's a separate issue.
Basically proc_pid_readdir() has quadratic behavior. A rank-ordered
tree representation of the tasklist would be useful in order to restart
the walks in O(lg(n)) time. I haven't bothered starting since it looks
like too much code to merge into 2.5. Notable is that it actually does
drop the lock between rounds of linear-time iteration; there is a NUMA
badness lurking here with cachelines getting "trapped" on a node and
the offending /proc/ scanner reacquiring the lock unfairly. The longer-
lived iterations should actually lose the cacheline, so there is still
a small element of mystery.

There was some rumor radix trees could be used for this but I've yet to
see an O(lg(n)) or better seek operation (go to the nth present item in
the tree ordering) that's obvious how to do from the structure. From all
appearances the thing has to get scanned starting from 0 for a best-case
n/64 == O(n), worst-case n, restart of the list walk, where bottom-level
counts allow us to avoid looking at individual items, but it's only a
linear speedup, so the whole shebang is still quadratic, and the thing
will explode again just by multiplying the minimum number of tasks by
the factor of the average speedup (if it's actually a speedup and not a
pessimization). Maintaining rank in radix trees is actually somewhat
expensive, so it's probably not a great idea.

Also, scanning the bitmap doesn't help: only full processes are listed
in /proc/, not threads, and the check actually makes the bitmap scan
more expensive than the list walk, as you have to check the hashtables,
which by the time it matters will be loaded. I've actually tried this,
as it's relatively simple, and was disappointed. =( It's also are stuck
with the O(n) seek operation here, but the seek itself is slightly
better as it touches (far) fewer cachelines. The patch I posted on the
subject ages ago actually did the seeking incorrectly.


Bill
