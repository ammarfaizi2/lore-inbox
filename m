Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319062AbSH1X5e>; Wed, 28 Aug 2002 19:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319063AbSH1X5e>; Wed, 28 Aug 2002 19:57:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40714 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319062AbSH1X5d>; Wed, 28 Aug 2002 19:57:33 -0400
Date: Wed, 28 Aug 2002 17:08:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dominik Brodowski <devel@brodo.de>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <1030577406.7190.89.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Aug 2002, Alan Cox wrote:
> 
> So what you are saying is that you want to be sure that something like
> "please run at a low speed to save battery" is translated by smarter
> cpus into "please save battery" and on spudstop the CPU would go "umm
> duh ok 300MHz"

Yup, exactly.

I suspect that this is also what most people actually want to use anyway:  
you don't care that your CPU is a speedstep 1GHz/500Mhz or a 700/300 (or
whatever the combinations are), you really want to just say "go to power
save mode" vs "go to performance mode".

Sure, for speedstep, you can obviously trivially _emulate_ this in user 
mode with the frequency approach, but for the generic case it isn't.

I don't know how many policies would be needed (too many just adds 
complexity for no gain), but I _suspect_ that something like a 

 { min-Hz, max-Hz, policy }

triple with "policy" being just a few different values ("performance",
"powersave") is sufficient. Clearly this triple trivially _becomes_ the
"single MHz" by just making min and max be the same if you really want one
particular MHz (at which time "policy" doesn't matter).

With something like the above, you could do something like

	{ 0, ~0UL, "performance" }	=> generic highest performance setting
	{ 0, ~0UL, "power-save" }	=> generic power-save setting
	{ 300, 500, "performance" }	=> give me a performance setting in the specified range
	{ 1700, 1700, "performance" }	=> run at a fixed 1.7GHz

(maybe the "policy" thing actually makes a difference even for the
fixed-frequency case: it can give hints about whether to allow C1-C3
states when idle etc).

		Linus

