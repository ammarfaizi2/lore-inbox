Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279502AbRKFOWO>; Tue, 6 Nov 2001 09:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279382AbRKFOWF>; Tue, 6 Nov 2001 09:22:05 -0500
Received: from ns.ithnet.com ([217.64.64.10]:58891 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279499AbRKFOVy>;
	Tue, 6 Nov 2001 09:21:54 -0500
Date: Tue, 6 Nov 2001 15:21:36 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: torvalds@transmeta.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: out_of_memory() heuristic broken for different mem configurations
Message-Id: <20011106152136.3db4ee73.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.21.0111061015190.9867-100000@freak.distro.conectiva>
In-Reply-To: <20011106143108.6ef304d5.skraw@ithnet.com>
	<Pine.LNX.4.21.0111061015190.9867-100000@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 10:22:02 -0200 (BRST) Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> > How about this really stupid idea: oom means allocs fail, so why not simply
> > count failed 0-order allocs, if one succeeds, reset counter. If a page is
freed
> > reset counter. If counter reaches <new magic number> then you're oom. No
timing
> > involved, which means you can have as much mem or as slow host as you like.
> 
> > It isn't even really interesting, if you have swap or not, because a
> > failed 0-order alloc tells you whatever mem you have, there is surely
> > not much left. 
> 
> Wrong. If we have swap available, we are able to swapout anonymous data,
> so we are _not_ OOM. This is an important point on this whole OOM killer
> nightmare.

I guess this is not the complete picture, either. There may as well be a
situation, where there is nothing to swap out left, but still swap-space
available. Anyway you would be deadlocked in this situation. The only thing you
can see is the failing allocs (and of course no frees). You will never enter
oom-state, if you make "available swap" a negative-trigger. It _sounds_ good,
but _is_ wrong.

> Keep in mind that we don't want to destroy anonymous data from userspace
> (OOM kill).
> 
> > I'd try about 100 as magic number.
> 
> I think your suggestion will work well in practice (except that we have to
> check the swap).
> 
> I'll try that later.
> 
> > > /proc tunable (eeek) ? 
> > 
> > NoNoNo, please don't do that!
> 
> Note that even if your suggestion works, we may want to make the magic
> value /proc tunable.

Well, in fact I really think my suggestion may be better than the current
implementation, but do believe that it is not quite like "42". Whenever you
hear someone talk about magic numbers/limits, keep in mind its only because he
doesn't have the _complete_ answer to the question. I'm in no way different. I
don't like my magic number, only I have no better answer.
> 
> The thing is that the point where tasks should be killed is also an admin
> decision, not a complete kernel decision.

I completely disagree. There can only be two completely independant ways for
this oom stuff:
1) the kernel knows
2) the admin knows

You suggest 2), but then you have to make a totally different approach to the
problem. Because if admin knows, then it's very likely, that he even knows
_which_ application should be killed, or even better, which should _not_ be
killed.
He (the admin) would like to have an option to choose this for sure. You cannot
really solve this idea _inside_ the kernel, I guess. I think this would better
be solved as an oom-daemon with a config-file in /etc, where you tell him,
"whatever is bad, don't kill google". This would be Bens' config file :-)

Regards,
Stephan

 
