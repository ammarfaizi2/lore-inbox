Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbUKTGX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbUKTGX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 01:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUKTGX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 01:23:56 -0500
Received: from holomorphy.com ([207.189.100.168]:1923 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262870AbUKTGXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 01:23:51 -0500
Date: Fri, 19 Nov 2004 22:23:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120062341.GM2714@holomorphy.com>
References: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au> <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au> <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au> <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419EDB21.3070707@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> There isn't anything left to explain. So if there's a question, be
>> specific about it.

On Sat, Nov 20, 2004 at 04:50:25PM +1100, Nick Piggin wrote:
> Why am I very very wrong? Why won't touch_nmi_watchdog work from
> the read loop?
> And let's just be nice and try not to jump at the chance to point
> out when people are very very wrong, and keep count of the times
> they have been very very wrong. I'm trying to be constructive.

touch_nmi_watchdog() is only "protection" against local interrupt
disablement triggering the NMI oopser because alert_counter[]
increments are not atomic. Yet even supposing they were made so, the
net effect of "covering up" this gross deficiency is making the
user-observable problems it causes undiagnosable, as noted before.


William Lee Irwin III wrote:
>> This entire line of argument is bogus. A preexisting bug of a similar
>> nature is not grounds for deliberately introducing any bug.

On Sat, Nov 20, 2004 at 04:50:25PM +1100, Nick Piggin wrote:
> Sure, if that is a bug and someone is just about to fix it then
> yes you're right, we shouldn't introduce this. I didn't realise
> it was a bug. Sounds like it would be causing you lots of problems
> though - have you looked at how to fix it?

Kevin Marin was the first to report this issue to lkml. I had seen
instances of it in internal corporate bugreports and it was one of
the motivators for the work I did on pidhashing (one of the causes
of the timeouts was worst cases in pid allocation). Manfred Spraul
and myself wrote patches attempting to reduce read-side hold time
in /proc/ algorithms, Ingo Molnar wrote patches to hierarchically
subdivide the /proc/ iterations, and Dipankar Sarma and Maneesh
Soni wrote patches to carry out the long iterations in /proc/ locklessly.

The last several of these affecting /proc/ have not gained acceptance,
though the work has not been halted in any sense, as this problem
recurs quite regularly. A considerable amount of sustained effort has
gone toward mitigating and resolving rwlock starvation.

Aggravating the rwlock starvation destabilizes, not pessimizes,
and performance is secondary to stability.


-- wli
