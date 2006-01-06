Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWAFA6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWAFA6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWAFA6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:58:18 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:19867 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932360AbWAFA6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:58:15 -0500
Date: Fri, 6 Jan 2006 01:54:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Matt Mackall <mpm@selenic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060106005444.GA23252@elte.hu>
References: <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org> <20060105233049.GA3441@elte.hu> <Pine.LNX.4.64.0601051548290.3169@g5.osdl.org> <20060106001519.GA15520@elte.hu> <Pine.LNX.4.64.0601051626290.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601051626290.3169@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > Especially if there enough profiling hits, it's usually a quick glance 
> > to figure out the hotpath:
> 
> Ehh. What's a "quick glance" to a human can be quite hard to automate.  
> That's my point.
> 
> If we do the "human quick glances", we won't be seeing much come out 
> of this. That's what we've already been doing, for several years.
> 
> I thought the discussion was about trying to automate this..

i think it could be automated reasonably well. An 80% effective "which 
condition is judged incorrectly" decision could be made based on:

  branch instruction with more than 10% of the average per-instruction 
  cycle count, followed by an at least 4-instruction sequence of 
  non-branch (and non-jump) instructions that have exactly zero 
  profiling hits. ('few hits' we are not interested in - those are not 
  likely/unlikely candidates)

another part is to feed this back into .c, automatically. I've done 
DEBUG_INFO, gdb vmlinux and list *0x12341234 based scripts before, but 
they are not always reliable. They could probably do something like: "if 
the resulting source code contains a clear 'if (' sequence, modify it to 
'if __unlikely (', or something like that.

i'd expect such a method to catch ~50-60% of the interesting cases, not 
more. (the rest would be stuff the heuristics doesnt catch, and it would 
also be stuff like 'while' or 'break' or 'goto', which are much harder 
to rewrite automatically.

but it does feel quite a bit fragile.

	Ingo
