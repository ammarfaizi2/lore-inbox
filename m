Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268278AbRGWQCg>; Mon, 23 Jul 2001 12:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268281AbRGWQCb>; Mon, 23 Jul 2001 12:02:31 -0400
Received: from archive.osdlab.org ([65.201.151.11]:45220 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S268280AbRGWQCO>;
	Mon, 23 Jul 2001 12:02:14 -0400
Message-ID: <3B5C4A0A.BC9E32FA@osdlab.org>
Date: Mon, 23 Jul 2001 09:00:10 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
CC: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem: Large file I/O waits (almost) forever
In-Reply-To: <Pine.LNX.4.30.0107231043520.24403-100000@biker.pdb.fsc.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi-

This sounds like something that was noticed at Intel a couple
of months ago.  I believe that Linus made a patch for it
in 2.4.7.  I'll be trying that out today or tomorrow with
some large files.

The problem observed at Intel was in linux/fs/buffer.c.
The dirty buffer list is scanned Buffers^2 times (with a
lock) for each dirty buffer (or something like that; I'm not
sure of the details), so the larger the file and dirty buffers,
the longer each write took.

~Randy

Martin Wilck wrote:
> 
> Hi,
> 
> I just came across the following phenomenon and would like to inquire
> whether it's a feature or a bug, and what to do about it:
> 
> I have run our "copy-compare" test during the weekend to test I/O
> stability on a IA64 server running 2.4.5. The test works by generating
> a collection of binary files with specified lengths, copying them between
> different directories, and checking the result a) by checking the
> predefined binary patterns and b) by comparing source and destination with cmp.
> 
> In order to avoid testing only the buffer cache (system has 8GB memory), I
> used exponentially growing file sizes fro 1kb up to 2GB. The
> copy/test/compare cycle for each file size was run 1024 times, tests
> for different file sizes were run simultaneously.
> 
> As expected, tests for smaller files run faster than tests for larger
> ones. However, I observed that the very big files (1 GB and 2GB) hardly
> proceeded at all while the others were running. When I came back
> after the weekend, all tests except these two had completed (1024 times
> each), the 1GB test had completed ~500 times, and the 2GB test had not
> even completed once. After I killed the 1GB job, 2GB started to run again
> (i.e. it wasn't dead, just sleeping deeply). Apparently the block requests
> scheduled for I/O by the processes operating on the large file had to
> "yield" to other processes over and over again before being submitted.
> 
> I think this is a dangerous behaviour, because the test situation is
> similar to a real-world scenario where applications (e.g. a data
> base) are doing a lot of small-file I/O while a background process is
> trying to do a large backup. If the system behaved similar then, it would
> mean that the backup would take (almost) forever unless database activity
> would cease.
> 
> Any comments/suggestions?
> 
> Regards,
> Martin
> 
> PS: I am not subscribed to LK, but I'm reading the archives regularly.
