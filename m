Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314144AbSDLVX2>; Fri, 12 Apr 2002 17:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314145AbSDLVX1>; Fri, 12 Apr 2002 17:23:27 -0400
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:39097 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S314144AbSDLVX1>; Fri, 12 Apr 2002 17:23:27 -0400
Date: Fri, 12 Apr 2002 22:22:52 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andi Kleen <ak@suse.de>
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, davem@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020412222252.A25184@kushida.apsleyroad.org>
In-Reply-To: <20020410.193045.32403941.davem@redhat.com> <20020411.154651.51706443.taka@valinux.co.jp> <20020410.234821.122842406.davem@redhat.com> <20020412.213011.45159995.taka@valinux.co.jp> <20020412143559.A25386@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > I wondered if regular truncate() and read() might have the same
> > problem, so I tested again and again.
> > And I realized it will occur on any local filesystems.
> > Sometime I could get partly zero filled data instead of file contents.
> > 
> I don't see it as a big problem and would just leave it as it is (for NFS
> and local) 
> Adding more locking would slow down read() a lot and there should be 
> a good reason to take such a performance hit. Linux did this forever
> and I don't think anybody ever reported it as a bug, so we can probably
> safely assume that this behaviour (non atomic truncate) is not a problem for 
> users in practice.

Ouch!  I have a program which can output incorrect results if this is
the case.  It may seem to use an esoteric locking strategy, but I had no
idea it was acceptable for read to return data that truncate is in the
middle of zeroing.

The program keeps a cache on disk of generated files.  For each cached
object, there is a metadata file.  Metadata files are text files,
written in such a way that the first line looks similar to "=12296.0"
and so does the last line, but none of the intermediate lines have that
form.

Multiple programs can access the disk cache at the same time, and must
be able to check the metadata files being written by other programs,
blocking if necessary while a cached object is being generated.

When a metadata file is being written, first it is created, then the
cached object is created and written to a related file, and finally the
metadata including the first and last marker line is written to the
metadata file.

When a program reads a metadata file, it reads as much as it can and
then checks the first and last lines are identical.  If they are, the
middle of the file is valid otherwise it isn't -- perhaps the process
generating that file died, or has the metadata file locked.

This strategy is used so that there's no need to lock the file, in the
cache of a cache hit with no complications.  If there's a complication
we lock with LOCK_SH and try again.

>From time to time, when a cache object is invalid, it's appropriate to
truncate the metadata file.  If that were atomic, end of story.
Unfortunately I've just now heard that a read() can successfully
interleave some zeros from a parallel truncate.

If the timing is right, that means it's possible for the reading
process to see a hole of zeros in the middle of the file.  The first and
last lines would be intact, and the reader would think that the whole
file is therefore valid.  Bad!

This occurs if the reader copies the initial bytes from the page, then
the truncation process catches up and zeros out some bytes, but then the
reader catches up and beats the truncation process to the end of the
file.

I'm not advocating more locking in read() -- there's no need, and it is
quite important that it is fast!  But I would very much appreciate an
understanding of the rules that relate reading, writing and truncating
processes.  How much ordering & atomicity can I depend on?  Anything at all?

cheers,
-- Jamie
