Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288124AbSA3Cu4>; Tue, 29 Jan 2002 21:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288113AbSA3Cuq>; Tue, 29 Jan 2002 21:50:46 -0500
Received: from nrg.org ([216.101.165.106]:20320 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S288124AbSA3Cu2>;
	Tue, 29 Jan 2002 21:50:28 -0500
Date: Tue, 29 Jan 2002 18:50:21 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <1012357211.817.67.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0201291821030.15838-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jan 2002, Robert Love wrote:
> On Tue, 2002-01-29 at 20:26, Andrew Morton wrote:
> > Just a little word of caution here.  Remember the
> > apache-flock-synchronisation fiasco, where removal
> > of the BKL halved Apache throughput on 8-way x86.
> >
> > This was because the BKL removal turned serialisation
> > on a quick codepath from a spinlock into a schedule().

Yes, but the other factor to consider here is why did the extra schedule
take place at all?  I think this is a actually a scheduler issue, and
I'm hoping that the new scheduler will behave better in this case.  A
call to schedule() should not happen unless the woken process has a
higher priority than the process that did the unlock, but the old
scheduler evidently always calculated this to be the case.  But we
really want the process that did the unlock to continue running (until
the end of its timeslice, if not preempted or blocked before then), just
as it would when the lock was a spinlock.  It would be interesting to
see whether the new scheduler gets this right.

Am I remembering the problem correctly?

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

