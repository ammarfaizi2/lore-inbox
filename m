Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbWFUTlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWFUTlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWFUTlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:41:19 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:8064 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932722AbWFUTlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:41:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OuCf58h02hxrxqoF0HZofe4uJPRC+rhP7c26AcJGuqQuIVbqUMNiO2CHsZRJgJcZ7+NcYRl8lNyoZ48qq7kgcZxMhJ3fY79uFsz7tJwtxjpEQVMzqIRW7WhvdZFGnl49kveDVAMr/wl1JNKtQ29kx3e4rvzuAi7bCkvkK/GyDQ8=
Message-ID: <5c49b0ed0606211241k7d12b8d4q305cbaaada677d09@mail.gmail.com>
Date: Wed, 21 Jun 2006 12:41:16 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>, "Christoph Hellwig" <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
In-Reply-To: <20060619172014.GD15216@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060619152003.830437000@candygram.thunk.org>
	 <20060619153109.817554000@candygram.thunk.org>
	 <20060619155821.GA27867@infradead.org>
	 <20060619161651.GS29684@ca-server1.us.oracle.com>
	 <20060619172014.GD15216@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/06, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Jun 19, 2006 at 09:16:51AM -0700, Joel Becker wrote:
> > On Mon, Jun 19, 2006 at 04:58:21PM +0100, Christoph Hellwig wrote:
> > > Blease don't add a field to the superblock for the optimal I/O size.
> > > Any filesystem that wants to override it can do so directly in ->getattr.
> >
> >       I don't disagree with you, but the idea of everyone implementing
> > ->getattr where they just let it work before scares me.  It's a ton of
> > cut-n-paste error waiting to happen.  Especially if we make something
> > stale.
> >       Perhaps add generic_fillattr_blksize()?
>
> Well, as far as I know the only filesystems today that would need to
> do something different are xfs, ocfs2, and reiserfs, and IMHO only the
> first two have any kind of justification for doing it.  Part of the
> problem is what st_blksize actually means was never well-defined; it
> was never in POSIX, and in SuSv3 all that is stated is, "A file
> system-specific preferred I/O block size for this object."  This is
> why Reiserfs got away with specifying 128 megs (I assume it helped on
> some benchmark), and why being ill-defined, using such a large value
> might cause some applications (like /bin/cp) to core dump.
>
> Given that most filesystems use the generic page cache read/write
> functions, using PAGE_CACHE_SIZE as the default seems to make a huge
> amount of sense.  I really wonder how useful setting st_blksize really
> is, actually, at least in the real-world, as opposed to just for
> benchmarks.

I assume "128 megs" is a typo, it's 128k, of course.  And certainly it
would have helped speed things up, not just benchmarks, because for
modern disks, doing 128k vs 4k takes like 25% more time.  Wu's
adaptive readahead patches might make this outdated, though, since
they now support "read 10 pages, seek, read 10 pages, seek, etc" type
workloads.

NATE
