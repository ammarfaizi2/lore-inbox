Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319284AbSHVDpf>; Wed, 21 Aug 2002 23:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319285AbSHVDpf>; Wed, 21 Aug 2002 23:45:35 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:53004 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S319284AbSHVDpe>; Wed, 21 Aug 2002 23:45:34 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Date: 22 Aug 2002 03:33:18 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ak1m1u$drl$5@abraham.cs.berkeley.edu>
References: <20020818044242.GI21643@waste.org> <Pine.LNX.4.44.0208172151440.1829-100000@home.transmeta.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1029987198 14197 128.32.153.211 (22 Aug 2002 03:33:18 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 22 Aug 2002 03:33:18 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds  wrote:
>If you make /dev/random useless ("but you can use /dev/urandom instead") 
>then we should not have it.

There's a purpose for /dev/random, but it's a special case.
For the common case, /dev/urandom is a much better choice
than /dev/random.  Sadly, the naming was poorly chosen, IMHO;
I feel /dev/urandom ought to be the default choice, and /dev/random
should be only for those who know what they're doing and have
a special need.

The special case where /dev/random is needed is applications
that (1) are managing their own user-level randomness pools,
(2) need forward security, and (3) can't rely on the kernel to
provide the forward security.

In more detail:
  (1) Why would an app want to manage its own randomness pool?
      I don't know, but possibly for better performance.
  (2) Suppose someone breaks into your firewall / IPSec gateway.
      You don't want them to be able to muck through memory and
      deduce all past and future session keys.  The solution?
      Once a day, you collect 128 bits of true randomness and do
      a "catastrophic reseed": you hash them into the pool all at
      once.  Then you can be sure that anyone who breaks into your
      machine won't be able to get more than a day's worth of past
      IPSec keys, and once you kick the hacker off, they won't be
      able to predict more than a day's worth of future keys.
  (3) The kernel should be doing catastrophic reseeding of
      /dev/urandom's pool.  However, if the application manages
      its own randomness pool, it will need to take responsibility
      for doing its own catastrophic reseeding.
If all these conditions are satisfied, the application will need
true randomness, so that it can do its catastrophic reseeding.
But this doesn't seem to be the common case, as far as I can tell.
