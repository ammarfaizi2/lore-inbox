Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVFKGY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVFKGY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 02:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFKGY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 02:24:29 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16908 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261568AbVFKGYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 02:24:21 -0400
Date: Sat, 11 Jun 2005 08:24:13 +0200
From: Willy TARREAU <willy@w.ods.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Unusual TCP Connect() results.
Message-ID: <20050611062413.GA1324@pcw.home.local>
References: <42A9C607.4030209@unixtrix.com> <42A9BA87.4010600@stud.feec.vutbr.cz> <20050610222645.GA1317@pcw.home.local> <20050610.154248.130848042.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610.154248.130848042.davem@davemloft.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Jun 10, 2005 at 03:42:48PM -0700, David S. Miller wrote:
> From: Willy TARREAU <willy@w.ods.org>
> Date: Sat, 11 Jun 2005 00:26:45 +0200
> 
> > It is documented in RFC793 (p30) as the simultaneous connection initation
> > from 2 clients, although this mode has never been implemented by any
> > mainline OS (to my knowledge) as it has no real use and poses security
> > problems (eases spoofing a lot).
> 
> BSD (and thus BSD derivatives) and Linux have has it since
> day one.

Indeed, I've just managed to reproduce the full test with two different
addresses as it's described in p30. I never succeeded to do it before,
perhaps I did not try it the right way. To achieve this, I had to run two
programs doing while(connect()<0). I agree that on high latency networks,
it may make sense to support the feature (eg: mars-earth file transfers).

But on regular uses, I think it's more a problem than a feature, because
it allows any third party to prevent a normal connection establishment
by only knowing the source and destination, which are sometimes easily
guessable (eg: BGP between routers) :

  | A connects to B, C tries to block them by sending lots of SYN at
  | intervals smaller than the latency between A and B, eg 200/s for
  | a 10 ms latency.

  A                                       B (or C)
  ---------------+--------------------------------

                  <- SYN(SEQ=200)         (C sends blind SYN)
                  <- SYN(SEQ=200)         (C sends blind SYN)
  SYN(SEQ=100) -> ...
                  <- SYN(SEQ=200)         (C sends blind SYN)
  SYN(SEQ=101,ACK=201) ->                 (A acknowledges C's SYN)
                  <- SYN(SEQ=300,ACK=101) (B acknowledges A's SYN)
  RST(SEQ=102,ACK=301) ->                 (A rejects B's SYN/ACK)
                  <- RST(SEQ=201,ACK=102) (B rejects A's SYN/ACK)


Maybe it would be useful to have a sysctl option allowing us to disable
this behaviour when it can haev security implications ?

Also, I often test firewalls for such features and never found any one
which allows this. To be more precise, only a previous implementation of
the tcp-window-tracking in Netfilter allowed this but it opened a security
breach that we had to resolve with Jozsef, as it allowed the client to
establish a session by sending the SYN-SYN/ACK-ACK itself...

> I guess it depends upon your definition of
> "mainline OS". :-)

It does not depend on my definition, but on my knowledge, as I put the
condition in the initial mail that you quoted above :-)

Cheers,
Willy

