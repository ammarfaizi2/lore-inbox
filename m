Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970790-740>; Mon, 23 Mar 1998 00:32:21 -0500
Received: from out5.ibm.net ([165.87.194.245]:2617 "EHLO out5.ibm.net" ident: "NO-IDENT-SERVICE") by vger.rutgers.edu with ESMTP id <970955-740>; Mon, 23 Mar 1998 00:31:10 -0500
Message-Id: <199803230531.FAA157962@out5.ibm.net>
To: linux-kernel@vger.rutgers.edu
From: lm@vger.rutgers.edu (Larry McVoy)
Subject: Re: Why is NFS so slow?? 
Date: Sun, 22 Mar 1998 21:30:55 -0800
Sender: owner-linux-kernel@vger.rutgers.edu

: Unlike TCP, NFS has no streaming (also called windowing, where you send
: requests while there's still outstanding replies).  This means
: performance is strictly limited by the latency of your connection,
: rather than by its throughput.  Using larger blocksizes can help, but
: using RPC over UDP over high-latency connections is never going to be
: good.  NFS's preference for UDP has been long regarded as dubious, at
: best. 

In a system with a reasonable filesystem/vm interface, NFS streams just fine.
Under SunOS, the file system gets called on each reference, even if the page
is in memory, so it can keep track of the read ahead pointer.  If the access
is sequential, the next block (or several blocks) are prefetched from the 
server.  It's /exactly/ the same logic (and set of issues) that you have 
with a disk.  ext2fs would suck wind if it didn't do read ahead.  Why should
NFS be any different?  

TCP vs UDP is not an issue, contrary to popular opinion.  In both
cases, you need a queue of outstanding requests (the "window"), you
need to measure round trip time, and you need to handle retransmits.
Yes, TCP does all that for you, but if your NFS protocol implementation
doesn't have a queue of outstanding requests, TCP won't help you one iota.
And if your NFS implementation does have a queue, NFS over UDP will work
just fine.

Rick Maclims work up in Canada showed all of this in gory detail in a Usenix
paper a few years back.  And my personal experience validates his (as do
a lot of others).

Short summary:  there is absolutely no reason that NFS/UDP can't go exactly
as fast as NFS/TCP.  

: The problem is very much in NFS's design, which is why there's been work
: on WebNFS, which is designed to pack more into a request to try and
: counter the latency problems.  HTTP has been transformed in similar ways
: for similar reasons.

If by WebNFS, you mean nfs://server/path/to/some/file, then that's Brent's
stuff from Sun and it has nothing to do with latency, Brent just thought it 
would be cool to get those files from NFS, since NFS exists on every Unix 
box and (at the time he proposed and implemented the prototype) HTTP was
not ubiquitous.  He was also trying to leverage all the UID stuff that NFS
has (though this is weak in my opinion).  But in all the stuff I heard 
about at the Connectathon where it was prevented, and in subsequent 
conversations, the latency issues you describe were never mentioned.  And
I think that's because any reasonable NFS does read ahead so it covers 
those.

I only know of two places where latency work has occurred in NFS; they
are both in v3.  I managed to lobby stat-ahead into the rev, so that
you have a readdir that returns both file handles and the attributes;
and the write clustering that allows async writes followed by a commit
(the write cluster protocol is a botch, in my opinion, and it is /not/
what I wanted done.  I wanted something that very closely mirrored the
in kernel interfaces between a local file system and the disk subsystem.
Unfortunately, all the NFS guys are networking guys and the concept of
repeating time honored methods from a local file system in a remote file
system seemed too weird to them.  Strange, that.)

The only place that any latency work has occurred in NFS in the last 10
years or so, is in the readdir_with_stats interface that I got into
NFS v3.  

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
