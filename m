Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970983-740>; Sun, 22 Mar 1998 20:56:56 -0500
Received: from mail.zip.com.au ([203.12.97.4]:24820 "EHLO mail.zip.com.au" ident: "root") by vger.rutgers.edu with ESMTP id <970998-740>; Sun, 22 Mar 1998 20:56:37 -0500
Message-ID: <3515C137.5C6D263F@zip.com.au>
Date: Mon, 23 Mar 1998 12:56:07 +1100
From: Jeremy Fitzhardinge <jeremy@zip.com.au>
X-Mailer: Mozilla 4.04 [en] (X11; U; Linux 2.1.90 i586)
MIME-Version: 1.0
To: Doug Crompton <wa3dsp@marconi.crompton.com>
CC: linux-kernel@vger.rutgers.edu
Subject: Re: Why is NFS so slow??
References: <Pine.LNX.3.91.980322121519.29760A-100000@marconi.crompton.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Doug Crompton wrote:
> Watching my modem lights the packets seem to have delay - one packet sent,
> response is delayed, etc.  The delay is in Ms. but significant.
> Communications to this same host using other TCP/IP services utilizes the
> modem bandwidth. The (NFS) communication is certainly channel friendly but
> when it takes 30 seconds to get a 20K file and the same to get directories
> it becomes a real drag.

Unlike TCP, NFS has no streaming (also called windowing, where you send
requests while there's still outstanding replies).  This means
performance is strictly limited by the latency of your connection,
rather than by its throughput.  Using larger blocksizes can help, but
using RPC over UDP over high-latency connections is never going to be
good.  NFS's preference for UDP has been long regarded as dubious, at
best. 

TCP also has congestion control, which helps limit dropped packets due
to congestion on the net.  UDP has no such mechanism, and will just make
the problem worse while performance plummets.

Increasing the blocksize can definitely help throughput, so long as you
arn't getting any dropped packets - a dropped fragment of a large NFS
datagram will just drop the whole lot, which will waste masses of
bandwidth.

In theory NFS can be run over TCP connections, but I'm not sure that
Linux supports it yet.

The problem is very much in NFS's design, which is why there's been work
on WebNFS, which is designed to pack more into a request to try and
counter the latency problems.  HTTP has been transformed in similar ways
for similar reasons.

If you can't tweak NFS into getting good performance, and you need the
filesystem interface, look at using CIFS/SMB instead.  It's a ghastly
mess, but it does stream nicely over long-haul TCP connections.

	J

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
