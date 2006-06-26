Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWFZXAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWFZXAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWFZXAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:00:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4560 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933278AbWFZWkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:24 -0400
Date: Tue, 27 Jun 2006 00:35:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel@vger.kernel.org, arjan@linux.intel.com, pavel@suse.cz,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
Message-ID: <20060626223526.GA18579@elte.hu>
References: <1151060089.30819.2.camel@lappy> <20060626095702.8b23263d.akpm@osdl.org> <Pine.LNX.4.64.0606261009190.3747@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606261009190.3747@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> I totally re-organized how execve() allocates the new mm at an execve 
> several years ago (it used to re-use the old MM if it could), and that 
> was so that we count just remove the brpm->page array, and just 
> install the pages directly into the destination.
> 
> That was in 2002. I never actually got around to doing it ;(.

i thought about your "map execve pages directly into target" (since the 
source gets destroyed anyway) suggestion back then, and unfortunately it 
gets quite complex.

Firstly, if setenv is done and the array of strings gets larger, glibc 
realloc()s it and the layout of the environment gets 'fragmented'. 
Ulrich was uneasy about passing a fragmented environment to the target 
task - it's not sure that no app would break. Secondly, for security 
reasons we have to memset all the memory around fragmented strings. So 
we might end up doing _alot_ of memsetting in some cases, if the string 
space happens to be fragmented. So while the current method is slow and 
uses persistent memory, it at least "compresses" the layout of the 
environment (and arguments) at every exec() time and thus avoids these 
sorts of problems.

And this is a real problem for real applications and is being complained 
about alot by shops that do alot of development and have scrips around 
large filesystem hierarchies. (and who got used to their scripts working 
on other unices just fine)

Lets at least give root the chance to increase this limit and go with 
the dumb and easy patch i posted years ago. It worked just fine - and 
it's not like root cannot cause lots of persistent memory to be 
allocated by processes: for example by setting the per-socket wmem limit 
to 10MB. Please? I personally run into this stupid limit every couple of 
days during development while working with the kernel tree, just do a 
simple thing like in the kernel tree's top directory:

 $ ls -lS `find .`
 -bash: /bin/ls: Argument list too long

The phrase "that ridiculous 128K limit" often comes to my mind :-|

	Ingo
