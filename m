Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVB1O3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVB1O3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVB1O1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:27:13 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:24777 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261491AbVB1OZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:25:38 -0500
Date: Mon, 28 Feb 2005 15:25:51 +0100
From: Thomas Graf <tgraf@suug.ch>
To: jamal <hadi@cyberus.ca>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, marcelo.tosatti@cyclades.com,
       "David S. Miller" <davem@redhat.com>, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-ID: <20050228142551.GQ31837@postel.suug.ch>
References: <4221E548.4000008@ak.jp.nec.com> <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com> <1109575236.8549.14.camel@frecb000711.frec.bull.fr> <20050227233943.6cb89226.akpm@osdl.org> <1109592658.2188.924.camel@jzny.localdomain> <20050228132051.GO31837@postel.suug.ch> <1109598010.2188.994.camel@jzny.localdomain> <20050228135307.GP31837@postel.suug.ch> <1109599803.2188.1014.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109599803.2188.1014.camel@jzny.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal <1109599803.2188.1014.camel@jzny.localdomain> 2005-02-28 09:10
> On Mon, 2005-02-28 at 08:53, Thomas Graf wrote:
> > * jamal <1109598010.2188.994.camel@jzny.localdomain> 2005-02-28 08:40
> > > 
> > > netlink broadcast or a wrapper around it.
> > > Why even bother doing the check with netlink_has_listeners()?
> > 
> > To implement the master enable/disable switch they want. The messages
> > don't get send out anyway but why bother doing all the work if nothing
> > will get send out in the end? It implements a well defined flag
> > controlled by open/close on fds (thus handles dying applications)
> > stating whether the whole code should be enabled or disabled. It is of
> > course not needed to avoid sending unnecessary messages.
> 
> To justify writting the new code, I am assuming someone has actually sat
> down and in the minimal stuck their finger in the air
> and said "yes, there is definetely wind there".

I did, not for this problem though. The code this idea comes from sends
batched events of skb passing points to userspace. Not every call
invokes has_listeneres() but rather the kernel thread processing the
ring buffer sending the events to userspaces does. The result is
globally cached in a atomic_t making it possible to check for it at
zero-cost and really saving time and effort. I have no clue wether it
does make sense in this case I just pointed out how to do it properly
at my point of view.

> Which leadsto Marcello's question in other email:
> Theres some overhead. 
> - Message needs to be built with skbs allocated (not the cn_xxx thing
> that seems to be invoked - I suspect that thing will build the skbs);
> - the netlink table needs to be locked 
> -and searched and only then do you find theres nothing to send to. 
> 
> The point i was making is if you actually had to post this question,
> then you must be running into some problems of complexity ;->
> which implies to me that the delta overhead maybe worth it compared to
> introducing the complexity or any new code.
> I wasnt involved in the discussion - I just woke up and saw the posting
> and was bored. So the justification for the optimization has probably
> been explained and it may be worth doing the check (but probably such
> check should go into whatever that cn_xxx is).

I wasn't involved in the discussion either.

Using rtmsg_ifinfo as example, the check should probably go in straight
at the beginning _IFF_ rtmsg_ifinfo was subject to performance overhead
which obviously isn't the case but just served as an example.
