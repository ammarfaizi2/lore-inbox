Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268478AbTBWPFY>; Sun, 23 Feb 2003 10:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268479AbTBWPFY>; Sun, 23 Feb 2003 10:05:24 -0500
Received: from [195.223.140.107] ([195.223.140.107]:16518 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268478AbTBWPFX>;
	Sun, 23 Feb 2003 10:05:23 -0500
Date: Sun, 23 Feb 2003 16:16:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iosched: impact of streaming read on read-many-files
Message-ID: <20030223151643.GB29467@dualathlon.random>
References: <20030220212304.4712fee9.akpm@digeo.com> <20030220212758.5064927f.akpm@digeo.com> <20030221104028.GO31480@x30.school.suse.de> <20030221131158.180125d7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221131158.180125d7.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 01:11:58PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > CFQ is made for multimedia desktop usage only, you want to be sure
> > mplayer or xmms will never skip frames, not for parallel cp reading
> > floods of data at max speed like a database with zillon of threads. For
> > multimedia not to skip frames 1M/sec is  more than enough bandwidth,
> > doesn't matter if the huge database in background runs much slower as
> > far as you never skip a frame.
> 
> These applications are broken.  The kernel shouldn't be bending over
> backwards trying to fix them up.  Because this will never ever work as well
> as fixing the applications.

disagree, if the kernel doesn't provide a lowlatency elevator of some
sort there's no way to workaround it in userspace with just a
partial-mem buffer (unless you do [1])

> The correct way to design such an application is to use an RT thread to
> perform the display/audio device I/O and a non-RT thread to perform the disk
> I/O.  The disk IO thread keeps the shared 8 megabyte buffer full.  The RT
> thread mlocks that buffer.

having an huge buffering introduces the 8m latency during startup
Which is very annoying if the machine is under high load (especially if
you want to apply realtime effects to the audio, ever tried the xmms
equalizer with an 8m buffer? and it still doesn't guarantee that 8megs
are enough.  secondly 8mbytes mlocked are quite a lot for a 128m
destkop. third, applications are just doing what you suggest and still
you can hear seldom skips during heavy I/O i.e.  having buffering is not
enough if the elevator only cares about global throughput or if the
queue is very huge (and incidentally you're not using SFQ/CFQ).  It is
also possible you don't know what you want to read until the last
minute.

[1] Along your lines you can also buy some giga of ram and copy the
whole multimedia data in ramfs before playback ;) I mean, I agree it's a
problem that can be solved by throwing money into the hardware.

> The deadline scheduler will handle that OK.  The anticipatory scheduler
> (which is also deadline) will handle it better.
> 
> 
> 
> If an RT thread performs disk I/O it is bust, and we should not try to fix
> it.  The only place where VFS/VM/block needs to care for RT tasks is in the
> page allocator.  Because even well-designed RT tasks need to allocate pages.
> 
> The 2.4 page allocator has a tendency to cause 5-10 second stalls for a
> single page allocation when the system is under writeout load.  That is fixed
> in 2.5, but special-casing RT tasks in the allocator would make sense.

the main issue that matters here is not the vm but the blkdev layer
and there you never know if the I/O was submitted by an RT task or not.

and btw the right design for such app is really to use async-io not to
fork off a worthless thread for the I/O.

Andrea
