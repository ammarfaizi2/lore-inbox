Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVLUQDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVLUQDI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVLUQDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:03:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49293 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932470AbVLUQDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:03:06 -0500
Date: Wed, 21 Dec 2005 17:02:23 +0100
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
Message-ID: <20051221160223.GC7375@elte.hu>
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

> > +start_mutex_timer(struct timer_list *timer, unsigned long time,
> > +		  unsigned long *expire)
> > +{
> > +	*expire = time + jiffies;
> > +	init_timer(timer);
> > +	timer->expires = *expire;
> > +	timer->data = (unsigned long)current;
> > +	timer->function = process_timeout;
> > +	add_timer(timer);
> > +}
> 
> How about
> 	setup_timer(&timer, process_timeout, (unsigned long)current);
> 	__mod_timer(&timer, *expire);
> ?

i've removed the timer code from the latest queue - because it's unused 
and we can add it back later. But you are right, it was racy (Arjan 
noticed the signal race too), because this codepath in -rt relied on 
guaranteed lock-passing. (while mutex.c does a trylock)

	Ingo
