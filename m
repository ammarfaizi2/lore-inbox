Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVLUQAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVLUQAR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVLUQAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:00:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:23948 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932456AbVLUQAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:00:14 -0500
Date: Wed, 21 Dec 2005 16:59:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
Message-ID: <20051221155934.GB7375@elte.hu>
References: <20051219013718.GA28038@elte.hu> <43A98101.364DB5CF@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A98101.364DB5CF@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> > +__mutex_wakeup_waiter(struct mutex *lock __IP_DECL__)
> > +{
> > +	struct mutex_waiter *waiter;
> > ...
> > +	if (!waiter->woken) {
> > +		waiter->woken = 1;
> > +		wake_up_process(waiter->ti->task);
> > +	}
> 
> Is it optimization? If yes - why? From mutex.h:
> 
> 	- only one task can hold the mutex at a time
> 	- only the owner can unlock the mutex
> 
> So, how can this help?

yes, it's an optimization. I've removed it from the latest queue because 
it didnt trigger all that often, but the optimization is valid: while we 
have a 'waiter in flight', another (fast) task might grab the mutex, and 
might release it - in which case it could attempt to wake up the waiter 
again - which this flag optimizes.

	Ingo
