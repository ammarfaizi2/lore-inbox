Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWATGrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWATGrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWATGrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:47:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:62948 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030410AbWATGrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:47:15 -0500
Date: Fri, 20 Jan 2006 00:47:03 -0600 (CST)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, jes@sgi.com,
       tony.luck@intel.com
Subject: Re: [PATCH] SN2 user-MMIO CPU migration
In-Reply-To: <200601191818.43157.jbarnes@virtuousgeek.org>
Message-ID: <20060120003303.O81637@chenjesu.americas.sgi.com>
References: <20060118163305.Y42462@chenjesu.americas.sgi.com>
 <200601191818.43157.jbarnes@virtuousgeek.org>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Jesse Barnes wrote:

> Maybe you could just turn the above into mmiowb() calls instead?  That 
> would cover altix, origin, and ppc as well I think.  On other platforms 
> it would be a complete no-op.

As you obviously noted, the core of the code was lifted from mmiowb().
But no, an mmiowb() as such isn't correct.  At the time this code is
executing, it's on a CPU remote from the one which issued any PIO writes
to the device.  So in this case we need to poll the Shub register for
a remote node, but mmiowb() only polls for the Shub corresponding to
the current CPU.

My first incarnation of this patch (never publicly presented) did
implement a new mmiowb_remote(cpu) machvec instead, and this was
placed in the context-switch (in) path instead of the task migration
path.  However, since this behavior is only needed for the task
migration case, Jack Steiner pointed out that this was a more
appropriate way to implement it.  As migration is much less frequent
than context switching, this is a better-performing method to solve
the problem.

Thanks,
Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
