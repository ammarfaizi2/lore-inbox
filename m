Return-Path: <linux-kernel-owner+w=401wt.eu-S1752963AbWL2M54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbWL2M54 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbWL2M5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:57:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41900 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872AbWL2M5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:57:54 -0500
Date: Fri, 29 Dec 2006 13:54:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>
Subject: Re: [take29 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061229125427.GA23893@elte.hu>
References: <3154985aa0591036@2ka.mipt.ru> <11668927001365@2ka.mipt.ru> <20061228160137.GA19301@elte.hu> <20061229085503.GB13816@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229085503.GB13816@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> On Thu, Dec 28, 2006 at 05:01:37PM +0100, Ingo Molnar (mingo@elte.hu) wrote:
> > 
> > * Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > 
> > > Generic event handling mechanism.
> > 
> > i see it covers alot of event sources, but i cannot see block IO 
> > notifications. Am i missing something?
> 
> Depending on what it is :) If you mean kevent based AIO, then it was 
> dropped to reduce size of the patchset, and in favour of new AIO 
> design.

yes, kevent based AIO. Could you please re-add it, preferably ontop of 
Suparna's AIO patchset? I dont see how a "generic event handling 
mechanism" can exclude block IO because we really need to see how it 
plugs into (and plays along with) block AIO and how it performs relative 
to block AIO to be able to judge whether this API and infrastructure 
should be included in the kernel in its current form.

> Other kinds of read/write notifications can be handled by poll/select 
> notifications.

but poll/select notifications are just a second-degree way of doing an 
IO state machine, and they are mostly there in kevents for completeness 
and compatibility.

To be able to judge a "generic" event mechanism it really must support 
block IO as well, natively. Without that we'd have the following obscene 
API situation:

 - poll()/select(): supports everything but is slow and inaccurate
 - epoll(): more modern API ontop of poll notifications
 - async IO: supports block IO
 - kevent supports almost everything /except/ block IO

so what we need is for kevents to support /all/ the important 
high-performance event types natively:

 - networking
 - block IO
 - VFS namespace
 - timers

(rarer things like mouse/input events can stay with poll notifications)

and it is /especially/ important to include block IO events in kevents 
to be able to judge its performance and scalability relative to the 
async IO API and infrastructure.

	Ingo
