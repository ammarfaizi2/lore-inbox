Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVFLNrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVFLNrp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVFLNro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:47:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:37132 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262320AbVFLNrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:47:41 -0400
Date: Sun, 12 Jun 2005 15:47:25 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612134725.GB8951@alpha.home.local>
References: <E1DhBic-0005dp-00@gondolin.me.apana.org.au> <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133349.GA6279@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612133349.GA6279@gondor.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 11:33:49PM +1000, Herbert Xu wrote:
> On Sun, Jun 12, 2005 at 11:13:23PM +1000, herbert wrote:
> > On Sun, Jun 12, 2005 at 02:32:53PM +0200, Willy Tarreau wrote:
> > >
> > > but it's not the case (although the naming is not clear). So if the remote
> > > end was the one which sent the SYN-ACK, it will clear its session. If it has
> > > been spoofed, it will ignore the RST because in turn, the SEQ will not be
> > > within its window.
> > 
> > This is what should happen:
> 
> Sorry, you're right.  The SEQ check should catch this.

No problem. Fortunately, this part of the code is *very well* documented :-)

> However, a few lines down in that same function there is a th->rst
> check which will kill the connection just as effectively.

Yes, but only if there's an ACK and the ACK is exactly equal to snd_next,
so the connection will survive.

> My point is that there are many ways to kill TCP connections in ways
> similar to what you proposed initially so it isn't that special.

No, there are plenty of ways to kill TCP connections when you can guess
the window (which is more and more easy thanks to window scaling). But
I have yet found no way to kill a TCP session without this info, except
by exploiting the simultaneous connect feature.

My point was that it would not be too difficult to remotely prevent an
anti-virus or IDS from downloading its updates when you know the update
site's address and you know that by default it uses source ports
1024-4999 to connect outside. I don't really care for BGP however
because people should use MD5 or they get what they deserve.

Cheers,
Willy

