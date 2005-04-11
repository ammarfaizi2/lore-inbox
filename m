Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVDKHsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVDKHsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVDKHsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:48:18 -0400
Received: from unthought.net ([212.97.129.88]:50092 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261723AbVDKHsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:48:08 -0400
Date: Mon, 11 Apr 2005 09:48:06 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050411074806.GX347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
References: <20050406160123.GH347@unthought.net> <20050406231906.GA4473@sgi.com> <20050407153848.GN347@unthought.net> <1112890671.10366.44.camel@lade.trondhjem.org> <20050409213549.GW347@unthought.net> <1113083552.11982.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113083552.11982.17.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 05:52:32PM -0400, Trond Myklebust wrote:
> lau den 09.04.2005 Klokka 23:35 (+0200) skreiv Jakob Oestergaard:
> 
> > 2.6.11.6: (dual PIII 1GHz, 2G RAM, Intel e1000)
> > 
> >          File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
> >   Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> > ------- ------ ------- --- ----------- ----------- ----------- -----------
> >    .     2000   4096    1  38.34 18.8% 19.61 6.77% 22.53 23.4% 6.947 15.6%
> >    .     2000   4096    2  52.82 29.0% 24.42 9.37% 24.20 27.0% 7.755 16.7%
> >    .     2000   4096    4  62.48 34.8% 33.65 17.0% 24.73 27.6% 8.027 15.4%
> > 
> > 
> > 44MiB/sec for 2.4 versus 22MiB/sec for 2.6 - any suggestions as to how
> > this could be improved?
> 
> What happened to the retransmission rates when you changed to TCP?

tcp with timeo=600 causes retransmits (as seen with nfsstat) to drop to
zero.

> 
> Note that on TCP (besides bumping the value for timeo) I would also
> recommend using a full 32k r/wsize instead of 4k (if the network is of
> decent quality, I'd recommend 32k for UDP too).

32k seems to be default for both UDP and TCP.

The network should be of decent quality - e1000 on client, tg3 on
server, both with short cables into a gigabit switch with plenty of
backplane headroom.

> The other tweak you can apply for TCP is to bump the value
> for /proc/sys/sunrpc/tcp_slot_table_entries. That will allow you to have
> several more RPC requests in flight (although that will also tie up more
> threads on the server).

Changing only to TCP gives me:

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     2000   4096    1  47.04 65.2% 50.57 26.2% 24.24 29.7% 6.896 28.7%
   .     2000   4096    2  55.77 66.1% 61.72 31.9% 24.13 33.0% 7.646 26.6%
   .     2000   4096    4  61.94 68.9% 70.52 42.5% 25.65 35.6% 8.042 26.7%

Pretty much the same as before - with writes being suspiciously slow
(compared to good ole' 2.4.25)

With tcp_slot_table_entries bumped to 64 on the client (128 knfsd
threads on the server, same as in all tests), I see:

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     2000   4096    1  60.50 67.6% 30.12 14.4% 22.54 30.1% 7.075 27.8%
   .     2000   4096    2  59.87 69.0% 34.34 19.0% 24.09 35.2% 7.805 30.0%
   .     2000   4096    4  62.27 69.8% 44.87 29.9% 23.07 34.3% 8.239 30.9%

So, reads start off better, it seems, but writes are still half speed of
2.4.25.

I should say that it is common to see a single rpciod thread hogging
100% CPU for 20-30 seconds - that looks suspicious to me, other than
that, I can't really point my finger at anything in this setup.

Any suggestions Trond?   I'd be happy to run some tests for you if you
have any idea how we can speed up those writes (or reads for that
matter, although I am fairly happy with those).


-- 

 / jakob

