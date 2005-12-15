Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbVLOF7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbVLOF7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbVLOF7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:59:37 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:40885 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1161139AbVLOF7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:59:36 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [andrea@cpushare.com: Re: disable tsc with seccomp]
Date: Thu, 15 Dec 2005 05:59:19 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dnr0nn$969$1@taverner.CS.Berkeley.EDU>
References: <20051213053836.GY3092@opteron.random>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1134626359 9417 128.32.168.222 (15 Dec 2005 05:59:19 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Thu, 15 Dec 2005 05:59:19 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli  wrote:
>I take the opportunity of this reminder email, to ask one more question
>about the /dev/urandom device.  It would be really nice to have a good
>random number generator in CPUShare-seccomp mode, so I'm considering
>changing the CPUShare sell client to open /dev/urandom in O_RDONLY mode
>before firing seccomp.  However such a change means the urandom device
>driver will have to be secure in the way it creates the buffer [...]

What you suggest seems reasonable.  I guess I'm not qualified to take
any position on the specific question you asked.  However, I thought I'd
add a third option, that you could consider (though please don't consider
this as a criticism of any of your proposals).

The third option: When the seccomp-restricted program is spawned, the
parent could read 16 bytes from /dev/urandom, then communicate that
16-byte value to the seccomp-restricted child.  The child could then use
that as a seed to its own cryptographic pseudorandom generator, and could
generate all the pseudorandom values it needs starting from that seed,
without needing to interact with the OS or with /dev/urandom at all.
Expanding a short 16-byte seed into a long stretch of cryptographically
pseudorandom data only requires computation, so you can already support
this in today's seccomp, if I understand correctly how seccomp works.

Note that this option does not require SSL, and does not require
communicating the random bits across the Internet (which seems like a
questionable practice), so this is much safer than having someone on
the other side of the Internet pick your random numbers for you.
