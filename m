Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSGUTP2>; Sun, 21 Jul 2002 15:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSGUTP2>; Sun, 21 Jul 2002 15:15:28 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:65507 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312590AbSGUTP1>;
	Sun, 21 Jul 2002 15:15:27 -0400
Message-ID: <1027279106.3d3b0902a9209@imap.linux.ibm.com>
Date: Sun, 21 Jul 2002 12:18:26 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lmbench] tcp bandwidth on athlon
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.65.48.133
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I ran oprofile with bw_tcp and retired instructions on 
> athlon showed:

> samples       %-age  symbol name
> 903640      75.4825  csum_partial_copy_generic

> In Carl Staelin and Larry McVoy's 98 Usenix paper they 
> wrote:
>
> It is interesting to compare pipes with TCP because the TCP
> benchmark  is identical to the pipe benchmark except for the
> transport mechanism.  Ideally, the TCP bandwidth would be as 
> good as the pipe bandwidth. It is not widely known that the

Well, TCP will have a little more overhead than a pipe - 
the network stack having to take care of a few more things.

> majority of the TCP cost is in the bcopy, the checksum, and
> the network interface driver.  The checksum and  the  driver
> may  be  safely eliminated in the loopback case and if the 
> costs have been eliminated, then TCP should be just as fast 
> as pipes.  From the pipe and TCP results [...]
> it is easy to see that Solaris and HP-UX have done this 
> optimization.

Much has happened since 1998: hw checksum offload,
sendfile, amongst others. Note that this checksum 
is performed while copying the data from/to
user space (though not that often in rx code path).
However, while we dont look at the checksum on the
rx side for TCP, since the loopback driver will
have set ip_summed to CHECKSUM_UNNECESSARY, on the
send side we dont bother, because we have to do the
copy in any case. Marginal difference, although
perhaps worth doing. I had a patch for this which
showed no difference in a VolanoMark (yes, I know),
benchmark.

> Processor                Pipe        TCP
> Athlon/1330             840.66      73.75 (or 150 MB/sec - see below)
> k6-2/475                 65.15      52.45
> PIII * 1/700 Xeon       539.73     446.16 

Hmm, so if K6 and Xeon can scrounge up 80% of pipe
performance, why is the Athlon an order of magnitude off
at 8%? How did your Athlon perform in other tests relative
to these other procs?

> I tried compiling the athlon kernel without 
> X86_USE_PPRO_CHECKSUM but that didn't really change 
> tcp bandwidth.

> kernel                   Pipe      TCP  
> 2.4.19rc2aa1            860.97    74.27
> 2.4.19rc2aa1-nocsum     853.18    74.16

Well, that would simply change how the checksum is
calculated, and in this case, I believe the substantial
latency is from the copy.

> There was a change in bw_tcp.c that has a 2x impact on
> the computed bandwidth.  I have two versions:

> ls -gl LM*/src/bw_tcp.c
> -r--r--r--    1 rwhron     3553 Jul 23  2001 LMbench.old/src/bw_tcp.c
> -r--r--r--    1 rwhron     3799 Sep 27  2001 LMbench2/src/bw_tcp.c

I only see the bitkeeper version thats almost a year old, online,
where is the later version from? 

> Both LMbench trees have the same version:
...

> ident doesn't specify a version in tcp_bw.c, but diff shows
> a difference.

A change in your test causes a 2x difference in performance,
and you dont give us the diff? :) :)

> Socket bandwidth using localhost: 75.85 MB/sec 
...
> Socket bandwidth using localhost: 150.21 MB/sec

Where are the complete profiles from these runs?
Also, any chance you have network stats before/after?
I looked on your site but couldnt find the tcp_bw
runs..


thanks,
Nivedita



