Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbTBUVEb>; Fri, 21 Feb 2003 16:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267701AbTBUVEb>; Fri, 21 Feb 2003 16:04:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:61166 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267699AbTBUVE2>;
	Fri, 21 Feb 2003 16:04:28 -0500
Date: Fri, 21 Feb 2003 13:11:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iosched: impact of streaming read on read-many-files
Message-Id: <20030221131158.180125d7.akpm@digeo.com>
In-Reply-To: <20030221104028.GO31480@x30.school.suse.de>
References: <20030220212304.4712fee9.akpm@digeo.com>
	<20030220212758.5064927f.akpm@digeo.com>
	<20030221104028.GO31480@x30.school.suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 21:14:29.0615 (UTC) FILETIME=[38ADBFF0:01C2D9EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> CFQ is made for multimedia desktop usage only, you want to be sure
> mplayer or xmms will never skip frames, not for parallel cp reading
> floods of data at max speed like a database with zillon of threads. For
> multimedia not to skip frames 1M/sec is  more than enough bandwidth,
> doesn't matter if the huge database in background runs much slower as
> far as you never skip a frame.

These applications are broken.  The kernel shouldn't be bending over
backwards trying to fix them up.  Because this will never ever work as well
as fixing the applications.

The correct way to design such an application is to use an RT thread to
perform the display/audio device I/O and a non-RT thread to perform the disk
I/O.  The disk IO thread keeps the shared 8 megabyte buffer full.  The RT
thread mlocks that buffer.

The deadline scheduler will handle that OK.  The anticipatory scheduler
(which is also deadline) will handle it better.



If an RT thread performs disk I/O it is bust, and we should not try to fix
it.  The only place where VFS/VM/block needs to care for RT tasks is in the
page allocator.  Because even well-designed RT tasks need to allocate pages.

The 2.4 page allocator has a tendency to cause 5-10 second stalls for a
single page allocation when the system is under writeout load.  That is fixed
in 2.5, but special-casing RT tasks in the allocator would make sense.
