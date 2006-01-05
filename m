Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752273AbWAEW7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbWAEW7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbWAEW7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:59:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17797 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752273AbWAEW7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:59:07 -0500
Date: Thu, 5 Jan 2006 23:55:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060105225513.GA1570@elte.hu>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <20060105213442.GM3356@waste.org> <Pine.LNX.4.64.0601051402550.3169@g5.osdl.org> <20060105223656.GP3356@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105223656.GP3356@waste.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Mackall <mpm@selenic.com> wrote:

> > I don't believe it is actually all _that_ volatile. Yes, it would be a 
> > huge issue _initially_, but the incremental effects shouldn't be that big, 
> > or there is something wrong with the approach.
> 
> No, perhaps not. But it would be nice in theory for people to be able 
> to do things like profile their production system and relink. And 
> having to touch hundreds of files to do it would be painful.

we can (almost) do that: via -ffunction-sections. It does seem to work 
on both the gcc and the ld side. [i tried to use this for --gc-sections 
to save more space, but that ld option seems unstable, i couldnt link a 
bootable image. -ffunction-sections itself seems to work fine in gcc4.]

i think all that is needed to reorder the functions is a build-time 
generated ld script, which is generated off the 'popularity list'.

so i think the two concepts could nicely co-exist: in-source annotations 
help us maintain the popularity list, -ffunction-sections allows us to 
reorder at link time. In fact such a kernel could be shipped in 
'unlinked' state, and could be relinked based on per-system profiling 
data. As long as we have KALLSYMS, it's not even a big debuggability 
issue.

the branch-likelyhood thing is a separate issue from function-cohesion, 
but could be handled by the same concept: if there was a 
--ffunction-unlikely-sections option in gcc (there's none currently, 
AFAICS), then those could be reordered in a smart way too. (We wouldnt 
get the 8-byte relative jumps back though, gcc would always have to 
assume that the jump is far away.)

	Ingo
