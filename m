Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWFBGx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWFBGx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWFBGx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:53:28 -0400
Received: from www.osadl.org ([213.239.205.134]:30341 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751216AbWFBGx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:53:27 -0400
Subject: Re: non-scalar ktime addition and subtraction broken
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, "Christopher S. Aker" <caker@theshore.net>,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <20060602030825.GA8006@ccure.user-mode-linux.org>
References: <20060602030825.GA8006@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 08:54:22 +0200
Message-Id: <1149231262.20582.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 23:08 -0400, Jeff Dike wrote:
> The use of 64-bit additions and subtractions on something which is
> nominally a struct containing 32-bit second and nanosecond field is
> broken when a negative time is involved.  When the structure is
> treated as a 64-bit integer, the increment of the upper 32 bits that's
> part of two's-complement subtraction is lost.  This leaves the end
> result off by one second.
> 
> This manifested itself with sleeps inside UML lasting about 1 second
> shorter than expected.
> 
> The patch below is more a problem statement than a real fix.  People
> thought about performance, and I don't know what this does to that
> work.
> 
> I'm not sure why the hrtimer.c part is needed - I had done that before
> tracking down the ktime_add problem.  I see short sleeps without it,
> so it is needed somehow.
> 
> The ktime_sub piece was done for completeness - UML compiles and boots
> with no apparent ill effects, but it's otherwise untested.
> 
> As an aside, I fail to see how it can be correct for ktime_sub to add
> NSEC_PER_SEC to something without compensating somewhere else for it.
> 
> Andrew - please don't drop this into -mm without an OK from Thomas or
> someone else who's familiar with this code :-)

NAK. ktime_t is defined that ist must be normalized the same way as
timespecs. The nsec part must be >= 0 and < NSEC_PER_SEC. Fix the part
which is feeding non normalized values.

	tglx




