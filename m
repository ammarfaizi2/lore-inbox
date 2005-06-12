Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVFLOZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVFLOZM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 10:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVFLOYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 10:24:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:38668 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262598AbVFLOYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 10:24:20 -0400
Date: Sun, 12 Jun 2005 16:24:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612142401.GA10772@alpha.home.local>
References: <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133349.GA6279@gondor.apana.org.au> <20050612134725.GB8951@alpha.home.local> <20050612135018.GA10910@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612135018.GA10910@gondor.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 11:50:18PM +1000, Herbert Xu wrote:
> On Sun, Jun 12, 2005 at 03:47:25PM +0200, Willy Tarreau wrote:
> > 
> > Yes, but only if there's an ACK and the ACK is exactly equal to snd_next,
> > so the connection will survive.
> 
> Sorry I wasn't thinking straight.
> 
> > 
> > > My point is that there are many ways to kill TCP connections in ways
> > > similar to what you proposed initially so it isn't that special.
> > 
> > No, there are plenty of ways to kill TCP connections when you can guess
> > the window (which is more and more easy thanks to window scaling). But
> > I have yet found no way to kill a TCP session without this info, except
> > by exploiting the simultaneous connect feature.
> 
> I still stand by this point though.  The most obvious thing I can think
> of right now is to change your attack to simply connect to kernel.org's
> webserver first from source port 10000.  That will cause the real SYN
> packet to fail the sequence number check.

This case is interesting, but it will be resolved in two possible ways :
1) no firewall in front of A
  - C spoofs A and sends a fake SYN to B
  - B responds to A with a SYN-ACK
  - A sends an RST to B, which clears the session
  - A wants to connect and sends its SYN to B which accepts it.

2) A behind a firewall
  - C spoofs A and sends a fake SYN to B
  - B responds to A with a SYN-ACK, which does not reach A (firewall, etc...)
  - A tries to connect to B and sends its SYN with a different SEQ
  - B responds to A with only an ACK (no SYN) indicating the expected SEQ.
  - A responds to B's ACK with an RST and B flushes its session too.
  - A resends its SYN to B which accepts it.
 
Cheers,
Willy

