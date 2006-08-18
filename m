Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWHRAL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWHRAL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 20:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWHRAL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 20:11:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23984 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932163AbWHRALz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 20:11:55 -0400
Date: Fri, 18 Aug 2006 10:11:02 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow writeback.
Message-ID: <20060818001102.GW51703024@melbourne.sgi.com>
References: <17633.2524.95912.960672@cse.unsw.edu.au> <20060815010611.7dc08fb1.akpm@osdl.org> <20060815230050.GB51703024@melbourne.sgi.com> <17635.60378.733953.956807@cse.unsw.edu.au> <20060816231448.cc71fde7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816231448.cc71fde7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 11:14:48PM -0700, Andrew Morton wrote:
> 
> I guess a robust approach would be to track, on a per-process,
> per-threadgroup, per-user, etc basis the time-averaged page-dirtying rate. 
> If it is "low" then accept the dirtying.  If it is "high" then this process
> is a heavy writer and needs throttling earlier.  Up to a point - at some
> level we'll need to throttle everyone as a safety net if nothing else.

The problem with that approach is that throttling a large writer
forces data to disk earlier and that may be undesirable - the large
file might be a temp file that will soon be unlinked, and in this case
you don't want it throttled. Right now, you set dirty*ratio high enough
that this doesn't happen, and the file remains memory resident until
unlink.

> Something like that covers the global dirty+writeback problem.  The other
> major problem space is the multiple-backing-device problem:
> 
> a) One device is being written to heavily, another lightly
> 
> b) One device is fast, another is slow.

Once we are past the throttling threshold, the only thing that
matters is whether we can write more data to the backing device(s).
We should not realy be allowing the input rate to exceed the output
rate one we are passed the throttle threshold.

> Thus far, the limited size of the request queues has saved us from really,
> really serious problems.  But that doesn't work when lots of disks are
> being used.

Mainly because it increases the number of pages under writeback that
currently aren't accounted as dirty and the throttle doesn't
kick in when it should.

> To solve this properly we'd need to account for
> dirty+writeback(+unstable?) pages on a per-backing-dev basis.

We'd still need to account for them globally because we still need
to be able to globally limit the amount of dirty data in the
machine.

FYI, I implemented a complex two-stage throttle on Irix a couple of
years ago - it uses a per-device soft throttle threshold that is not
enforced until the global dirty state passes a configurable limit.
At that point, the per-device limits are enforced.

This meant that devices with no dirty state attached to them could
continue to dirty pages up to their soft-threshold, whereas heavy
writers would be stopped until their backing devices fell back below
the soft thresholds.

Because the amount of dirty pages could continue to grow past safe
limits if you had enough devices, there is also a global hard limit
that cannot be exceeded and this throttles all incoming write
requests regardless of the state of the device it was being written
to.

The problem with this approach is that the code was complex and
difficult to test properly. Also, working out the default config
values was an exercise in trial, error, workload measurement and
guesswork that took some time to get right.

The current linux code works as well as that two-stage throttle
(better in some cases!) because of one main thing - bound request
queue depth with feedback into the throttling control loop. Irix
has neither of these so the throttle had to provide this accounting
and limiting (soft throttle threshold).

Hence I'm not sure that per-backing-device accounting and making
decisions based on that accounting is really going to buy us much
apart from additional complexity....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
