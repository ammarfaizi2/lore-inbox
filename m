Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136650AbREGTye>; Mon, 7 May 2001 15:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136653AbREGTyZ>; Mon, 7 May 2001 15:54:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28032 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S136651AbREGTyS>; Mon, 7 May 2001 15:54:18 -0400
Date: Mon, 7 May 2001 15:54:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, alexander.eichhorn@rz.tu-ilmenau.de,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <Pine.LNX.4.33.0105071124080.10009-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.3.95.1010507145625.6441A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, dean gaudet wrote:

> On Mon, 7 May 2001, Richard B. Johnson wrote:
> 
> > when the hardware I/O is used. This shows that the network code, alone,
> > cannot be improved very much to provide an improvement in throughput.
> 
> doesn't your analysis assume that we've got nothing else interesting to do
> while doing the network i/o?  for example, i may want to do something else
> which needs the memory bandwidth i'd otherwise spend on a single-copy...
> 
> -dean

Yes and no. It is assumed by most everybody that a single CPU
cycle saved in doing something is automatically available for
doing something else.  This is never the case unless you have
a completely polled OS environment that is not doing I/O.  In
any OS that preempts using a timer, CPU activity (actual work
being done)  bunches up around that timer interval.  The same
is true for interrupts.  This happens because,  to  a  single
measurement task,  the  CPU seems slower as  it keeps getting
taken away.  So, we end up with a lot of CPU activity bunched
up around interrupts and timer-ticks, with not much happening
elsewhere.

In Unix,  a system call does not produce a  context-switch
unless the task is required to sleep while waiting for I/O.
So, the kernel is going to send a packet to another host on
behalf of the system caller.  It copies the data,  (partial
checksum) assembles the packet, finishes the checksum, then
sends it.  The CPU is given to somebody  else while waiting
for the packet to  get somewhere and be ACKed.  But,  think
about a server  where EVERY  task  is  waiting  for I/O  to
complete!  These CPU cycles,  that you saved by eliminating
a copy (or two), are now wasted spinning.

Let's say the first packet got sent quicker because of the
reduced latency of the copy.  After that,  you still are
waiting for I/O.

Reduced to the limit,  look at using zero CPU cycles to send
and receive packets. Now, with a server loaded to its natural
ability, i.e., bandwidth limited by the round-trip loop band-
width, you still have all the tasks waiting for I/O to complete. 

Basically, "no copy" is an academic exercise. It makes the first
packet get sent more quickly, after which everything slows to
the natural bandwidth of the system.

If you used a server for multicast-only.  In other words,  you
just spewed out unidirectional data, you still slow to the rate
at which the media can take the data.  And CPUs can obtain or
generate these data a lot faster than 100-base can sink them.

When we get to media that can sink data as fast as we can generate
them (it), then we have to worry about memory copy speed. However,
these new devices are actually an IP subsystem.  They generate and
receive entire datagrams. To fully utilize these devices, the data-
gram generation and reception (the basis of all TCP/IP networking)
will have to be moved out of the kernel and into these boards. The
kernel code will only handle interfaces, connections, and rules.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


