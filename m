Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274851AbRJQHVP>; Wed, 17 Oct 2001 03:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274951AbRJQHVF>; Wed, 17 Oct 2001 03:21:05 -0400
Received: from pat.uio.no ([129.240.130.16]:43166 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S274851AbRJQHUu>;
	Wed, 17 Oct 2001 03:20:50 -0400
To: "Shirish Kalele" <kalele@veritas.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Fw: NFSD over TCP: TCP broken?
In-Reply-To: <013601c156f9$e0a35310$3291b40a@fserv2000.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Oct 2001 09:19:21 +0200
In-Reply-To: "Shirish Kalele"'s message of "Wed, 17 Oct 2001 03:52:55 -0700"
Message-ID: <shsd73mlona.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Shirish Kalele <kalele@veritas.com> writes:

    >> Hi,

    >> Looking at the network traces, it looks like the RPC records
    >> being sent
     > over
    >> TCP are inconsistent with the lengths specified in the record
    >> marker. This happens mainly when 3-4 requests arrive one after
    >> the other and you have
     > 3-4
    >> threads replying to these requests in parallel. It looks like
    >> TCP gets hopelessly confused and botches up the replies being
    >> sent. I point my
     > finger
    >> at TCP because tcp_sendmsg returns a valid length indicating
    >> that the
     > entire
    >> reply was accepted, but the tcp sequence numbers show that the
    >> RPC record sent on the wire wasn't equal to the length accepted
    >> by TCP. After a
     > while,
    >> the client realizes it's out of sync when it gets an invalid
    >> RPC record marker, and resets and reconnects. This repeats
    >> multiple times.

This is normal. Nobody has fixed the RPC server code. There are plenty
of possible sources of the above problem, but my main suspect is the
fact that the TCP reply code uses blocking socket operations (will
change once we actually go in for supporting TCP), but doesn't provide
any mechanism for preventing another thread from using the socket
while the original writer is sleeping.

Fix: Set up a semaphore in the struct svc_sock somewhere, and use it
to gate write acces to the socket...

Cheers,
  Trond
