Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154478AbQBNPj2>; Mon, 14 Feb 2000 10:39:28 -0500
Received: by vger.rutgers.edu id <S154698AbQBNP21>; Mon, 14 Feb 2000 10:28:27 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:7923 "EHLO deliverator.sgi.com") by vger.rutgers.edu with ESMTP id <S154740AbQBNP0N>; Mon, 14 Feb 2000 10:26:13 -0500
Message-ID: <38A85787.FB76CFCC@engr.sgi.com>
Date: Mon, 14 Feb 2000 11:29:11 -0800
From: Aman Singla <aman@cthulhu.engr.sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: "Brandon S. Allbery KF8NH" <allbery@kf8nh.apk.net>, linux-kernel@vger.rutgers.edu
Subject: Re: Scheduled Transfer Protocol on Linux
References: <200002132058.MAA22259@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

I think Larry's description (below) about how STP works is pretty
much accurate modulo 'various levels of details / mechanisms' but
hey, thats what protocol spec's are for :-)
http://www.hippi.org/cST.html

The STP Long Message Transfer stuff is realized to be useful for
network enabled storage - may it be through higher performance
solutions in the upper layer - NFS/BDS etc., or via the lower layers
like SCSI over STP.

What I'd like to add is, that STP also specifies persistent (longer
duration - spanning multiple messages) mappings and pinning down of
memory which is useful for low latency communications a'la clustering
applications. Again, what STP offers here is an open, media-independent
and scalable protocol.

Are there any other applications that people can forsee?

thanks,

:a

> What it does do is give you a high bandwidth, low CPU cycle way of moving
> the data.
> 
> The simplified view of STP is really just remote DMA.  How it works, again
> greatly simplified, is sort of like this:
> 
>         client                                  server
>         request to send 1GB ->
> 
>                         <- please wait while I set up some pages (optional)
> 
>                         <- clear to send first 100MB of data, here's a cookie
> 
>         data on wire, prefixed with incrementing cookie ->
>         data on wire, prefixed with incrementing cookie ->
>         data on wire, prefixed with incrementing cookie ->
>         data on wire, prefixed with incrementing cookie ->
>         data on wire, prefixed with incrementing cookie ->
>         data on wire, prefixed with incrementing cookie ->
>         data on wire, prefixed with incrementing cookie ->
>         data on wire, prefixed with incrementing cookie ->
>         data on wire, prefixed with incrementing cookie ->
> 
>                         -> data hits NIC, cockie is index into CAM, exactly
>                            like an ethernet switch indexes MAC addresses,
>                            except that the value here is a physical page
>                            address instead of an outgoing port
> 
>                         -> data hits NIC ....
>                         -> data hits NIC ....
>                         -> data hits NIC ....
>                         -> data hits NIC ....
>                         -> data hits NIC ....
>                         -> data hits NIC .... we're at 75MB or so
> 
>                            server goes off and locks down another 100MB
> 
>                         <- CTS another 100MB (this happens well before the
>                            first 100MB is drained, so there are no bubbles,
>                            the pipe is 100% full at all times)
> 
> I trust that the SGI guys, who know this stuff better than I, will correct
> and problems with this description.  I'm sure there are some, but I'm also
> sure this is pretty close to how it works modulo flow control, security,
> and other important bits.
> 
> What's important is that you notice two things:
> 
>     (a) this is what I call "polite networking".  Normal networking is
>         impolite, the packets show up on your doorstep uninvited.  Here,
>         the receiver is nicely asked if it is OK, and gets to set things
>         up first.  Just like in DMA.
> 
>     (b) There is some hardware on the NIC that translates from packets to
>         physical page addresses, this happens inline, so the packet gets
>         DMAed into memory as it is coming off the wire.  Very low buffering
>         requirements.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
