Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbTCROdl>; Tue, 18 Mar 2003 09:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbTCROdl>; Tue, 18 Mar 2003 09:33:41 -0500
Received: from [66.70.28.20] ([66.70.28.20]:34564 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S262414AbTCROdk>; Tue, 18 Mar 2003 09:33:40 -0500
Date: Tue, 18 Mar 2003 15:42:59 +0100
From: DervishD <raul@pleyades.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Sparks, Jamie" <JAMIE.SPARKS@cubic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: select() stress
Message-ID: <20030318144259.GA1438@DervishD>
References: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000> <Pine.LNX.4.53.0303171112090.22652@chaos> <20030318102837.GH42@DervishD> <Pine.LNX.4.53.0303180758380.26753@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0303180758380.26753@chaos>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Richard :)

 Richard B. Johnson dixit:
> > > descriptors. You cannot assume that this number is the same
> > > as the currently open socket. Just use the socket-value. That's
> > > the file-descriptor.
> >     Not at all. 'select()' takes a *number of file descriptors* as
> > its first argument, meaning the maximum number of file descriptors to
> > check (it checks only the first N file descriptors, being 'N' the
> > first argument). Usually that first argument is FD_SETSIZE, but the
> > result of any function returning a number is right if you know that
> > the return value is what you want.
> What I said has been misinterpreted. Select takes the highest
> number fd in the set you want to examine plus 1.

    AFAIK, only if the first argument is 'FD_SETSIZE', but I'm not
sure of this point.

    And yes, now I understand what you meant, and you're right. If
you put in the set file descriptor 'N', you *must* put in the first
argument at least N+1, or the file descriptor won't be checked.

    Anyway, in the case of 'getdtablesize()', and assuming that it
returns the highest 'openable' file descriptor, it will always return
a number that is higher than any open file descriptor that the
process has (except if it's inherited from the parent and the child
has a lower file descriptor limit, but this involves tweaking with
getdtablesize()...), since the fd numbers start from zero.

> They are not the same and are not guaranteed to be related although
> on some target, they might.

    That's what I didn't understand with getdtablesize(). In the man
page I can read that the function returns the size of the descriptor
table for the process, not the highest number for a file descriptor,
so you can't use it for 'select()', because you can have a socket
descriptor with value e.g. 40055 open and getdtablesize() will
return, for example, 1024. That is, you can open 1024 file
descriptors in your process, but the open call can return 40000 :?

    This leads me to the following thinking: I thought that the code
below is a good way of closing all opened file descriptors, but if
the OS can return an arbitrary number higher than the descriptor
table size for a file descriptor, won't work:

    for (i=0; i < getdtablesize(); i++) close(i);

    How can this be achieved, knowing that the return value for
getdtablesize() doesn't need to be related with fd numbers (that is,
the kernel can return any arbitrary value for a file descriptor,
given that the limit for OPEN_MAX or getdtablesize() is honored)?

    Interesting issue :) Thanks, Richard.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://www.pleyades.net/~raulnac
