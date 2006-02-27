Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751684AbWB0JFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWB0JFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWB0JFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:05:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:42900 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751684AbWB0JFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:05:11 -0500
Date: Mon, 27 Feb 2006 14:34:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Patch 4/7] Add sysctl for delay accounting
Message-ID: <20060227090414.GA18941@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141028322.5785.60.camel@elinux04.optonline.net> <1141028784.2992.58.camel@laptopd505.fenrus.org> <4402BA93.5010302@watson.ibm.com> <1141029743.2992.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141029743.2992.71.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 09:42:23AM +0100, Arjan van de Ven wrote:
> On Mon, 2006-02-27 at 03:38 -0500, Shailabh Nagar wrote:
> > Arjan van de Ven wrote:
> > 
> > The function needs to allocate task_delay_info structs for all tasks 
> > that might
> > have been forked since the last time delay accounting was turned off.
> > Either we have to count how many such tasks there are, or preallocate
> > nr_tasks (as an upper bound) and then use as many as needed.
> 
> it generally feels really fragile, especially with the task enumeration
> going to RCU soon. (eg you'd lose the ability to lock out new task
> creation)

I haven't yet seen any RCU-based code that does this. Can you point out
what patches you are talking about ? As of 2.6.16-rc4 and -rt15,
AFAICS, you can count tasks by holding the read side of tasklist_lock.
Granted it is a bit ugly to repeat this in order to overcome
the race on dropping tasklist_lock for allocation.

> On first sight it looks a lot better to allocate these things on demand,
> but I'm not sure how the sleeping-allocation would interact with the
> places it'd need to be called...

This could be a problem for contexts where sleeping cannot be permitted,
not to mention fast paths where blocking may introduce a skew. It seems
simpler to just let this happen during sysctl time.

Thanks
Dipankar
