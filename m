Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312524AbSDSRR5>; Fri, 19 Apr 2002 13:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312532AbSDSRR4>; Fri, 19 Apr 2002 13:17:56 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:65296 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S312524AbSDSRRy>;
	Fri, 19 Apr 2002 13:17:54 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200204191717.g3JHHoL12031@oboe.it.uc3m.es>
Subject: Re: [PATCH] 2.5.8 IDE 36
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Fri, 19 Apr 2002 19:17:50 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(mutters under breath .. let me put this back in the thread it came
from. Sorry. Double post for the records, with the right subject line
this time ...)

> On Tue, 16 Apr 2002, Alan Cox wrote:
> > We need to support partitioning on loopback devices in that case.
> 
> No, you just need to do the loopback over nbd - you need something to do
> the byte swapping anyway (ie you can't really use the normal "loop"
> device: I really just meant the more generic "loop the data back"
> approach).
> 
> nbd devices already do partitioning, I'm fairly certain.

Well, sort of. They make the right motions in the code, waving
their arms about in the right directions. It's doubtful if what's
there is enough.

> (But no, I've never tested it, obviously).

Neither have the authors. 

> Btw, while I'm at it - who out there actually uses the new "enbd"
> (Enhanced NBD)? I have this feeling that that would be the better choice,
> since unlike plain nbd it should be deadlock-free on localhost (ie you
> don't need a remote machine).

No - it will deadlock the same way. The deadlock is not related to the
device driver itself. It goes like this.

     kernel runs low on memory
     kernel flushes buffers to device drivers under pressure
     nbd client daemon sends to the net (potential conflict with tcp buffers,
        but not the mechanism that hurts)
     server on the _same machine_ receives request over the net
     server tries to write request to disk
     server process needs buffers to write to
     bang (or whatever deadlock sounds like)

The enbd client has a special "-a" flag which is meant to be used in
cases where we trust the transport medium. Localhost is such a case. 

With it, the protocol in the client daemon will ack the kernel _before_
it gets an ack from the remote server. That should help relieve the
deadlock. Things then go like this:

     kernel runs low on memory
     kernel flushes buffers to device drivers under pressure
     nbd client daemon sends to the net
        * client acks kernel and releases buffers in kernel
     server on the _same machine_ receives request over the net
     server tries to write request to disk
     server process needs buffers to write to
        * server gets buffers released by client in kernel

At least, potentially. If I recall right, there's still a deadlock
window in-kernel, but it's small. I don't recall the details. Oh -
well, the request still hangs around in the driver until the client
daemon acks .. maybe the client daemon can't ack without being swapped
in first, and that'd be deadlock.

Well, there's a "-s" flag (for swap devices) that does an mlockall()
that might take care of that. So "-a -s" might do it. Really needs
a "-aa" option (release write request in kernel asap).

However, a real cure would be not to use the network transport at all in
enbd.  Enbd can use different transports.  Instead of using the stub for
the server in the client daemon code, one could use the "fileserver"
object directly.  It'd just be a question of changing the
initialization.  Both have the same generic interface.

Incidentally, the newer VM code in 2.4 is a real problem for enbd.
I would ideally like _no_ _buffering_ whatsoever on the clientside.

As it is, it seems almost mandatory to raise the bdflush sync
boundary as high as possible, and to drop the async boundary really
low. One wants to start sending buffers out across the net
asynchronously as early as possible, and one never wants to go
sync. Going sync makes for a deadlock where we need to send
a request across the net in order to free a buffer, but we can't,
because we need some buffers to do that with ...

 * Is there any way of turning off the VM for a single device? *

The 2.5 i/o changes, otoh, seem immensely favourable to enbd, since
it's multithreaded and asyncronous in-kernel.


Peter

