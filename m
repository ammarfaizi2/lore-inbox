Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317175AbSEXPzN>; Fri, 24 May 2002 11:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314457AbSEXPzK>; Fri, 24 May 2002 11:55:10 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:8205 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S317176AbSEXPyi>;
	Fri, 24 May 2002 11:54:38 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205241554.g4OFsWN29042@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <200205241328.OAA27164@gw.chygwyn.com> from Steven Whitehouse at
 "May 24, 2002 02:28:45 pm"
To: Steve Whitehouse <Steve@ChyGwyn.com>
Date: Fri, 24 May 2002 17:54:32 +0200 (MET DST)
Cc: ptb@it.uc3m.es, linux kernel <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven Whitehouse wrote:"
> (and ptb wrote, at ever greater quoting distance)
> > > so I'm still hopeful that it can be solved in a reasonably simple way,
> > If you can manage to reserve memory for a socket, that should be it.
> 
> I'd like to do that if I can, on the otherhand, thats going to be rather
> a tricky one. We are not going to know which process called run_task_queue()

We should be able to change the function which registers tasks to also
record the originating process id, if that's any help.  But it might
have to be inherited through a lot of places, and it's not therefore a
point change in the code. Discard that idea.

> so that we can't use the local pages list as a hackish way of doing this
> easily (I looked into that). If we did all sends from one process though
> it becomes more of a possibility, there are problems with that though....

I do do that in ENBD.

> I've wondered before about changing the request function so that it just
> puts the request on the local queue and wakes up the thread for sending

That is again what I do do in ENBD.

> data. That would solve the blocking problem, but also mean that we had to
> schedule for every request that comes in which I'd rather avoid for
> performance reasons (not that I've actually done the experiment to work out
> what we'd loose, but I suspect it would make a difference).

There's no difference for NBD, essentially, if the kernel is merging
requests (and it is, by default, in the make request function). Then
nearly every read and write through the device ends up as several KB in
size, maybe up to about 32KB (or even 128KB, or 256KB), and that is
significant time over a network link, so that whatever else happens 
in the kernel is dominated by the transmission speed over the medium.

You end up with some latency, and that's all.

People are doing large studies of performance over ENBD over
various media, with various kernels. I should be able to tell you more
one day soon! At the moment I don't see any obvious way-to-go
indicators in the results.

Some of the latency problems evaporate because people interested in
this sort of thing are usually using SMP machines, and signalling
when there is work to do amounts to letting the kernel work on 
one processor, taking requests off the kernel queue and putting them on
the local queue, and leaving a process blocked on the second cpu,
waiting for the kernel on the other cpu to tell it to go go go.

The ENBD design also has multiple processes doing the networking, so
they tend to pipeline. Obviously, the more cpu's the better. Hey, the
more network cards, the better. Also the 2.5 kernel's abandonment of a
single kernel i/o lock should have helped significantly, but it hasn't
shown up in measurements.

> Also there is the possibility of combining the sending thread with the
> receiving thread. This has complications because we'd have to poll()

I do use the same thread for sending and receiving in ENBD. This is
because the cycle is invariant .. you send a question, and then you
receive an answer back. Or you send a command, and you get an ack back.
Both times it's write then read. Separate threads would be possible,
but are kind of a luxury item.

> the socket and be prepared to do non-blocking read or write on it as
> required. Obviously by no means impossible, but certainly more complicated
> than the current code.

I'm not sure that I see the difficulty. Yes, to answer that question,
ENBD does use non-blocking sockets, and does run select on them to
detect what happens. But that's more or less just so it can detect
errors. I don't think there'd be any significant harm accruing from
using blocking sockets.

> This would prevent blocking in the request function, but I still don't know
> how we can ensure that there is enough memory available. In some ways I

This is the key.

> feel that we ought to be able to make use of the local pages list for the
> process to (ab)use for this, but if the net stack frees any memory from
> interrupt context that was allocated in process context, that idea won't
> work,

What was my idea .. oh yes, that the tcp stack should get its memory
from a specific place for each socket, if there is a specific place
defined. This involves looking at the tcp stack, which I hate ...


Peter
