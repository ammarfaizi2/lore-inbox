Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVFLLlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVFLLlc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVFLLlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:41:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27916 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261828AbVFLLlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:41:05 -0400
Date: Sun, 12 Jun 2005 13:40:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612114039.GI28759@alpha.home.local>
References: <20050611074350.GD28759@alpha.home.local> <E1DhBic-0005dp-00@gondolin.me.apana.org.au> <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612103020.GA25111@gondor.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 08:30:20PM +1000, Herbert Xu wrote:
> On Sun, Jun 12, 2005 at 10:34:09AM +0200, Willy Tarreau wrote:
> >
> > > Sorry but this patch is pointless.  If I wanted to prevent you from
> > > connecting to www.kernel.org 80 and I knew your source port number
> > > I'd be directly sending you fake SYN-ACK packets which will kill
> > > your connection immediately.
> > 
> > Only if your ACK was within my SEQ window, which adds about 20 bits of
> > random when my initial window is 5840. You would then need to send one
> > million times more packets to achieve the same goal.
> 
> Nope, no sequence validity check is made on the SYN-ACK.

Sorry Herbert, but both RFC793 page 32 figure 9 and my Linux box disagree
with this statement. Look: at line 5, A rejects the SYN-ACK because the
ACK is wrong during the session setup.

And if you send the SYN-ACK on an established session, either it's in the
window in which case the other end will send an RST, or it's outside the
window, in which case the other end will resend an ACK to tell you what
it expects. So I maintain my statement that the SYN-ACK must be within the
window to cause a session reset. That's why I considered cisco's approach
a total bullshit, because they mangled the TCP implementation to protect
against in-window RSTs, but they failed to see that SYN-ACK would do exactly
the same.

I fail to find a case where both the SEQ and the ACK are ignored. This
is why I believe that the simultaneous connect mode introduces a weakness.

Cheers,
Willy

