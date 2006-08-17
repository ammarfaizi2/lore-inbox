Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWHQGO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWHQGO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWHQGO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:14:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750927AbWHQGO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:14:56 -0400
Date: Wed, 16 Aug 2006 23:14:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
Message-Id: <20060816231448.cc71fde7.akpm@osdl.org>
In-Reply-To: <17635.60378.733953.956807@cse.unsw.edu.au>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 14:08:58 +1000
Neil Brown <neilb@suse.de> wrote:

> So I think you need to throttle when Dirty+Writeback hits dirty_ratio

yup.

> (which we don't quite get right at the moment).  But the trick is to
> throttle gently and fairly, rather than having a hard wall so that any
> one who hits it just stops.

I swear, I had all this working in 2001.  Perhaps I dreamed it.  But I
specifically remember testing that processes which were performing small,
occasional writes were not getting blocked behind the activity of other
processes which were doing massive write()s.  Ho hum, not to worry.


I guess a robust approach would be to track, on a per-process,
per-threadgroup, per-user, etc basis the time-averaged page-dirtying rate. 
If it is "low" then accept the dirtying.  If it is "high" then this process
is a heavy writer and needs throttling earlier.  Up to a point - at some
level we'll need to throttle everyone as a safety net if nothing else.

Something like that covers the global dirty+writeback problem.  The other
major problem space is the multiple-backing-device problem:

a) One device is being written to heavily, another lightly

b) One device is fast, another is slow.

Thus far, the limited size of the request queues has saved us from really,
really serious problems.  But that doesn't work when lots of disks are
being used.  To solve this properly we'd need to account for
dirty+writeback(+unstable?) pages on a per-backing-dev basis.

But as a first step, yes, using dirty+writeback for the throttling
threshold and continuing to rely upon limited request queue size to save us
from disaster would be a good step.


btw, one thing which afaik NFS _still_ doesn't do is to wake up processes
which are stuck in blk_congestion_wait() when NFS has retired a bunch of
writes.  It should do so, otherwise NFS write-intensive workloads might end
up sleeping for too long.  I guess the amount of buffering and hysteresis
we have in there has thus far prevented any problems from being observed.
