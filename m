Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbRGMOH0>; Fri, 13 Jul 2001 10:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbRGMOHQ>; Fri, 13 Jul 2001 10:07:16 -0400
Received: from quasar.osc.edu ([192.148.249.15]:40930 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S267482AbRGMOHE>;
	Fri, 13 Jul 2001 10:07:04 -0400
Date: Fri, 13 Jul 2001 10:06:50 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Bob Smart <smart@hpc.CSIRO.AU>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        jeroen@trout.hpc.CSIRO.AU, smart@trout.hpc.CSIRO.AU
Subject: Re: handling NFSERR_JUKEBOX
Message-ID: <20010713100650.D25733@osc.edu>
In-Reply-To: <200107100023.KAA00261@trout.hpc.CSIRO.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107100023.KAA00261@trout.hpc.CSIRO.AU>; from smart@hpc.CSIRO.AU on Tue, Jul 10, 2001 at 10:23:40AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smart@hpc.CSIRO.AU said:
> http://mail-index.netbsd.org/tech-kern/1999/03/16/0002.html
> To save you looking the key point is:
> 
>   >Not sure. Is there a way that the server can say, "I got your request,
>   >but I'm too busy now, try again in a little bit." ??
> 
>   Isn't this what NFSERR_JUKEBOX is for?
> 
>   AFAIK, the protocol goes something like this:
> 
>   Client sends a request.
>   Server starts loading tape/optical disk/whatever.
>   Client resends request.
>   Server notices that this is a repeat of an earlier request which is already
>   in the "slow queue", and replies NFSERR_JUKEBOX (= "be patient, I'll send
>   the response eventually").
>   Client shuts up and waits.
>   Server completes request and sends response to client.
> 
> It seems that what the linux client is doing is returning error 528
> to the user program (cp is giving this error message). From 
> linux/errno.h:
> 
> #define EJUKEBOX  528     /* Request initiated, but will not complete 
>                              before timeout */
> 
> This is wrong because the nfs file system is hard mounted in my case
> - there is no timeout.
> 
> While it would be nice to do a perfect solution, it looks like
> a quick fix is to just ignore NFSERR_JUKEBOX from the server.

The comment is incorrect.  Take a look at the RFC for NFSv3.  There is
no duplicate request sent from the client for a JUKEBOX-supporting
server.  The first request is satisfied by the return of EJUKEBOX, after
which it is up to the client to re-request the file.  Ignoring it is not
an option because the request is terminated; a retry does not make
sense.  A new request must be initiated by the client later.

Take a look at the nfs sourceforge mailing list.  There's a long thread
about this in the context of a Solaris HSM server.  I wrote a patch to
try to do the right thing on a linux client, but it is not perfect for
many reasons: http://devrandom.net/lists/archives/2001/6/NFS/0135.html

		-- Pete
