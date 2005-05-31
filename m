Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVEaWZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVEaWZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVEaWZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:25:52 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:39325 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261166AbVEaWZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:25:39 -0400
Date: Tue, 31 May 2005 15:25:54 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andi Kleen <ak@muc.de>, Chris Friesen <cfriesen@nortel.com>,
       john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: spinaphore conceptual draft
Message-ID: <20050531222554.GA1341@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de> <429B289D.7070308@nortel.com> <20050530164003.GB8141@muc.de> <429B4957.7070405@nortel.com> <m1k6lgwqro.fsf@muc.de> <02485B05-6AE5-4727-8778-D73B2D202772@mac.com> <20050530192826.GB25794@muc.de> <4DE908D1-29A8-4A05-AC16-E3AD480C2F56@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE908D1-29A8-4A05-AC16-E3AD480C2F56@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 03:39:04PM -0400, Kyle Moffett wrote:
> On May 30, 2005, at 15:28:26, Andi Kleen wrote:
> >On Mon, May 30, 2005 at 02:04:36PM -0400, Kyle Moffett wrote:
> >>The idea behind these locks is for bigger systems (8-way or more) for
> >>heavily contended locks (say 32 threads doing write() on the same  
> >>fd).
> >
> >Didn't Dipankar & co just fix that with their latest RCU patchkit?
> >(assuming you mean the FD locks)
> 
> That's lock-free FD lookup (open, close, and read/write to a certain
> extent).  I'm handling something more like serialization on a fifo
> accessed in both user context and interrupt context, which in a
> traditional implementation would use a spinlock, but with a spinaphore,
> one could do this:
> 
> In interrupt context:
> 
> spinaphore_lock_atomic(&fifo->sph);
> put_stuff_in_fifo(fifo,stuff);
> spinaphore_unlock(&fifo->sph);
> 
> In user context:
> 
> spinaphore_lock(&fifo->sph);
> put_stuff_in_fifo(fifo,stuff);
> spinaphore_unlock(&fifo->sph);
> 
> If there are multiple devices generating interrupts to put stuff in the
> fifo and multiple processes also trying to put stuff in the fifo, all
> bursting on different CPUs, then the fifo lock would be heavily loaded.
> If the system had other things it could be doing while waiting for the
> FIFO to become available, then it should be able to do those.

If you have lots of concurrent writes, then ordering cannot be guaranteed,
right?  If ordering cannot be guaranteed, why not split the fifo into
multiple parallel streams, and have the writers randomly select one
of the streams?

If a given writer's data must be ordered, one could hash based on the
task-struct pointer for processes, and any convenient pointer for
interrupt context.

That way, you decrease the contention, greatly reducing the spinning and
the context switches.

Or am I missing something here?

							Thanx, Paul
