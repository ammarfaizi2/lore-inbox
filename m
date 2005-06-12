Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVFLPDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVFLPDG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVFLPDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:03:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40460 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262620AbVFLPDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:03:01 -0400
Date: Sun, 12 Jun 2005 17:02:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Thomas Graf <tgraf@suug.ch>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
       xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612150239.GA10865@alpha.home.local>
References: <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133654.GA8951@alpha.home.local> <20050612144426.GC22463@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612144426.GC22463@postel.suug.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 04:44:26PM +0200, Thomas Graf wrote:
> * Willy Tarreau <20050612133654.GA8951@alpha.home.local> 2005-06-12 15:36
> > > The RST packet is sent by client A using its sequence numbers.  Therefore
> > > it will pass the sequence number check on server B.
> > >
> > > 4) server B resets the connection.
> > 
> > No, precisely the RST sent by A will take its SEQ from C's ACK number.
> > This is why B will *not* reset the connection (again, tested) if C's ACK
> > was not within B's window.
> 
> Absolutely but it relies on the other stack being correctly implemented.
> The attack would work perfectly fine if there wasn't the rule that a RST
> must not be sent in response to another RST.

Of course, if you target a buggy stack, you can expect anything.

> The attack has been successful and still is because some firewalls
> are configured to send RSTs without respecting this rule.

In fact, I voluntarily did not speak about firewalls because almost all
of them are very sensible to TCP DoSes. First of all, all those which
don't check sequence numbers will blindly kill a session when they
receive an RST. And some of the other ones will not let certain ACK
packets pass through, which will make other DoS described in this
thread effective while it should not be, by not letting the server
tell the client to reset its session when really needed.

> I like your patch and the idea behind it, it can successfully defeat the
> most simple method of preventing connections being established.

That's what I thought, too. I have another one for 2.4.31 which only adds
a CONFIG option to remove the associated code, which reduces the image by
400 bytes.

Cheers,
Willy

