Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSDOHTP>; Mon, 15 Apr 2002 03:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313044AbSDOHTO>; Mon, 15 Apr 2002 03:19:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313038AbSDOHTN>;
	Mon, 15 Apr 2002 03:19:13 -0400
Message-ID: <3CBA7EC4.BA148E80@zip.com.au>
Date: Mon, 15 Apr 2002 00:18:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <joe@tmsusa.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 final - another data point
In-Reply-To: <3CB9EF57.6010609@tmsusa.com> <3CBA6943.4000701@tmsusa.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> ...
> dbench performance has regressed significantly
> since 2.5.8-pre1; the performance is equivalent
> up to 8 instances, but at 16 and above, 2.5.8 final
> takes a nosedive. Performance at 128 instances
> is approximately 20% of the throughput of
> 2.5.8-pre1 - which is in turn not up to 2.4.xx
> performance levels. I realize that the BIO has
> been through heavy surgery, and nowhere near
> optimized, but this is just a data point...

It's not related to BIO.  dbench is all about higher-level
memory management, high-level IO scheduling and butterfly
wings.
 
> ...
> Throughput 151.068 MB/sec (NB=188.835 MB/sec  1510.68 MBit/sec)  8 procs
> Throughput 43.0191 MB/sec (NB=53.7738 MB/sec  430.191 MBit/sec)  16 procs
> Throughput 9.65171 MB/sec (NB=12.0646 MB/sec  96.5171 MBit/sec)  32 procs
> Throughput 37.8267 MB/sec (NB=47.2833 MB/sec  378.267 MBit/sec)  64 procs

Consider that 32 proc line for a while.

>....
> 2.5.8-final
> ---------------
> Throughput 152.948 MB/sec (NB=191.185 MB/sec  1529.48 MBit/sec)  1 procs
> Throughput 151.597 MB/sec (NB=189.497 MB/sec  1515.97 MBit/sec)  2 procs
> Throughput 150.377 MB/sec (NB=187.972 MB/sec  1503.77 MBit/sec)  4 procs
> Throughput 150.159 MB/sec (NB=187.698 MB/sec  1501.59 MBit/sec)  8 procs
> Throughput 7.25691 MB/sec (NB=9.07113 MB/sec  72.5691 MBit/sec)  16 procs
> Throughput 6.36332 MB/sec (NB=7.95415 MB/sec  63.6332 MBit/sec)  32 procs

It's obviously fallen over some cliff.  Conceivably the larger readahead
window causes this.  How much memory does the machine have? `dbench 64'
on a 512 meg setup certainly causes readahead thrashing.  You can
stick a `printk("ouch");' into handle_ra_thrashing() and watch it...


But really, all this stuff is in churn at present. I have patches here
which take `dbench 64' on 512 megs from this:


2.5.8:
Throughput 12.7343 MB/sec (NB=15.9179 MB/sec  127.343 MBit/sec)

to this:

2.5.8-akpm:
Throughput 49.2223 MB/sec (NB=61.5278 MB/sec  492.223 MBit/sec)

This is partly by just throwing more memory at it.  The gap
widens on highmem...

And that code isn't tuned yet - I do know that threads are getting
blocked by each other at the inode level.  And that ext2 is serialising
itself at the lock_super() level, and that if you fix that,
threads serialise on slab's cache_chain_sem (which is pretty
amazing...).

Patience.  2.5.later-on will perform well.  :)

-
