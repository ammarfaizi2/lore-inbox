Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129039AbRBBKFs>; Fri, 2 Feb 2001 05:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129070AbRBBKFi>; Fri, 2 Feb 2001 05:05:38 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:24968 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129039AbRBBKFU>; Fri, 2 Feb 2001 05:05:20 -0500
Message-ID: <3A7A8822.CC5D8E4E@uow.edu.au>
Date: Fri, 02 Feb 2001 21:12:50 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A728475.34CF841@uow.edu.au>,
		<3A726087.764CC02E@uow.edu.au>
		<20010126222003.A11994@vitelus.com>
		<3A728475.34CF841@uow.edu.au> <14966.22671.446439.838872@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> ...
> Finally, please do some tests on loopback.  It is usually a great
> way to get "pure software overhead" measurements of our TCP stack.

Here we are.  TCP and NFS/UDP over lo.

Machine is a dual-PII.  I didn't bother running CPU utilisation
testing while benchmarking loopback, although this may be of
some interest for SMP.  I just looked at the throughput.

Machine is a dual 500MHz PII (again).  Memory read bandwidth
is 320 meg/sec.  Write b/w is 130 meg/sec.  The working set
is 60 ~300k files, everything cached. We run the following
tests:

1: sendfile() to localhost, sender and receiver pinned to
   separate CPUs

2: sendfile() to localhost, sender and receiver pinned to
   the same CPU

3: sendfile() to localhost, no explicit pinning.

4, 5, 6: same as above, except we use send() in 8kbyte
   chunks.

Repeat with and without zerocopy patch 2.4.1-2.

The receiver reads 64k hunks and throws them away. sendfile()
sends the entire file.

Also, do an NFS mount of localhost, rsize=wsize=8192, see how
long it takes to `cp' a 100 meg file from the "server" to
/dev/null.  The file is cached on the "server".  Do this for
the three pinning cases as well - all the NFS kernel processes
were pinned as a group and `cp' was the other group.


                                sendfile()     send(8k)   NFS
                                 Mbyte/s       Mbyte/s   Mbyte/s

No explicit bonding
  2.4.1:                          66600        70000     25600
  2.4.1-zc:                      208000        69000     25000

Bond client and server to separate CPUs
  2.4.1:                          66700        68000     27800
  2.4.1-zc:                      213047        66000     25700

Bond client and server to same CPU:
  2.4.1:                          56000        57000     23300
  2.4.1-zc:                      176000        55000     22100



Much the same story.  Big increase in sendfile() efficiency,
small drop in send() and NFS unchanged.

The relative increase in sendfile() efficiency is much higher
than with a real NIC, presumably because we've factored out
the constant (and large) cost of the device driver.

All the bits and pieces to reproduce this are at

	http://www.uow.edu.au/~andrewm/linux/#zc

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
