Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263067AbVG3QsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbVG3QsX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbVG3QsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:48:22 -0400
Received: from mailhub.hp.com ([192.151.27.10]:11482 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S263067AbVG3Qrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:47:45 -0400
Subject: Re: long delays (possibly infinite) in
	time_interpolator_get_counter
From: Alex Williamson <alex.williamson@hp.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0507291625390.19428@schroedinger.engr.sgi.com>
References: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com>
	 <Pine.LNX.4.62.0507291625390.19428@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: OSLO R&D
Date: Sat, 30 Jul 2005 10:47:34 -0600
Message-Id: <1122742054.28719.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-29 at 16:31 -0700, Christoph Lameter wrote:
> What you are dealing with is a machine that is using ITC as a time bases. 
> That is a special case.

   The default time source for ia64 systems is a "special case"?  4
socket and smaller boxes typically do not have any other time source.

> The fix should not affect machines that have a 
> proper time source. More below. You can circumvent the compensation for 
> ITC inaccuracies by specifying "nojitter" on the kernel command if you are 
> willing to take the risk of slightly inaccurate time.

   And what if you don't have any HPET and aren't willing to take that
risk?  We need a solution that works with all time sources.  A system
with the default time source should not hang or have unreasonable delays
with the standard setup.  Why is a synchronized ITC driven from a common
clock such a terrible time source for small systems?

> Well get a proper time source and do not use ITC for a time source in an 
> SMP system. Got HPET hardware?

   No, HPET on small boxes is unnecessary, we should be able to come up
with something that can effectively use the ITC.  Does a seqlock really
make sense for the do_gettimeofday() path?  This problem arises because
a reader of time is actually updating and writing a part of time.  It
would certainly be too much overhead to obtain a write lock for every
gettimeofday(), but to avoid that we have to put some kind of contention
avoidance in the path.  I don't know whether that should be some kind of
back-off algorithm at the point of contention w/ the cmpxchg or up
higher with a new seqlock read entry point that blocks when a write is
in progress.  In any case, I think we need to focus on a solution that
works well on all systems, not just those with extra timer hardware.
Thanks,

	Alex



