Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVKNPt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVKNPt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVKNPtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:49:25 -0500
Received: from rtr.ca ([64.26.128.89]:41905 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751158AbVKNPtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:49:25 -0500
Message-ID: <4378B1FB.1060201@rtr.ca>
Date: Mon, 14 Nov 2005 10:49:15 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.xx:  dirty pages never being sync'd to disk?
References: <4378ADB2.7040905@rtr.ca> <1131982550.2821.41.camel@laptopd505.fenrus.org>
In-Reply-To: <1131982550.2821.41.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2005-11-14 at 10:30 -0500, Mark Lord wrote:
..
>>My Notebook computer has 2GB of RAM, and the 2.6.xx kernel seems quite
>>happy to leave hundreds of MB of dirty unsync'd pages laying around
..
>>/proc/sys/vm/dirty_expire_centisecs = 3000 (30 seconds)
>>/proc/sys/vm/dirty_writeback_centisecs = 500 (5 seconds)
..
> do you have laptop mode enabled? That changes the behavior bigtime in
> this regard and makes the kernel behave quite different.

No.  Laptop-mode mostly just modifies the dirty_expire
and related settings, and I have them set as shown above.
But there's also this:

/proc/sys/vm/laptop_mode = 0

> also if these are files written to by mmap, the kernel only really sees
> those as dirty when the mapping gets taken down

They certainly show up in the counts in /proc/meminfo under "Dirty",
so I assumed that means the kernel knows they are dirty.

A simple test I do for this:

$ mkdir t
$ cp /usr/src/*.bz2  t    (about 400-500MB worth of kernel tar files)

In another window, I do this:

$ while (sleep 1); do echo -n "`date`: "; grep Dirty /proc/meminfo; done

And then watch the count get large, but take virtually forever
to count back down to a "safe" value.

Typing "sync" causes all the Dirty pages to immediately be flushed to disk,
as expected.

Here's what the monitoring of /proc/meminfo shows,
on an otherwise mostly idle system after having done
the big file copies noted earlier:

Mon Nov 14 10:40:22 EST 2005: Dirty:          481284 kB
Mon Nov 14 10:40:23 EST 2005: Dirty:          479680 kB
Mon Nov 14 10:40:24 EST 2005: Dirty:          480380 kB
Mon Nov 14 10:40:25 EST 2005: Dirty:          480380 kB
Mon Nov 14 10:40:26 EST 2005: Dirty:          480380 kB
Mon Nov 14 10:40:27 EST 2005: Dirty:          480380 kB
Mon Nov 14 10:40:28 EST 2005: Dirty:          480384 kB
Mon Nov 14 10:40:29 EST 2005: Dirty:          480384 kB
Mon Nov 14 10:40:30 EST 2005: Dirty:          480384 kB
Mon Nov 14 10:40:31 EST 2005: Dirty:          480384 kB
Mon Nov 14 10:40:32 EST 2005: Dirty:          480384 kB
Mon Nov 14 10:40:33 EST 2005: Dirty:          480688 kB
Mon Nov 14 10:40:34 EST 2005: Dirty:          479972 kB
Mon Nov 14 10:40:35 EST 2005: Dirty:          479972 kB
Mon Nov 14 10:40:36 EST 2005: Dirty:          479972 kB
Mon Nov 14 10:40:37 EST 2005: Dirty:          480016 kB
Mon Nov 14 10:40:38 EST 2005: Dirty:          480016 kB
Mon Nov 14 10:40:39 EST 2005: Dirty:          480016 kB
Mon Nov 14 10:40:40 EST 2005: Dirty:          480020 kB
Mon Nov 14 10:40:41 EST 2005: Dirty:          480020 kB
Mon Nov 14 10:40:42 EST 2005: Dirty:          480028 kB
Mon Nov 14 10:40:43 EST 2005: Dirty:          480028 kB
Mon Nov 14 10:40:44 EST 2005: Dirty:          475868 kB
Mon Nov 14 10:40:45 EST 2005: Dirty:          475868 kB
Mon Nov 14 10:40:46 EST 2005: Dirty:          475868 kB
Mon Nov 14 10:40:47 EST 2005: Dirty:          475868 kB
Mon Nov 14 10:40:48 EST 2005: Dirty:          475880 kB
Mon Nov 14 10:40:49 EST 2005: Dirty:          475880 kB
Mon Nov 14 10:40:50 EST 2005: Dirty:          475880 kB
Mon Nov 14 10:40:51 EST 2005: Dirty:          475880 kB
Mon Nov 14 10:40:52 EST 2005: Dirty:          475880 kB
Mon Nov 14 10:40:53 EST 2005: Dirty:          475880 kB
Mon Nov 14 10:40:54 EST 2005: Dirty:          455160 kB
Mon Nov 14 10:40:55 EST 2005: Dirty:          455160 kB
Mon Nov 14 10:40:57 EST 2005: Dirty:          455160 kB
Mon Nov 14 10:40:58 EST 2005: Dirty:          455160 kB
Mon Nov 14 10:40:59 EST 2005: Dirty:          455164 kB
Mon Nov 14 10:41:00 EST 2005: Dirty:          455160 kB
Mon Nov 14 10:41:01 EST 2005: Dirty:          455160 kB
Mon Nov 14 10:41:02 EST 2005: Dirty:          455160 kB
Mon Nov 14 10:41:03 EST 2005: Dirty:          455164 kB
Mon Nov 14 10:41:04 EST 2005: Dirty:          455164 kB
Mon Nov 14 10:41:05 EST 2005: Dirty:          455168 kB
Mon Nov 14 10:41:06 EST 2005: Dirty:          455168 kB
Mon Nov 14 10:41:07 EST 2005: Dirty:          455168 kB
Mon Nov 14 10:41:08 EST 2005: Dirty:          455188 kB
Mon Nov 14 10:41:09 EST 2005: Dirty:          455176 kB
Mon Nov 14 10:41:10 EST 2005: Dirty:          455176 kB
Mon Nov 14 10:41:11 EST 2005: Dirty:          455176 kB
Mon Nov 14 10:41:12 EST 2005: Dirty:          455176 kB
Mon Nov 14 10:41:13 EST 2005: Dirty:          455180 kB
Mon Nov 14 10:41:14 EST 2005: Dirty:          450972 kB
Mon Nov 14 10:41:15 EST 2005: Dirty:          450972 kB
Mon Nov 14 10:41:16 EST 2005: Dirty:          450972 kB
Mon Nov 14 10:41:17 EST 2005: Dirty:          450972 kB
Mon Nov 14 10:41:18 EST 2005: Dirty:          451016 kB
Mon Nov 14 10:41:19 EST 2005: Dirty:          430336 kB
Mon Nov 14 10:41:20 EST 2005: Dirty:          430336 kB
Mon Nov 14 10:41:21 EST 2005: Dirty:          430336 kB
Mon Nov 14 10:41:22 EST 2005: Dirty:          430336 kB
Mon Nov 14 10:41:23 EST 2005: Dirty:          430348 kB
Mon Nov 14 10:41:24 EST 2005: Dirty:          430348 kB
Mon Nov 14 10:41:25 EST 2005: Dirty:          430348 kB
Mon Nov 14 10:41:26 EST 2005: Dirty:          430348 kB
Mon Nov 14 10:41:27 EST 2005: Dirty:          430348 kB
Mon Nov 14 10:41:28 EST 2005: Dirty:          430356 kB
Mon Nov 14 10:41:29 EST 2005: Dirty:          430352 kB
Mon Nov 14 10:41:30 EST 2005: Dirty:          430352 kB
Mon Nov 14 10:41:31 EST 2005: Dirty:          430352 kB
Mon Nov 14 10:41:32 EST 2005: Dirty:          430352 kB
Mon Nov 14 10:41:33 EST 2005: Dirty:          430356 kB
Mon Nov 14 10:41:34 EST 2005: Dirty:          430356 kB
Mon Nov 14 10:41:35 EST 2005: Dirty:          430356 kB
Mon Nov 14 10:41:36 EST 2005: Dirty:          430356 kB
Mon Nov 14 10:41:37 EST 2005: Dirty:          430368 kB
Mon Nov 14 10:41:38 EST 2005: Dirty:          430364 kB
Mon Nov 14 10:41:39 EST 2005: Dirty:          430360 kB
Mon Nov 14 10:41:40 EST 2005: Dirty:          430364 kB
Mon Nov 14 10:41:41 EST 2005: Dirty:          430364 kB
Mon Nov 14 10:41:42 EST 2005: Dirty:          430368 kB
Mon Nov 14 10:41:43 EST 2005: Dirty:          430368 kB
Mon Nov 14 10:41:44 EST 2005: Dirty:          405552 kB
Mon Nov 14 10:41:45 EST 2005: Dirty:          405552 kB
Mon Nov 14 10:41:46 EST 2005: Dirty:          405552 kB
Mon Nov 14 10:41:47 EST 2005: Dirty:          405552 kB
Mon Nov 14 10:41:48 EST 2005: Dirty:          405556 kB
Mon Nov 14 10:41:49 EST 2005: Dirty:          405548 kB
Mon Nov 14 10:41:50 EST 2005: Dirty:          405548 kB
Mon Nov 14 10:41:51 EST 2005: Dirty:          405548 kB
Mon Nov 14 10:41:52 EST 2005: Dirty:          405548 kB
Mon Nov 14 10:41:53 EST 2005: Dirty:          405552 kB
Mon Nov 14 10:41:54 EST 2005: Dirty:          405492 kB
Mon Nov 14 10:41:55 EST 2005: Dirty:          405492 kB
Mon Nov 14 10:41:56 EST 2005: Dirty:          405492 kB
Mon Nov 14 10:41:57 EST 2005: Dirty:          405524 kB
Mon Nov 14 10:41:58 EST 2005: Dirty:          405528 kB
Mon Nov 14 10:41:59 EST 2005: Dirty:          405524 kB
Mon Nov 14 10:42:00 EST 2005: Dirty:          405524 kB
Mon Nov 14 10:42:01 EST 2005: Dirty:          405524 kB
Mon Nov 14 10:42:02 EST 2005: Dirty:          405536 kB
Mon Nov 14 10:42:03 EST 2005: Dirty:          405536 kB
Mon Nov 14 10:42:04 EST 2005: Dirty:          405536 kB
Mon Nov 14 10:42:05 EST 2005: Dirty:          405536 kB
Mon Nov 14 10:42:06 EST 2005: Dirty:          405536 kB
Mon Nov 14 10:42:07 EST 2005: Dirty:          405536 kB
Mon Nov 14 10:42:08 EST 2005: Dirty:          405536 kB
Mon Nov 14 10:42:10 EST 2005: Dirty:          405532 kB
Mon Nov 14 10:42:11 EST 2005: Dirty:          405532 kB
Mon Nov 14 10:42:12 EST 2005: Dirty:          405532 kB
Mon Nov 14 10:42:13 EST 2005: Dirty:          405532 kB
Mon Nov 14 10:42:14 EST 2005: Dirty:          405544 kB
Mon Nov 14 10:42:15 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:16 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:17 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:18 EST 2005: Dirty:          380680 kB
Mon Nov 14 10:42:19 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:20 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:21 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:22 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:23 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:24 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:25 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:26 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:27 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:28 EST 2005: Dirty:          380680 kB
Mon Nov 14 10:42:29 EST 2005: Dirty:          380668 kB
Mon Nov 14 10:42:30 EST 2005: Dirty:          380668 kB
Mon Nov 14 10:42:31 EST 2005: Dirty:          380668 kB
Mon Nov 14 10:42:32 EST 2005: Dirty:          380668 kB
Mon Nov 14 10:42:33 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:34 EST 2005: Dirty:          380628 kB
Mon Nov 14 10:42:35 EST 2005: Dirty:          380628 kB
Mon Nov 14 10:42:36 EST 2005: Dirty:          380628 kB
Mon Nov 14 10:42:37 EST 2005: Dirty:          380632 kB
Mon Nov 14 10:42:38 EST 2005: Dirty:          380672 kB
Mon Nov 14 10:42:39 EST 2005: Dirty:          380672 kB
Mon Nov 14 10:42:40 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:41 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:42 EST 2005: Dirty:          380676 kB
Mon Nov 14 10:42:43 EST 2005: Dirty:          380684 kB
Mon Nov 14 10:42:44 EST 2005: Dirty:          362476 kB
Mon Nov 14 10:42:45 EST 2005: Dirty:          362476 kB
Mon Nov 14 10:42:46 EST 2005: Dirty:          362476 kB
Mon Nov 14 10:42:47 EST 2005: Dirty:          362476 kB
Mon Nov 14 10:42:48 EST 2005: Dirty:          362476 kB
Mon Nov 14 10:42:49 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:42:50 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:42:51 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:42:52 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:42:53 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:42:54 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:42:55 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:42:56 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:42:57 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:42:58 EST 2005: Dirty:          358344 kB
Mon Nov 14 10:42:59 EST 2005: Dirty:          358344 kB
Mon Nov 14 10:43:00 EST 2005: Dirty:          358344 kB
Mon Nov 14 10:43:01 EST 2005: Dirty:          358344 kB
Mon Nov 14 10:43:02 EST 2005: Dirty:          358352 kB
Mon Nov 14 10:43:03 EST 2005: Dirty:          358352 kB
Mon Nov 14 10:43:04 EST 2005: Dirty:          358348 kB
Mon Nov 14 10:43:05 EST 2005: Dirty:          358348 kB
Mon Nov 14 10:43:06 EST 2005: Dirty:          358348 kB
Mon Nov 14 10:43:07 EST 2005: Dirty:          358348 kB
Mon Nov 14 10:43:08 EST 2005: Dirty:          358352 kB
Mon Nov 14 10:43:09 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:43:10 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:43:11 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:43:12 EST 2005: Dirty:          358340 kB
Mon Nov 14 10:43:13 EST 2005: Dirty:          358344 kB
Mon Nov 14 10:43:14 EST 2005: Dirty:          341716 kB
Mon Nov 14 10:43:15 EST 2005: Dirty:          341716 kB
Mon Nov 14 10:43:16 EST 2005: Dirty:          341716 kB
Mon Nov 14 10:43:17 EST 2005: Dirty:          341756 kB
Mon Nov 14 10:43:18 EST 2005: Dirty:          341756 kB
Mon Nov 14 10:43:19 EST 2005: Dirty:          341748 kB
Mon Nov 14 10:43:21 EST 2005: Dirty:          341748 kB
Mon Nov 14 10:43:22 EST 2005: Dirty:          341748 kB
Mon Nov 14 10:43:23 EST 2005: Dirty:          341752 kB
Mon Nov 14 10:43:24 EST 2005: Dirty:          341752 kB
Mon Nov 14 10:43:25 EST 2005: Dirty:          338268 kB
Mon Nov 14 10:43:26 EST 2005: Dirty:          338268 kB
Mon Nov 14 10:43:27 EST 2005: Dirty:          338268 kB
Mon Nov 14 10:43:28 EST 2005: Dirty:          338276 kB
Mon Nov 14 10:43:29 EST 2005: Dirty:          338268 kB
Mon Nov 14 10:43:30 EST 2005: Dirty:          338268 kB
Mon Nov 14 10:43:31 EST 2005: Dirty:          338268 kB
Mon Nov 14 10:43:32 EST 2005: Dirty:          338268 kB
Mon Nov 14 10:43:33 EST 2005: Dirty:          338272 kB
Mon Nov 14 10:43:34 EST 2005: Dirty:          338272 kB
Mon Nov 14 10:43:35 EST 2005: Dirty:          338272 kB
Mon Nov 14 10:43:36 EST 2005: Dirty:          338272 kB
Mon Nov 14 10:43:37 EST 2005: Dirty:          338276 kB
Mon Nov 14 10:43:38 EST 2005: Dirty:          338280 kB
Mon Nov 14 10:43:39 EST 2005: Dirty:          338276 kB
Mon Nov 14 10:43:40 EST 2005: Dirty:          338280 kB
Mon Nov 14 10:43:41 EST 2005: Dirty:          338280 kB
Mon Nov 14 10:43:42 EST 2005: Dirty:          338280 kB
Mon Nov 14 10:43:43 EST 2005: Dirty:          338288 kB
Mon Nov 14 10:43:44 EST 2005: Dirty:          321708 kB
Mon Nov 14 10:43:45 EST 2005: Dirty:          321708 kB
Mon Nov 14 10:43:46 EST 2005: Dirty:          321708 kB
Mon Nov 14 10:43:47 EST 2005: Dirty:          321708 kB
Mon Nov 14 10:43:48 EST 2005: Dirty:          321708 kB
Mon Nov 14 10:43:49 EST 2005: Dirty:          321704 kB
Mon Nov 14 10:43:50 EST 2005: Dirty:          321704 kB
Mon Nov 14 10:43:51 EST 2005: Dirty:          321704 kB
Mon Nov 14 10:43:52 EST 2005: Dirty:          321704 kB
Mon Nov 14 10:43:53 EST 2005: Dirty:          321708 kB
Mon Nov 14 10:43:54 EST 2005: Dirty:          321656 kB
Mon Nov 14 10:43:55 EST 2005: Dirty:          321656 kB
Mon Nov 14 10:43:56 EST 2005: Dirty:          321656 kB
Mon Nov 14 10:43:57 EST 2005: Dirty:          321656 kB
Mon Nov 14 10:43:58 EST 2005: Dirty:          321688 kB
Mon Nov 14 10:43:59 EST 2005: Dirty:          321684 kB
Mon Nov 14 10:44:00 EST 2005: Dirty:          321684 kB
Mon Nov 14 10:44:01 EST 2005: Dirty:          321684 kB
Mon Nov 14 10:44:02 EST 2005: Dirty:          321696 kB
Mon Nov 14 10:44:03 EST 2005: Dirty:          321696 kB
Mon Nov 14 10:44:04 EST 2005: Dirty:          321696 kB
Mon Nov 14 10:44:05 EST 2005: Dirty:          321696 kB
Mon Nov 14 10:44:06 EST 2005: Dirty:          321696 kB
Mon Nov 14 10:44:07 EST 2005: Dirty:          321696 kB
Mon Nov 14 10:44:08 EST 2005: Dirty:          321696 kB
Mon Nov 14 10:44:09 EST 2005: Dirty:          321692 kB
Mon Nov 14 10:44:10 EST 2005: Dirty:          321692 kB
Mon Nov 14 10:44:11 EST 2005: Dirty:          321692 kB
Mon Nov 14 10:44:12 EST 2005: Dirty:          321692 kB
Mon Nov 14 10:44:13 EST 2005: Dirty:          321692 kB
Mon Nov 14 10:44:14 EST 2005: Dirty:          317604 kB
Mon Nov 14 10:44:15 EST 2005: Dirty:          317604 kB
Mon Nov 14 10:44:16 EST 2005: Dirty:          317608 kB
Mon Nov 14 10:44:17 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:18 EST 2005: Dirty:          317616 kB
Mon Nov 14 10:44:19 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:20 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:21 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:22 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:23 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:24 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:25 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:26 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:27 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:28 EST 2005: Dirty:          317616 kB
Mon Nov 14 10:44:29 EST 2005: Dirty:          317608 kB
Mon Nov 14 10:44:30 EST 2005: Dirty:          317608 kB
Mon Nov 14 10:44:32 EST 2005: Dirty:          317608 kB
Mon Nov 14 10:44:33 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:34 EST 2005: Dirty:          317612 kB
Mon Nov 14 10:44:35 EST 2005: Dirty:          317564 kB
Mon Nov 14 10:44:36 EST 2005: Dirty:          317564 kB
Mon Nov 14 10:44:37 EST 2005: Dirty:          317568 kB
Mon Nov 14 10:44:38 EST 2005: Dirty:          317608 kB
Mon Nov 14 10:44:39 EST 2005: Dirty:          317616 kB
