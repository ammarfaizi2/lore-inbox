Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbTBUFMQ>; Fri, 21 Feb 2003 00:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbTBUFMQ>; Fri, 21 Feb 2003 00:12:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:33723 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267141AbTBUFMN>;
	Fri, 21 Feb 2003 00:12:13 -0500
Date: Thu, 20 Feb 2003 21:23:52 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: iosched: parallel streaming reads
Message-Id: <20030220212352.3cfefeab.akpm@digeo.com>
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:22:13.0629 (UTC) FILETIME=[30FA2AD0:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here we see how well the scheduler can cope with multiple processes reading
multiple large files.  We read ten well laid out 100 megabyte files in
parallel (ten readers):

	for i in $(seq 0 9)
	do
		time cat 100-meg-file-$i > /dev/null &
	done

2.4.21-pre4:

	0.00s user 0.18s system 2% cpu 6.115 total
	0.02s user 0.22s system 1% cpu 14.312 total
	0.01s user 0.19s system 1% cpu 14.812 total
	0.00s user 0.14s system 0% cpu 20.462 total
	0.02s user 0.19s system 0% cpu 23.887 total
	0.06s user 0.14s system 0% cpu 27.085 total
	0.01s user 0.26s system 0% cpu 32.367 total
	0.00s user 0.22s system 0% cpu 34.844 total
	0.01s user 0.21s system 0% cpu 35.233 total
	0.01s user 0.16s system 0% cpu 37.007 total

2.5.61+hacks:

	0.01s user 0.16s system 0% cpu 2:12.00 total
	0.01s user 0.15s system 0% cpu 2:12.12 total
	0.00s user 0.14s system 0% cpu 2:12.34 total
	0.01s user 0.15s system 0% cpu 2:12.68 total
	0.00s user 0.15s system 0% cpu 2:12.93 total
	0.01s user 0.17s system 0% cpu 2:13.06 total
	0.01s user 0.14s system 0% cpu 2:13.18 total
	0.01s user 0.17s system 0% cpu 2:13.31 total
	0.01s user 0.16s system 0% cpu 2:13.49 total
	0.01s user 0.19s system 0% cpu 2:13.51 total

2.5.61+CFQ:

	0.01s user 0.16s system 0% cpu 50.778 total
	0.01s user 0.16s system 0% cpu 51.067 total
	0.01s user 0.16s system 0% cpu 52.854 total
	0.01s user 0.17s system 0% cpu 53.303 total
	0.01s user 0.17s system 0% cpu 54.565 total
	0.01s user 0.18s system 0% cpu 1:07.39 total
	0.01s user 0.17s system 0% cpu 1:19.96 total
	0.00s user 0.17s system 0% cpu 1:28.74 total
	0.01s user 0.18s system 0% cpu 1:31.28 total
	0.01s user 0.18s system 0% cpu 1:32.34 total

2.5.61+AS

	0.01s user 0.17s system 0% cpu 27.995 total
	0.01s user 0.18s system 0% cpu 30.550 total
	0.00s user 0.17s system 0% cpu 31.413 total
	0.00s user 0.18s system 0% cpu 32.381 total
	0.01s user 0.17s system 0% cpu 33.273 total
	0.01s user 0.18s system 0% cpu 33.389 total
	0.01s user 0.15s system 0% cpu 34.534 total
	0.01s user 0.17s system 0% cpu 34.481 total
	0.00s user 0.17s system 0% cpu 34.694 total
	0.01s user 0.16s system 0% cpu 34.832 total


AS and 2.4 almost achieved full disk bandwidth.  2.4 does quite well here,
although it was unfair.

As an aside, I reran this test with the VM readahead wound down from the
usual 128k to just 8k:

2.5.61+CFQ:

	0.01s user 0.25s system 0% cpu 7:48.39 total
	0.01s user 0.23s system 0% cpu 7:48.72 total
	0.02s user 0.26s system 0% cpu 7:48.93 total
	0.02s user 0.25s system 0% cpu 7:48.93 total
	0.01s user 0.26s system 0% cpu 7:49.08 total
	0.02s user 0.25s system 0% cpu 7:49.22 total
	0.02s user 0.26s system 0% cpu 7:49.25 total
	0.02s user 0.25s system 0% cpu 7:50.35 total
	0.02s user 0.26s system 0% cpu 8:19.82 total
	0.02s user 0.28s system 0% cpu 8:19.83 total

2.5.61 base:

	0.01s user 0.25s system 0% cpu 8:10.53 total
	0.01s user 0.27s system 0% cpu 8:11.96 total
	0.02s user 0.26s system 0% cpu 8:14.95 total
	0.02s user 0.26s system 0% cpu 8:17.33 total
	0.02s user 0.25s system 0% cpu 8:18.05 total
	0.01s user 0.24s system 0% cpu 8:19.03 total
	0.02s user 0.27s system 0% cpu 8:19.66 total
	0.02s user 0.25s system 0% cpu 8:20.00 total
	0.02s user 0.26s system 0% cpu 8:20.10 total
	0.02s user 0.25s system 0% cpu 8:20.11 total

2.5.61+AS

	0.02s user 0.23s system 0% cpu 28.640 total
	0.01s user 0.23s system 0% cpu 28.066 total
	0.02s user 0.23s system 0% cpu 28.525 total
	0.01s user 0.20s system 0% cpu 28.925 total
	0.01s user 0.22s system 0% cpu 28.835 total
	0.02s user 0.21s system 0% cpu 29.014 total
	0.02s user 0.23s system 0% cpu 29.093 total
	0.01s user 0.20s system 0% cpu 29.175 total
	0.01s user 0.23s system 0% cpu 29.233 total
	0.01s user 0.21s system 0% cpu 29.285 total

We see here that the anticipatory scheduler is not dependent upon large
readahead to get good performance.



