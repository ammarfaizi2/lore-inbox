Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265262AbUETWUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265262AbUETWUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbUETWUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:20:46 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:24839 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S265262AbUETWUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:20:42 -0400
Date: Thu, 20 May 2004 15:23:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: alexeyk@mysql.com, linuxram@us.ibm.com, nickpiggin@yahoo.com.au,
       peter@mysql.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
Message-Id: <20040520152305.3dbfa00b.akpm@osdl.org>
In-Reply-To: <20040520145902.27647dee.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	<1084480888.22208.26.camel@dyn319386.beaverton.ibm.com>
	<1084815010.13559.3.camel@localhost.localdomain>
	<200405200506.03006.alexeyk@mysql.com>
	<20040520145902.27647dee.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2004 22:20:25.0558 (UTC) FILETIME=[A6253F60:01C43EB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> There's still something wrong here.  2.6.6-bk+deadline is pretty equivalent
> to 2.4 from an IO scheduler point of view in this test.  Yet it's a couple
> of percent slower.
> 
> I don't know why you're still seeing significant discrepancies.
> 
> What sort of disk+controller system are you using?  If scsi, what is the
> tag queue depth set to?  Is writeback caching enabled on the disk?

If the 2.4 and 2.6 disk accounting statitics are to be believed, they show
something interesting.

Workload is one run of

sysbench --num-threads=16 --test=fileio --file-total-size=2G --file-test-mode=rndrw run

on ext2.


2.4.27-pre2:

rio:				5549		(Read requests issued)
rblk:				259680		(Total sectors read)
wio:				42398		(Write requests issued)
wblk:				4368056		(Total sectors written)

2.6.6-bk, as:

reads:				5983
readsectors:			201192
writes:				22548
writesectors:			4343184


- Note that 2.6 read 20% less data from the disk.  We observed this
  before.  It appears that 2.6 page replacements decisions are working
  better for this workload.

- Despite that, 2.6 issued *more* read requests.  So it is submitting
  more, and smaller I/O's

- Both kernels wrote basically the same amount of data.  2.6 a little
  less, perhaps because of fsync() optimisations.

- But 2.6 issued far fewer write requests.  Half as many as 2.4 - a huge
  difference.  There are a number of reasons why this could happen but
  frankly, I don't have a clue what's going on in there.


Given that 2.6 is issuing less IO requests it should be performing faster
than 2.4.  The reason that the two kernels are achieving about the same
throughput despite this is that the disk is performing writeback caching
and is absorbing 2.4's smaller write requests.



I set the IDE disk to do writethrough (hdparm -W0):

2.6.6-bk, as:

	Time spent for test:  89.9427s
		0.04s user 5.24s system 1% cpu 4:51.62 total

2.4.27-pre2:

	Time spent for test: 107.8293s
		0.04s user 6.00s system 1% cpu 7:26.47 total


as expected.

Open questions are:

a) Why is 2.6 write coalescing so superior to 2.4?

b) Why is 2.6 issuing more read requests, for less data?

c) Why is Alexey seeing dissimilar results?
