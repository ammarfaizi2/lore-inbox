Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSGUNT5>; Sun, 21 Jul 2002 09:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSGUNT5>; Sun, 21 Jul 2002 09:19:57 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:29919 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315419AbSGUNT4>; Sun, 21 Jul 2002 09:19:56 -0400
Date: Sun, 21 Jul 2002 09:21:54 -0400
To: linux-kernel@vger.kernel.org
Subject: [lmbench] tcp bandwidth on athlon
Message-ID: <20020721132154.GA28089@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran oprofile with bw_tcp and retired instructions on athlon showed:

samples       %-age  symbol name
903640      75.4825  csum_partial_copy_generic

In Carl Staelin and Larry McVoy's 98 Usenix paper they wrote:

"It is interesting to compare pipes with TCP because the TCP  benchmark  is
identical to the pipe benchmark except for the transport mechanism.  Ideally,
the TCP bandwidth would be as good as the pipe bandwidth.  It is  not  widely
known  that  the  majority of the TCP cost is in the bcopy, the checksum, and
the network interface driver.  The checksum and  the  driver  may  be  safely
eliminated  in  the loopback case and if the costs have been eliminated, then
TCP should be just as fast as pipes.  From the pipe and TCP results [...]
it is easy to see that Solaris and HP-UX have done this optimization."

Here are some recent Linux kernels:

Processor                Pipe        TCP
Athlon/1330             840.66      73.75 (or 150 MB/sec - see below)
k6-2/475                 65.15      52.45
PIII * 1/700 Xeon       539.73     446.16 

I tried compiling the athlon kernel without X86_USE_PPRO_CHECKSUM
but that didn't really change tcp bandwidth.

kernel                   Pipe      TCP  
2.4.19rc2aa1            860.97    74.27
2.4.19rc2aa1-nocsum     853.18    74.16

[topic shift]

There was a change in bw_tcp.c that has a 2x impact on
the computed bandwidth.  I have two versions:

ls -gl LM*/src/bw_tcp.c
-r--r--r--    1 rwhron     3553 Jul 23  2001 LMbench.old/src/bw_tcp.c
-r--r--r--    1 rwhron     3799 Sep 27  2001 LMbench2/src/bw_tcp.c

Both LMbench trees have the same version:

#define MAJOR   2
#define MINOR   -13     /* negative is alpha, it "increases" */

ident doesn't specify a version in tcp_bw.c, but diff shows
a difference.

This is the newer bw_tcp on an Athlon 1330.

/bw_tcp localhost
server: nbytes=10485760
initial bandwidth measurement: move=10485760, usecs=117291: 89.40 MB/sec
move=693633024, XFERSIZE=65536
server: nbytes=693633024
Socket bandwidth using localhost: 75.85 MB/sec

And the older bw_tcp compiled with same gcc same kernel on athlon:

/bw_tcp localhost
Socket bandwidth using localhost: 150.21 MB/sec

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

