Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbSJDQ7o>; Fri, 4 Oct 2002 12:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSJDQ7Z>; Fri, 4 Oct 2002 12:59:25 -0400
Received: from pat.uio.no ([129.240.130.16]:145 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262492AbSJDQ7J>;
	Fri, 4 Oct 2002 12:59:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15773.51748.415514.975150@charged.uio.no>
Date: Fri, 4 Oct 2002 19:04:36 +0200
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2) 
In-Reply-To: <27452.1033748255@warthog.cambridge.redhat.com>
References: <trond.myklebust@fys.uio.no>
	<15773.48067.804268.678391@charged.uio.no>
	<27452.1033748255@warthog.cambridge.redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Howells <dhowells@cambridge.redhat.com> writes:

     > There appears to be more to it than that. RxRPC has sequencing
     > and ACKing windows and things that I don't think SUNRPC has
     > (basically it tries to do some of TCP itself). I've attached
     > the struct definitions for the RxRPC header and the ACK packet
     > body from my RxRPC implementation for your reference.

The 'socket protocol' stuff already copes with UDP w/ congestion
control + TCP. It will eventually do SCTP and IPv6 when we get down to
it all.
Fitting UDP w/ sequencing+acking as an extra protocol should be
possible, and in fact support for sequencing is needed anyway for
the security code in RPCSEC_GSS.

The nice thing about the SunRPC code is that it provides a generic
engine for sending and receiving messages asynchronously. For the
client, the SunRPC specific stuff is almost all in
net/sunrpc/clnt.c. If you write a replacement for that in order to
deal with the RxRPC quirks, you should still be able to make use of
rpciod and the socket + auth code.

Ditto for the server stuff: nobody forces you to use svc_process to
interpret the RPC headers.

     > Furthermore, RxRPC allows for big binary blobs to be
     > interpolated in the middle of packets (though if I understand
     > it correctly it effectively encodes them as an XDR octet array
     > of sorts).

The RPC layer doesn't worry too much about the contents of the data
you send. We're already interpolating pages into our RPC messages...

Cheers,
  Trond
