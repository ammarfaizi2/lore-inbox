Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276329AbRJCObu>; Wed, 3 Oct 2001 10:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276328AbRJCObk>; Wed, 3 Oct 2001 10:31:40 -0400
Received: from pat.uio.no ([129.240.130.16]:47252 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S276327AbRJCObd>;
	Wed, 3 Oct 2001 10:31:33 -0400
MIME-Version: 1.0
Message-ID: <15291.8540.950034.832350@charged.uio.no>
Date: Wed, 3 Oct 2001 16:31:56 +0200
To: jstrand1@rochester.rr.com (James D Strandboge)
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: status of nfs and tcp with 2.4
In-Reply-To: <20011003083326.A12840@rochester.rr.com>
In-Reply-To: <20010927105321.A15128@rochester.rr.com>
	<shssnd88xae.fsf@charged.uio.no>
	<20010927131030.A15669@rochester.rr.com>
	<shslmizaejh.fsf@charged.uio.no>
	<20011003083326.A12840@rochester.rr.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == James D Strandboge <jstrand1@rochester.rr.com> writes:

     > By 'when a client gets congested' my understanding is you mean
     > 'when a client is sending a lot to the server, and the server
     > can't respond quickly enough.'  Therefore, dropping udp replies

There are several scenarios. The one that worries me most on TCP
connections is when the TCP socket on the server gets swamped for some
reason, and the call to sendmsg() sleeps. This means that if one
client has fired off a load of requests, and then doesn't listen for
the reply, we can end up sleeping for a long time (and being
unavailable to other clients).

OTOH under UDP, we use nonblocking I/O, so the sendmsg() returns, and
the server can just drop the request (as the UDP allows for quick
resends). The thread in this scenario therefore never sleeps if a
client is unavailable. It can only sleep on (relatively fast) disk
I/O.


     > is ok, since the client will just send it again, however, with
     > tcp, the client will only resend every 60 seconds and that is
     > too slow, and it blocks the socket in the meantime.  Is my
     > understanding correct?

That is correct. TCP is designed to be a reliable protocol, so clients
are allowed to assume that the server will reply to a request once it
has been sent.

    >> There are 2 possible strategies:
    >>
    >> 1 Allocate 1 thread per TCP connection

     > This seems to be the easier of the two to implement, however
     > you opted against this because we are putting an eventual limit
     > on the number of clients we can serve based on NFSD_MAXSERVS.
     > Is this correct?

Well... Thread limits can be changed. My main objection is that it is
ugly. Why allocate a thread when what you want to do is to be able to
cope with sleeping? We have non-blocking I/O, and the tcp
'write_space()' socket routine (see the client use in
net/sunrpc/xprt.c) that was designed to enable a thread to get called
back once a socket is free.

    >> 2 Use non-blocking I/O, but allow TCP connections to defer
    >> sending the reply until the socket is available (and allow the
    >> thread to service other requests while the socket is busy).
    >>
    >> I started work on (2) last autumn, <snip>

     > Are there patches for this that I could look at?

  http://www.fys.uio.no/~trondmy/src/pre_alpha/linux-2.4.0-test6-rpctcp.dif

It's a patch against linux-2.4.0-test6 and is basically at the 'toy'
stage. Definitely nowhere near ready for release. IIRC though it did
actually run fairly reliably.

Cheers,
   Trond
