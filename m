Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWANNib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWANNib (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWANNib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:38:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:4061 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932441AbWANNib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:38:31 -0500
Date: Sat, 14 Jan 2006 14:38:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Jes Sorensen <jes@trained-monkey.org>, Greg KH <greg@kroah.com>
Subject: Re: [patch 00/62] sem2mutex: -V1
Message-ID: <20060114133840.GA4038@elte.hu>
References: <20060113124402.GA7351@elte.hu> <200601131925.34971.ioe-lkml@rameria.de> <20060113195658.GA3780@elte.hu> <200601141416.20055.ioe-lkml@rameria.de> <1137245466.3014.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137245466.3014.20.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> That case is the simple (and most common) case. Since it uses down() 
> only, it can't be irq context. (trylock could be a sign of irq context 
> use), and all up()'s are 1) not in irq context either because they're 
> in the same function as the down() which isn;t and 2) perfectly 
> matched to the down(), eg each down gets one up ---> perfect 
> semaphore.

one of the most frequent exceptions to the 'up in a separate function' 
rule are seqfile implementations, which all have start(), mid(), stop() 
methods, where start() does the down(), stop() does the up(). These can 
still be converted to mutexes (and i converted a couple of them), after 
manual review.

> The other case on the other side of the spectrum is a down in one 
> function and an up in an irq function. Which is a pretty good sign of 
> a completion.... (same is true for a specific scenario where kernel 
> thread creation is involved and the up() is done in the just created 
> thread).

another good sign of completion type of semaphores is the use of 
DECLARE_MUTEX_LOCKED(), init_MUTEX_LOCKED(), or sema_init(&sem, 0). In 
95% of these cases these signal semaphores used as completions. That is 
one reason why i did not add DEFINE_MUTEX_LOCKED(), nor 
mutex_init_locked() to the mutex APIs.

the 'struct work' conversion is rare, i've only seen it in XFS so far.

	Ingo
