Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317808AbSGPMpK>; Tue, 16 Jul 2002 08:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317811AbSGPMpJ>; Tue, 16 Jul 2002 08:45:09 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:8711 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317808AbSGPMpH>; Tue, 16 Jul 2002 08:45:07 -0400
Date: Tue, 16 Jul 2002 14:47:59 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716124759.GH4576@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020712162306$aa7d@traf.lcs.mit.edu> <s5gsn2lt3ro.fsf@egghead.curl.com> <20020715173337$acad@traf.lcs.mit.edu> <s5gsn2kst2j.fsf@egghead.curl.com> <1026767676.4751.499.camel@tiny> <s5gy9ccr84k.fsf@egghead.curl.com> <200207160102.g6G12BiH022986@lin2.andrew.cmu.edu> <s5g8z4cphvd.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5g8z4cphvd.fsf@egghead.curl.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Patrick J. LoPresti wrote:

> On Linux, flushing a rename() means calling fsync() on the directory
> instead of the file.  That's it.  Doing that instead of fsync'ing the
> file adds at most two system calls (to open and close the directory),
> and those can be amortized over many operations on that directory
> (think "mail spool").  So the system call overhead is non-existent.

Indeed, but I can also leave the file descriptor open on any file system
on any system except SOME of Linux'. (Ok, this precludes systems that
don't offer POSIX synchronous completion semantics, but these systems
don't nessarily have fsync() either).

> ordering required for reliable operation; no more, no less.  Relying
> on mount options, "chattr +S", or journaling artifacts for your
> ordering is the inefficient approach; since they impose extra
> ordering, they can never be faster and will usually be slower.

It is sometimes the only way, if the application is unaware. I hope I'm
not loosening a flame war if I mention qmail now, which is not even
softupdates aware. Without chattr +S or mount -o sync, nothing is to be
gained. OTOH, where mount -o sync only makes directory updates
synchronous, it's not too expensive, which is why the +D approach is
still useful there.

> > It's only necessary for ext2. Modern Linux filesystems (such as ext3
> > or reiserfs) don't require it.
> 
> Only because they take the performance hit of flushing the whole log
> to disk on every fsync().  Combine that with "data=ordered" and see
> what happens to your performance.  (Perhaps "data=ordered" should be
> called "fsync=sync".)  I would rather get back the performance and
> convince application authors to understand what they are doing.

1. data=ordered is more than fsync=sync. It guarantees that data blocks
are flushed before flushing the meta data blocks that reference the data
blocks. Try this on ext2fs and lose.

2. sync() is unreliable, it can return control to the caller earlier
than what is sound. It can "complete" at any time it desires without
having completed.
(Probably so it can ever return as new blocks are written by another
process, but at least SUS v2 did not detail on this).

3. Application authors do not desire fsync=sync semantics, but they want
to rely on "fsync(fd) also syncs recent renames". It comes as a
now-guaranteed side effect of how ext3fs works, so I am told.

I'm not sure how the ext3fs journal works internally, but it'd fine with
all applications if only that part of a file system be synched that is
really relevant to the current fsync(fd). No more. It seems as though
fsync==sync is an artifact that ext2 also suffers from.

-- 
Matthias Andree
