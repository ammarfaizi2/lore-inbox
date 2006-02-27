Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWB0KLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWB0KLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 05:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWB0KLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 05:11:37 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:44198 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750985AbWB0KLh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 05:11:37 -0500
Date: Mon, 27 Feb 2006 15:41:24 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: dipankar@in.ibm.com, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 4/7] Add sysctl for delay accounting
Message-ID: <20060227101124.GA22492@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141028322.5785.60.camel@elinux04.optonline.net> <1141028784.2992.58.camel@laptopd505.fenrus.org> <4402BA93.5010302@watson.ibm.com> <1141029743.2992.71.camel@laptopd505.fenrus.org> <20060227090414.GA18941@in.ibm.com> <1141031595.2992.76.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141031595.2992.76.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 10:13:14AM +0100, Arjan van de Ven wrote:
> On Mon, 2006-02-27 at 14:34 +0530, Dipankar Sarma wrote:
> > On Mon, Feb 27, 2006 at 09:42:23AM +0100, Arjan van de Ven wrote:
> > > On Mon, 2006-02-27 at 03:38 -0500, Shailabh Nagar wrote:
> > > > Arjan van de Ven wrote:
> > > > 
> > > > The function needs to allocate task_delay_info structs for all tasks 
> > > > that might
> > > > have been forked since the last time delay accounting was turned off.
> > > > Either we have to count how many such tasks there are, or preallocate
> > > > nr_tasks (as an upper bound) and then use as many as needed.
> > > 
> > > it generally feels really fragile, especially with the task enumeration
> > > going to RCU soon. (eg you'd lose the ability to lock out new task
> > > creation)
> > 
> > I haven't yet seen any RCU-based code that does this. Can you point out
> > what patches you are talking about ? As of 2.6.16-rc4 and -rt15,
> > AFAICS, you can count tasks by holding the read side of tasklist_lock.
> > Granted it is a bit ugly to repeat this in order to overcome
> > the race on dropping tasklist_lock for allocation.
> 
> there are several people (Christoph for one) who are working on making
> the tasklist_lock go away entirely in favor of RCU-like locking...
> 
>

One of the reasons that alloc_delays() is a bit ugly is to handle the case
that tasks might get created between the two loops. Even with RCU kind of
locking (except for changing the locking primitives of-course), this code would
work fine. Once delayacct_on is set to 1, copy_process() should take care of
allocating the delays structure. alloc_delays() re-iterates through the list
of tasks to find tasks whose allocation got missed. This revisit happens
at most once due to the small window in which we check for delayacct_on
and allocate the task's delays structure. If tasks are missed within that
window, we revisit the tasks again and allocate for them.

Even with RCU kind of locking, this code should be able to gracefully
deal with tasks getting created/lost between the scanning of the tasklist.

Balbir
