Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbTJOPD1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbTJOPD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:03:26 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:29387 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262841AbTJOPDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:03:25 -0400
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Greg Stark <gsstark@mit.edu>,
       Joel Becker <Joel.Becker@oracle.com>,
       Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
References: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org>
	<878ynq3y7n.fsf@stark.dyndns.tv> <3F8A661B.80909@aitel.hist.no>
	<200310151525.40470.ioe-lkml@rameria.de>
In-Reply-To: <200310151525.40470.ioe-lkml@rameria.de>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 15 Oct 2003 11:03:23 -0400
Message-ID: <87llrmbl1g.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> writes:

> On Monday 13 October 2003 10:45, Helge Hafting wrote:
> 
> > This is easier than trying to tell the kernel that the job is
> > less important, that goes wrong wether the job runs too much
> > or too little.  Let that job  sleep a little when its services
> > aren't needed, or when you need the disk bandwith elsewhere.

Actually I think that's exactly backwards. The problem is that if the
user-space tries to throttle the process it doesn't know how much or when.
The kernel knows exactly when there are other higher priority writes, it can
schedule just enough writes from vacuum to not interfere.

So if vacuum slept a bit, say every 64k of data vacuumed. It could end up
sleeping when the disks are actually idle. Or it could be not sleeping enough
and still be interfering with transactions.

Though actually this avenue has some promise. It would not be nearly as ideal
as a kernel based solution that could take advantage of the idle times between
transactions, but it would still work somewhat as a work-around.

> The questions are: How IO-intensive vacuum? How fast can a throttling
> free disk bandwidth (and memory)?

It's purely i/o bound on large sequential reads. Ideally it should still have
large enough sequential reads to not lose the streaming advantage, but not so
large that it preempts the more random-access transactions.

-- 
greg

