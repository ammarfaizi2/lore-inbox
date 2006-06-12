Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWFLGjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWFLGjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 02:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWFLGjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 02:39:24 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52678 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751396AbWFLGjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 02:39:23 -0400
Date: Mon, 12 Jun 2006 08:38:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Valdis.Kletnieks@vt.edu,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.17-rc5-mm3-lockdep -
Message-ID: <20060612063807.GA23939@elte.hu>
References: <200606060250.k562oCrA004583@turing-police.cc.vt.edu> <44852819.2080503@gmail.com> <4485798B.4030007@s5r6.in-berlin.de> <4485AFB9.3040005@s5r6.in-berlin.de> <20060607071208.GA1951@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607071208.GA1951@gondor.apana.org.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Tue, Jun 06, 2006 at 04:39:21PM +0000, Stefan Richter wrote:
> > 
> > BTW, the locking in -mm's net/unix/af_unix.c::unix_stream_connect() 
> > differs a bit from stock unix_stream_connect(). I see spin_lock_bh() in 
> > 2.6.17-rc5-mm3 where 2.6.17-rc5 has spin_lock().
> 
> Hi Ingo:
> 
> Looks like this change was introduced by the validator patch.  Any 
> idea why this was done? AF_UNIX is a user-space-driven socket so there 
> shouldn't be any need for BH to be disabled there.

yeah. I'll investigate - it's quite likely that sk_receive_queue.lock 
will have to get per-address family locking rules - right?

Maybe it's enough to introduce a separate key for AF_UNIX alone (and 
still having all other protocols share the locking rules for 
sk_receive_queue.lock) , by reinitializing its spinlock after 
sock_init_data()?

	Ingo
