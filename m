Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265252AbUEUX6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUEUX6C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbUEUXwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:52:14 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28347 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264622AbUEUX3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:29:54 -0400
Date: Wed, 19 May 2004 22:49:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Kopytov <alexeyk@mysql.com>
Cc: linuxram@us.ibm.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
Message-Id: <20040519224957.202dd89c.akpm@osdl.org>
In-Reply-To: <200405200506.03006.alexeyk@mysql.com>
References: <200405022357.59415.alexeyk@mysql.com>
	<1084480888.22208.26.camel@dyn319386.beaverton.ibm.com>
	<1084815010.13559.3.camel@localhost.localdomain>
	<200405200506.03006.alexeyk@mysql.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kopytov <alexeyk@mysql.com> wrote:
>
> Ram Pai wrote:
> 
> >Attached the cleaned up patch and the performance results of the patch.
> >
> >Overall Observation:
> >        1.Small improvement with iozone with the patch, and overall
> >                        much better performance than 2.4
> >        2.Small/neglegible improvement with DSS workload.
> >        3.Negligible impact with sysbench, but results worser than
> >                        2.4 kernels
> 
> Ram, can you clarify the status of this patch please?

Everything we have is now in Linus's tree.  And in 2.6.6-mm4.

> I ran the same sysbench test on my hardware with patched 2.6.6 and got 
> 122.2348s execution time, i.e. almost the same results as in the original 
> tests. Is this patch an intermediate step to improve the sysbench workload on 
> 2.6, or it just addresses another problem?

The patches in Linus's tree improve sysbench significantly here.  It's a
256MB 2-way with IDE disks, writeback caching enabled:


sysbench --num-threads=16 --test=fileio --file-total-size=2G --file-test-mode=rndrw run

2.4.27-pre2, ext2:

	Time spent for test:  61.0240s
		0.06s user 6.03s system 4% cpu 2:05.95 total
	Time spent for test:  60.8456s
		0.11s user 5.49s system 4% cpu 2:04.94 total

2.6.6, CFQ, ext2:

	Time spent for test:  85.6614s
		0.05s user 5.66s system 3% cpu 2:26.75 total
	Time spent for test:  85.2090s
		0.06s user 5.32s system 3% cpu 2:24.75 total

2.6.6-bk, CFQ, ext2:

	Time spent for test:  66.7717s
		0.04s user 5.54s system 4% cpu 2:06.19 total
	Time spent for test:  67.5666s
		0.04s user 5.10s system 4% cpu 2:06.72 total


2.6.6, as, ext2:

	Time spent for test:  83.8358s
		0.07s user 5.89s system 4% cpu 2:22.92 total
	Time spent for test:  83.8068s
		0.06s user 5.34s system 3% cpu 2:21.33 total

2.6.6-bk, AS, ext2:

	Time spent for test:  62.5316s
		0.05s user 5.27s system 4% cpu 2:01.28 total
	Time spent for test:  62.7401s
		0.04s user 5.17s system 4% cpu 2:00.50 total


2.6.6, deadline, ext2:

	Time spent for test: 103.0084s
		0.06s user 5.76s system 3% cpu 2:40.74 total
	Time spent for test: 101.9648s
		0.07s user 5.35s system 3% cpu 2:38.83 total

2.6.6-bk, deadline, ext2:

	Time spent for test:  63.3405s
		0.03s user 5.49s system 4% cpu 2:01.05 total
	Time spent for test:  63.5288s
		0.03s user 5.05s system 4% cpu 2:00.78 total


There's still something wrong here.  2.6.6-bk+deadline is pretty equivalent
to 2.4 from an IO scheduler point of view in this test.  Yet it's a couple
of percent slower.

I don't know why you're still seeing significant discrepancies.

What sort of disk+controller system are you using?  If scsi, what is the
tag queue depth set to?  Is writeback caching enabled on the disk?

