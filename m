Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268157AbRGWJDl>; Mon, 23 Jul 2001 05:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268159AbRGWJDc>; Mon, 23 Jul 2001 05:03:32 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:44739 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S268157AbRGWJD0>; Mon, 23 Jul 2001 05:03:26 -0400
Date: Mon, 23 Jul 2001 11:05:04 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Problem: Large file I/O waits (almost) forever
Message-ID: <Pine.LNX.4.30.0107231043520.24403-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

I just came across the following phenomenon and would like to inquire
whether it's a feature or a bug, and what to do about it:

I have run our "copy-compare" test during the weekend to test I/O
stability on a IA64 server running 2.4.5. The test works by generating
a collection of binary files with specified lengths, copying them between
different directories, and checking the result a) by checking the
predefined binary patterns and b) by comparing source and destination with cmp.

In order to avoid testing only the buffer cache (system has 8GB memory), I
used exponentially growing file sizes fro 1kb up to 2GB. The
copy/test/compare cycle for each file size was run 1024 times, tests
for different file sizes were run simultaneously.

As expected, tests for smaller files run faster than tests for larger
ones. However, I observed that the very big files (1 GB and 2GB) hardly
proceeded at all while the others were running. When I came back
after the weekend, all tests except these two had completed (1024 times
each), the 1GB test had completed ~500 times, and the 2GB test had not
even completed once. After I killed the 1GB job, 2GB started to run again
(i.e. it wasn't dead, just sleeping deeply). Apparently the block requests
scheduled for I/O by the processes operating on the large file had to
"yield" to other processes over and over again before being submitted.

I think this is a dangerous behaviour, because the test situation is
similar to a real-world scenario where applications (e.g. a data
base) are doing a lot of small-file I/O while a background process is
trying to do a large backup. If the system behaved similar then, it would
mean that the backup would take (almost) forever unless database activity
would cease.

Any comments/suggestions?

Regards,
Martin

PS: I am not subscribed to LK, but I'm reading the archives regularly.

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113



