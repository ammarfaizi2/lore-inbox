Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWGMTxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWGMTxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWGMTxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:53:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:487 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030331AbWGMTxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:53:13 -0400
Date: Thu, 13 Jul 2006 21:47:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Albert Cahalan <acahalan@gmail.com>,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: Re: utrace vs. ptrace
Message-ID: <20060713194735.GA27807@elte.hu>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> <200607131437.28727.ak@suse.de> <20060713124316.GA18852@elte.hu> <200607131521.52505.ak@suse.de> <Pine.LNX.4.64.0607131203450.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607131203450.5623@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > Mostly because I fear it would become another udev like disaster, 
> > requiring user space updates regularly, and core dumps are a fairly 
> > critical debugging feature that I wouldn't like to become 
> > unreliable.
> 
> Doing core-dumping in user space would be insane. It doesn't give 
> _any_ advantages, only disadvantages.

well, it was just a quick idea of mine that looked nice in the following 
sense: it would reuse (and thus test) debugging infrastructure that we 
want to and have to provide anyway. (if gdb is attached to a task that 
crashes then it is in a position to get all the information to create a 
coredump)

it wouldnt be fundamentally easier - but lots of policy stuff could be 
done there which we would otherwise reject to add to the kernel. Like 
more complex rules for "do we want to dump core for this particular 
app".

> Why do people keep thinking that doing things in user space is "safer" 
> and "easier". It's quite often not. For example, all the "fragile" 
> stuff would be true for a user-space dumper (don't tell me it's safer 
> - it would obviously have to run with elevated capabilities), and a 
> lot of it would be a hell of a lot harder.

It would have to run with privileges enough to 1) get the process/thread 
state [but not set it] 2) to write the resulting coredump to some file.

You are right that if we make it privileged enough to implement #2 as 
"put the coredump into the apps cwd, with the user's identity", that 
would expose this privileged code to similar file-permission security 
problems as the in-kernel dumper.

But if #2 is implemented in a more restricted way (like coredumps only 
go to a central directory not accessible to users, are size-limited, are 
fingerprinted for their backtraces to remove duplicates, are matched to 
an online repository of already reported bugs, etc.) then it could be 
more secure than the in-kernel dumper - just because it would do less. 
(and it would also do more, in a sense)

but ... i agree that it's not an "obvious win", and that it can create a 
less secure solution than the in-kernel dumper. Although the in-kernel 
dumper doesnt have a stellar security track record, so the quality bar 
isnt particularly high :-/

	Ingo
