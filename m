Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316958AbSF0Unh>; Thu, 27 Jun 2002 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316960AbSF0Ung>; Thu, 27 Jun 2002 16:43:36 -0400
Received: from pat.uio.no ([129.240.130.16]:54675 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S316958AbSF0Une>;
	Thu, 27 Jun 2002 16:43:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: kuznet@ms2.inr.ac.ru
Subject: Re: Fragment flooding in 2.4.x/2.5.x
Date: Thu, 27 Jun 2002 22:45:45 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200206272005.AAA16804@sex.inr.ac.ru>
In-Reply-To: <200206272005.AAA16804@sex.inr.ac.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206272245.45505.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 June 2002 22:05, kuznet@ms2.inr.ac.ru wrote:

> static void
> udp_write_space(struct sock *sk)
> {
<snip>
> 	/* Wait until we have enough socket memory. */
> 	if (sock_writeable(sk))
> 		return;

You misunderstand the code. The above is in the write_space() callback. It 
tells you when it is safe to wakes up again *after* a send has failed. It 
doesn't test the buffer size on the first sendmsg() call (the one that 
fails).

> The thing, which is really useless, is that your patch preparing skbs
> and dropping them in the next line. With the same success you could
> trigger BUG() there. :-) Right application just should not reach
> this condition.

Are you seriously saying that all 'right' user applications should be testing 
the socket buffer congestion before sending a non-blocking UDP message rather 
than just testing sendmsg() for an EWOULDBLOCK return value???
According to the manpage, ioctl(SIOCOUTQ) didn't even work prior to 2.4.x...

The normal behaviour of the patch was to collect the fragments, then to send 
off all the skbs to the device queue as soon as it is clear that no errors 
have occurred.

The patch only dropped the skbs if some socket error occurs that would force 
you to exit the loop and return EAGAIN. Since the loop will be exited before 
the fragment containing the UDP header (offset 0) gets sent, sending off all 
the other fragments in the other skbs would serve merely to eat up bandwidth.

I agree that for blocking calls, it is useful to send off each skb as it gets 
allocated (and the patch could be amended to take this into account), but for 
nonblocking I/O, it is definitely bad form...

Cheers,
  Trond
