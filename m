Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271589AbRICPMK>; Mon, 3 Sep 2001 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271623AbRICPME>; Mon, 3 Sep 2001 11:12:04 -0400
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:1294 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S271589AbRICPLs>; Mon, 3 Sep 2001 11:11:48 -0400
Date: Mon, 3 Sep 2001 17:11:36 +0200 (CEST)
From: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Editing-in-place of a large file
In-Reply-To: <20010903094636.V23180@draal.physics.wisc.edu>
Message-ID: <Pine.LNX.4.21.0109031704450.3066-100000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001, Bob McElrath wrote:

> Alan Cox [alan@lxorguk.ukuu.org.uk] wrote:
> > > That is reimplementing file system functionality in user space. 
> > > I'm in doubts that this is considered good design...
> > 
> > Keeping things out of the kernel is good design. Your block indirections
> > are no different to other database formats. Perhaps you think we should
> > have fsql_operation() and libdb in kernel 8)
> 
> Well, a filesystem that is:
> 1) synchronous
> 2) bypasses linux's buffer cache
> 3) insert() and delete() to insert and delete from the middle of a file.
> 4) Has large block sizes

Well, just make it possible to tell something more about the operation
you want to do to the kernel/VFS. Copy/Insert/Delete is in fact some
sort of sendfile operation. For GLAME I did a "simple" (well, it turned
out to be not that simple...) user level filesystem that supports those
kind of operations. The interface I chose was
  sendfile(dest_fd, source_fd, count, mode)
where mode can be composed out of nothing (overwrite, leave source
intact), INSERT and CUT.

As it is a userspace implementation byte granularity is supported, but
for a kernel level support I suppose block granularity would suffice and
could be optimized for in the lower level filesystems code. I'd prefer
such a generic interface over fcntls which would certainly be possible
at least for a "split this file into two ones" operation.

Oh yes - it would help to have this in the kernel, at least if you
want to support sane mmap behaviour (for block aligned modifications,
of course - byte level is impossible due to aliasing issues, I believe).

Richard.

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

