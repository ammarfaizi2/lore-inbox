Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275980AbRI1IqU>; Fri, 28 Sep 2001 04:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275981AbRI1IqK>; Fri, 28 Sep 2001 04:46:10 -0400
Received: from mons.uio.no ([129.240.130.14]:52684 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S275980AbRI1IqE>;
	Fri, 28 Sep 2001 04:46:04 -0400
To: jstrand1@rochester.rr.com (James D Strandboge)
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: status of nfs and tcp with 2.4
In-Reply-To: <20010927105321.A15128@rochester.rr.com>
	<shssnd88xae.fsf@charged.uio.no>
	<20010927131030.A15669@rochester.rr.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 28 Sep 2001 10:46:26 +0200
In-Reply-To: jstrand1@rochester.rr.com's message of "Thu, 27 Sep 2001 13:10:30 -0400"
Message-ID: <shslmizaejh.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == James D Strandboge <jstrand1@rochester.rr.com> writes:

     > On Thu, Sep 27, 2001 at 05:32:09PM +0200 or thereabouts, Trond
     > Myklebust wrote:
    >> None: AFAIK nobody has yet written any code that works for the
    >> server.

     > In your opinion, how involved would it be to write the tcp code
     > since the udp is already written?  I haven't actually looked
     > into it much, and thought you might have some ideas, or perhaps
     > pointers.

The biggest problem is to prevent the TCP server hogging all the
threads when a client gets congested.

With the UDP code, we use non-blocking I/O and simply drop all replies
that don't get through. For TCP dropping replies is not acceptable as
the client will only resend requests every ~60seconds. Currently, the
code therefore uses blocking I/O something which means that if the
socket blocks, you run out of free nfsd threads...

There are 2 possible strategies:

  1 Allocate 1 thread per TCP connection
  2 Use non-blocking I/O, but allow TCP connections to defer sending
    the reply until the socket is available (and allow the thread to
    service other requests while the socket is busy).

I started work on (2) last autumn, but I haven't had time to get much
done since then. It's on my list of priorities for 2.5.x though, so if
nobody else wants to get their hands dirty I will get back to it...

Cheers,
   Trond
