Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUAOCgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUAOCgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:36:07 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:22916 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265828AbUAOCfm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:35:42 -0500
Subject: Re: Slow NFS performance over wireless!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bu4pd6$anf$1@news.cistron.nl>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
	 <200401130155.32894.hackeron@dsl.pipex.com>
	 <1074025508.1987.10.camel@lumiere>
	 <1074026758.4524.65.camel@nidelv.trondhjem.org>
	 <bu4pd6$anf$1@news.cistron.nl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074134135.1522.52.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 14 Jan 2004 21:35:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 14/01/2004 klokka 20:12, skreiv Miquel van Smoorenburg:
> On an NFS client (2.6.1-mm3, filesystem mounted with options
> udp,nfsvers=3,rsize=32768,wsize=32768) I get for the same share as
> write/rewrite/read speeds 36 / 4 / 38 MB/sec. CPU load is also
> very high on the client for the rewrite case (80%).
> 
> That's with back-to-back GigE, full duplex, MTU 9000, P IV 3.0 Ghz.
> (I tried MTU 5000 and 1500 as well, doesn't really matter).
> 
> Is that what would be expected ?

Err.. no...

I didn't have a 2.6.1-mm3 machine ready to go in our GigE testbed (I'm
busy compiling one up right now). However I did run a quick test on
2.6.0-test11. Iozone rather than bonnie, but the results should be
comparable:

        Iozone: Performance Test of File I/O
                Version $Revision: 3.169 $
                Compiled for 32 bit mode.
                Build: linux
                                                                                
        Contributors:William Norcott, Don Capps, Isom Crawford, Kirby Collins
                     Al Slater, Scott Rhine, Mike Wisner, Ken Goss
                     Steve Landherr, Brad Smith, Mark Kelly, Dr. Alain CYR,
                     Randy Dunlap, Mark Montague, Dan Million,
                     Jean-Marc Zucconi, Jeff Blomberg.
                                                                                
        Run began: Wed Jan 14 21:32:08 2004
                                                                                
        Include close in write timing
        File size set to 2097152 KB
        Record Size 128 KB
        Command line used: /plymouth/trondmy/public/programs/fs/iozone -c -t1 -s 2048m -r 128k -i0 -i1
        Output is in Kbytes/sec
        Time Resolution = 0.000001 seconds.
        Processor cache size set to 1024 Kbytes.
        Processor cache line size set to 32 bytes.
        File stride size set to 17 * record size.
        Throughput test with 1 process
        Each process writes a 2097152 Kbyte file in 128 Kbyte records
                                                                                
        Children see throughput for  1 initial writers  =  109333.84 KB/sec
        Parent sees throughput for  1 initial writers   =  109326.48 KB/sec
        Min throughput per process                      =  109333.84 KB/sec
        Max throughput per process                      =  109333.84 KB/sec
        Avg throughput per process                      =  109333.84 KB/sec
        Min xfer                                        = 2097152.00 KB
                                                                                
        Children see throughput for  1 rewriters        =  111377.63 KB/sec
        Parent sees throughput for  1 rewriters         =  111370.21 KB/sec
        Min throughput per process                      =  111377.63 KB/sec
        Max throughput per process                      =  111377.63 KB/sec
        Avg throughput per process                      =  111377.63 KB/sec
        Min xfer                                        = 2097152.00 KB

        Children see throughput for  1 readers          =  123864.27 KB/sec
        Parent sees throughput for  1 readers           =  123854.96 KB/sec
        Min throughput per process                      =  123864.27 KB/sec
        Max throughput per process                      =  123864.27 KB/sec
        Avg throughput per process                      =  123864.27 KB/sec
        Min xfer                                        = 2097152.00 KB
                                                                                
        Children see throughput for 1 re-readers        =  167226.50 KB/sec
        Parent sees throughput for 1 re-readers         =  167222.79 KB/sec
        Min throughput per process                      =  167226.50 KB/sec
        Max throughput per process                      =  167226.50 KB/sec
        Avg throughput per process                      =  167226.50 KB/sec
        Min xfer                                        = 2097152.00 KB

 
That is admittedly with a (very fast) NetApp filer on the receiving end,
so it is only a Linux client test. However as you can see, I'm basically
flat w.r.t. rereads and rewrites. Client is BTW a PowerEdge 2650 w/
built-in Broadcom BCM5703 (no jumbo frames). Note: with TCP, the numbers
degrade a bit to 81MB/sec write, 82MB/sec rewrite, 135MB/sec read and
144MB/sec reread.

Against a Sun server, I get something a lot slower: 32MB/sec write,
22MB/sec rewrite, 38MB/sec read, 28MB/sec reread using UDP, 29/21/29/26
using TCP. There I do indeed see a slight dip in both the rewrite and
the reread figures.



1 question:
  - Is bonnie doing a close() or an fsync() of the file after if
finishes the write, and before it goes on to testing for rewrites? I
suspect not, in which case your numbers will be strongly skewed.


Cheers,
  Trond
