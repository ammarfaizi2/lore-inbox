Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTA0Qsm>; Mon, 27 Jan 2003 11:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbTA0Qsm>; Mon, 27 Jan 2003 11:48:42 -0500
Received: from imprs-cs.de ([139.19.1.1]:52898 "EHLO interferon.mpi-sb.mpg.de")
	by vger.kernel.org with ESMTP id <S267221AbTA0Qsk>;
	Mon, 27 Jan 2003 11:48:40 -0500
Message-ID: <3E3564EB.8E675E@mpi-sb.mpg.de>
Date: Mon, 27 Jan 2003 17:57:15 +0100
From: Roman Dementiev <dementiev@mpi-sb.mpg.de>
Reply-To: dementiev@mpi-sb.mpg.de
Organization: MPI for Computer Science
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.9 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: buffer leakage in kernel?
References: <3E31364E.F3AFDCF0@mpi-sb.mpg.de> <20030124130208.52583b24.akpm@digeo.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> > While this scanning is running, number of "buffers" reported by ''free"
> > and in /proc/meminfo
> > is continuously increasing up to ~ 500 MB !!
>
> You did not specify the filesystem type.  I shall assume ext2.

right

> > This is not nice at all when I have another applications running
> > with memory consumption > 500 MB: when my "scanner" approaches 50G
> > border on
> > each disk, I've got numerous  "Out of memory" murders :(. Even 'ssh' to
> > this machine
> > is killed :(
> >
> > Could anyone explain why it happens? I suppose that it is a memory
> > leakage in file system buffer management.

Thanx for explanation.

> Sounds like a bug.
>
> Are you reading these large files via a single application, or via one
> process per file?

via single application with 8 I/O threads + 1 thread.

> How large is the buffer into which the application is performing the O_DIRECT
> read?

Application allocates 512 MB and never uses more.
2MB buffers are used for each read() and write() calls.
Each file has only one read or write request going any time. There is no othr
memory-
hungry applications running.

> Please perform this test:
>
> 1: Wait until you have 500M "Buffers"
> 2: cat 64_gig_file > /dev/null
> 3: Now see how large "Buffers" is.  It should have reduced a lot.

Yes, it worked, they had reduced.
Does this mean, that cached indirect buffers can't be kicked out of memory
automatically
and ONLY non-O_DIRECT access can do it? I suppose, they should be displaced by
newly allocated indirect buffers and user memory allocation.


Roman

