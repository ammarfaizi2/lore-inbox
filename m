Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSFNXeF>; Fri, 14 Jun 2002 19:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSFNXeE>; Fri, 14 Jun 2002 19:34:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57353 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313571AbSFNXeC>;
	Fri, 14 Jun 2002 19:34:02 -0400
Message-ID: <3D0A7D0F.7E085437@zip.com.au>
Date: Fri, 14 Jun 2002 16:32:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hron, Randall" <x2hron@southernco.com>
CC: "'john.weber@linuxhq.com'" <john.weber@linuxhq.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <8835B0E4CF43E9498F143219AFEF9F6108F310@GAXGPEX15.southernco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hron, Randall" wrote:
> 
> > (lord knows i'm trying to get up to speed), but, in the meantime, I can
> > test the crap out of a kernel :).
> 
> tiobench is having trouble completing in kernels >= 2.5.19 on my K6-2
> 384 mb ram, IDE test system.  The parameters I'm using are:
> 
> tiobench.pl --size 2048 --numruns 3 --threads 1 --threads 32 --threads 64
> --threads 128
> 
> --size depends on ram and disk space.
> 
> Early in 2.5, dbench 192 would exercise a bug or two.
> (requires about 5GB of disk space)
> 
> Linux Test Project's runalltests.sh has occasionally triggered a bug.

Is this still happening?  What was the bug?
 
> 2.5 took a drop in dbench throughput recently.
> 
> dbench ext2 128 processes       Average         High            Low(MB/sec)

Is this still with 384 megs of memory?

> 2.5.19                           18.60           21.69           14.58
> 2.5.20                           12.89           13.15           12.79
> 2.5.21                           12.67           12.94           12.51
> 

One possibile culprit here is the doubling of the request queue size
in 2.5.20.  A long time ago it was 1024 slots.  Then it went to
128.  That's where it is in Marcelo kernels.  Then -ac kernels
went up to 1024 because they have read-latency2.  Somehow 2.5 found
itself at 256 slots.  In 2.5.20 it slealthily snuck up to 512
slots.  I didn't squeak about this because I was interested to see what
effect it would have.

Does this patch get the throughput back?


Index: drivers/block/ll_rw_blk.c
===================================================================
RCS file: /opt/cvs/lk/drivers/block/ll_rw_blk.c,v
retrieving revision 1.66
diff -u -r1.66 ll_rw_blk.c
--- drivers/block/ll_rw_blk.c	9 Jun 2002 07:13:15 -0000	1.66
+++ drivers/block/ll_rw_blk.c	14 Jun 2002 23:35:54 -0000
@@ -1974,6 +1974,8 @@
 	if (queue_nr_requests > 512)
 		queue_nr_requests = 512;
 
+	queue_nr_requests = 256;
+
 	/*
 	 * Batch frees according to queue length
 	 */


-
