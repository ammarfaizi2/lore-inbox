Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSBDPT2>; Mon, 4 Feb 2002 10:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289016AbSBDPTR>; Mon, 4 Feb 2002 10:19:17 -0500
Received: from zok.SGI.COM ([204.94.215.101]:2708 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S289015AbSBDPTN>;
	Mon, 4 Feb 2002 10:19:13 -0500
Subject: Re: O_DIRECT fails in some kernel and FS
From: Steve Lord <lord@sgi.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020203224406.GA17396@tapu.f00f.org>
In-Reply-To: <1012597538.26363.443.camel@jen.americas.sgi.com>
	<20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny>
	<20020202205438.D3807@athlon.random> <242700000.1012680610@tiny>
	<3C5C4929.5080403@sgi.com> <20020202155028.B26147@havoc.gtf.org>
	<3C5D3DE9.4080503@sgi.com> <20020203140926.GA14532@tapu.f00f.org>
	<3C5D51A0.4050509@sgi.com>  <20020203224406.GA17396@tapu.f00f.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Feb 2002 09:15:30 -0600
Message-Id: <1012835730.26397.519.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-02-03 at 16:44, Chris Wedgwood wrote:
> On Sun, Feb 03, 2002 at 09:05:04AM -0600, Stephen Lord wrote:
> 
>     but page faults are not blocked out for the duration of the I/O so
>     the coherency is weak.
> 
> I was thinking this would also be goof, basically invalidate those
> pages and remove them from the VMAs, marking them as unusable pending
> IO completion --- the logic her being if you were to fault on an
> invalidated page during IO you deserve to block indefinitely until the
> IO completes.
> 
>     However, if an application is doing a combination of mmapped and
>     direct I/O to a file at the same time, then it should generally
>     have some form of user space synchronization anyway.
> 
> I hadn't considered that.  I imagined an application doing either but
> not both, and the kernel enforcing this.  However, in the case when
> you want to mmap a large file, you may want to manipulate some pages
> using mmap whilst writing others with O_DIRECT.  Although, in such
> cases arguably you could using multiple mapping's.
> 
> 

If an application is single threaded then it cannot be doing both at
the same time - so all we need to do is flush and invalidate mappings
at the start of I/O. This is really only needed for the range covered by
the direct read/write.

If an application is multithreaded and is doing mmap and direct I/O
from different threads without doing its own synchronization, then it
is broken, there is no ordering guarantee provided by the kernel as
to what happens first.

> 
>    --cw

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
