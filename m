Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268244AbTCFRrL>; Thu, 6 Mar 2003 12:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268245AbTCFRrL>; Thu, 6 Mar 2003 12:47:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16649 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268244AbTCFRrJ>; Thu, 6 Mar 2003 12:47:09 -0500
Date: Thu, 6 Mar 2003 09:55:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <1046976597.17715.93.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303060949120.7720-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Mar 2003, Alan Cox wrote:
> 
> X isnt special at all. Research OS people have done stuff like time transfers
> but I've not seen that in a production OS. In that situation an interactive
> task blocking on a server hands on some of its interactiveness to whoever
> services the request.

This is what I really wanted to do - give the interactivity away at 
blocking time. However, there's usually no sane way to do that, since we 
don't know a-priori who we are blocking _for_. We could try to transfer it 
in the unix domain socket sleep case to whoever is waiting at the other 
end, but that's actually quite complex and ends up having each sleep entry 
somehow inform the subsystem it is sleeping on that it wants to give 
interactivity to the other end.

The thing about wakeups is that it's an "illogical" place to give the 
bonus ("it's too late to give the server a bonus _now_, I wanted it when I 
went to sleep"), but it's the _trivial_ place to give it.

It also (I'm convinced) is actually in the end exactly equivalent to 
giving the bonus at sleep time - in the steady state picture. In the 
single-transfer case it is wrong, but the single transfer case doesn't 
matter - the interactivity bonus isn't a "immediate shot of caffeine into 
the bloodstream" anyway. The interactivity bonus is supposed to help over 
time, so the only thing that matters is really the steady state.

But the proof is in the pudding. Does this actually make things appear 
"nicer" to people? Or is it just another wanking session?

		Linus

