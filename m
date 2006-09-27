Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWI0Qbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWI0Qbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWI0Qbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:31:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34746 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030237AbWI0Qbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:31:44 -0400
Date: Wed, 27 Sep 2006 09:32:40 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH 1/4] RCU: split classic rcu
Message-ID: <20060927163239.GC1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060923152957.GA13432@in.ibm.com> <20060923153141.GB13432@in.ibm.com> <20060925165433.GA28898@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925165433.GA28898@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 05:54:33PM +0100, Christoph Hellwig wrote:
> On Sat, Sep 23, 2006 at 09:01:41PM +0530, Dipankar Sarma wrote:
> > 
> > This patch re-organizes the RCU code to enable multiple implementations
> > of RCU. Users of RCU continues to include rcupdate.h and the
> > RCU interfaces remain the same. This is in preparation for
> > subsequently merging the preepmtpible RCU implementation.
> 
> I still disagree very strongly.  In a given tree there should be oneRCU
> implementation for the traditional interface.  We probably want srcu
> in addition, but not things hiding behind the interface.

Hello, Christoph!

I agree very much with your "oneRCU to defer them all" goal for the
traditional interface.

However, the current implementation is extremely well-tested and seems
to be quite reliable.  Yes, there might still be a rough edge or two
in cases where people do call_rcu() in tight loops, but even that is
being covered in most cases where "don't do that" doesn't apply (e.g.,
close(open()) from user space).  The Linux implementation of RCU is
almost six years old, and first appeared in mainline almost four years
ago -- that is some -serious- testing!

We will be switching to a new implementation.  I am working to make it
as reliable as I know how, but it seems reasonable to have a changeover
period that might be measured in years.  I -really- don't want to be
inflicting even the possibility of RCU implementation bugs on anyone who
has not "signed up" for code that has not yet be hammered into total
and complete submission!  CONFIG_PREEMPT_RT is quite reliable even now,
but there is "quite reliable" and then there is "hammered into total
and complete submission".  ;-)

Also, we need any new implementation of RCU to be in a separate file.
I don't want to even think about the number of times that I accidentally
changed the wrong version of RCU when working on the -rt implementation
before we split it -- the functions have the same name, right?  :-/

So maybe we rip the multi-RCU infrastructure out once we have fully
(and I mean -fully-) tested the new RCU implementation, taken care of
any performance anomalies, and so on.  I would be totally OK with that,
but believe the split will be needed in the meantime.

Fair enough?  Or am I missing something?

							Thanx, Paul
