Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVAKVdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVAKVdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVAKVcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:32:36 -0500
Received: from waste.org ([216.27.176.166]:26540 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262870AbVAKV3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:29:13 -0500
Date: Tue, 11 Jan 2005 13:28:23 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111212823.GX2940@waste.org>
References: <20050107221059.GA17392@infradead.org> <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org> <1105475349.4295.21.camel@krustophenia.net> <20050111124707.J10567@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111124707.J10567@build.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 12:47:07PM -0800, Chris Wright wrote:
> Guys, could we please bring this back to a useful discussion.  None of
> you have commented on whether the rlimits for priority are useful.  As I
> said before, I've no real problem with the module as it stands since it's
> tiny, quite contained, and does something people need.  But I agree it'd
> be better to find something that's workable as long term solution.

I almost like it. I don't like that it exposes the internal scheduler
priorities directly (-tiny in fact has options to change these!). So
perhaps some thought could be given to either stratifying it a bit
more (>2000 for SCHED_FIFO, >1000 for SCHED_RR, then SCHED_OTHER) or
separate limits for the different scheduling disciplines. 

Right now, you can make a good argument that SCHED_FIFO > SCHED_RR >
SCHED_OTHER from a privilege point of view, but that could change if
we add a pseudo-RT scheduling class of some sort. Similarly, adding a
discipline means adding an rlimit with the split approach, so that's
not very friendly either.

Another way:

0-20: normal nice values (inverted)
>20: privilege to set any RT priority

Limiting to below normal nice is a little weird and the offset to make
everything positive is weird as well. Above 20, any RT app can starve
SCHED_OTHER and it's less important to dole out fine-grained levels
here as these apps must be engineered to cooperate to some degree
anyway.

But I'm also still not convinced this policy can't be most flexibly
handled by a setuid helper together with the mlock rlimit.

-- 
Mathematics is the supreme nostalgia of our time.
