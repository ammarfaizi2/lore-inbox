Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132290AbRA1P6H>; Sun, 28 Jan 2001 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136163AbRA1P55>; Sun, 28 Jan 2001 10:57:57 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:46743 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132290AbRA1P5r>; Sun, 28 Jan 2001 10:57:47 -0500
Message-ID: <3A74433C.239D1317@uow.edu.au>
Date: Mon, 29 Jan 2001 03:05:16 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A72CD1E.32BB523F@uow.edu.au> <Pine.GSO.4.30.0101270900230.24088-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> PS:- can you try it out with the ttcp testcode i posted?

Yup.  See below.  The numbers are almost the same as
with `zcs' and `zcc'.

The CPU utilisation code which was in `zcc' has been
broken out into a standalone tool, so the new `cyclesoak'
app is a general-purpose system load measurement tool.
It's fascinating to play with, if you're into that sort
of thing.

`cyclesoak' was used to measure ttcp-sf and NFS/UDP client
and server throughput.  The times()-based instrumentation
inside ttcp-sf doesn't (can't) give correct numbers.  2-4% CPU
at 100 mbps?  We wish :)

The zerocopy patch doesn't seem to affect NFS efficiency at
all.  Confused.

Excerpt from the rapidly swelling README:



NFS/UDP client results
======================

Reading a 100 meg file across 100baseT.  The file is fully cached on
the server.  The client is the above machine.  You need to unmount the
server between runs to avoid client-side caching.

The server is mounted with various rsize and wsize options.

  Kernel           rsize wsize   mbyte/sec     CPU

  2.4.1-pre10+zc   1024  1024     2.4         10.3%
  2.4.1-pre10+zc   2048  2048     3.7         11.4%
  2.4.1-pre10+zc   4096  4096     10.1        29.0%
  2.4.1-pre10+zc   8199  8192     11.9        28.2%
  2.4.1-pre10+zc  16384 16384     11.9        28.2%

  2.4.1-pre10      1024  1024      2.4         9.7%
  2.4.1-pre10      2048  2048      3.7        11.8%
  2.4.1-pre10      4096  4096     10.7        33.6%
  2.4.1-pre10      8199  8192     11.9        29.5%
  2.4.1-pre10     16384 16384     11.9        29.2%

Small diff at 8192.


NFS/UDP server results
======================

Reading a 100 meg file across 100baseT.  The file is fully cached on
the server.  The server is the above machine.

  Kernel           rsize wsize   mbyte/sec     CPU

  2.4.1-pre10+zc   1024  1024      2.6        19.1%
  2.4.1-pre10+zc   2048  2048      3.9        18.8%
  2.4.1-pre10+zc   4096  4096     10.0        34.5%
  2.4.1-pre10+zc   8199  8192     11.8        28.9%
  2.4.1-pre10+zc  16384 16384     11.8        29.0%

  2.4.1-pre10      1024  1024      2.6        18.5%
  2.4.1-pre10      2048  2048      3.9        18.6%
  2.4.1-pre10      4096  4096     10.9        33.8%
  2.4.1-pre10      8199  8192     11.8        29.0%
  2.4.1-pre10     16384 16384     11.8        29.0%

No diff.


ttcp-sf Results
===============

Jamal Hadi Salim has taught ttcp to use sendfile.  See
http://www.cyberus.ca/~hadi/ttcp-sf.tar.gz

Using the same machine as above, and the following commands:

Sender:    ./ttcp-sf -t -c -l 32768 -v receiver_host
Receiver:  ./ttcp-sf -c -r -l 32768 -v sender_host

                                                        CPU

    2.4.1-pre10-zerocopy, sending with ttcp-sf:        10.5%
    2.4.1-pre10-zerocopy, receiving with ttcp-sf:      16.1%

    2.4.1-pre10-vanilla, sending with ttcp-sf:         18.5%
    2.4.1-pre10-vanilla, receiving with ttcp-sf:       16.0%

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
