Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSG1LCz>; Sun, 28 Jul 2002 07:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSG1LCz>; Sun, 28 Jul 2002 07:02:55 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:36100 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315629AbSG1LCy>; Sun, 28 Jul 2002 07:02:54 -0400
Date: Sun, 28 Jul 2002 12:06:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 11/13] don't hold i_sem during O_DIRECT writes to blockdevs
Message-ID: <20020728120611.A7332@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D439E43.5F2DEE3D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D439E43.5F2DEE3D@zip.com.au>; from akpm@zip.com.au on Sun, Jul 28, 2002 at 12:33:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 12:33:23AM -0700, Andrew Morton wrote:
> This patch changes O_DIRECT writes to blockdevs so that they no longer
> run under i_sem.

Please don't make this depenend on S_ISBLK().  There are filesystems (like
XFS) that are designed to safely allow concurrent O_DIRECT writes to
regular files.

Toe implement this properly we should drop i_sem in the ->direct_IO method
of the filesystem/blockdevice.  The only question remaining is whether the
method has to reqacquire it before returing (and it'll be imediately
released again or whether we should change semantics of ->direct_IO to
always drop the lock.

The third options would be to never call ->direct_IO with the i_sem held
and let filesystems that need it (only ext2 in 2.5 mainline) do
synchronization themselves.

I think I prefer option 3, it's the cleanest way of doing it.

A little unrelated, but as you touch the code:  what about removing the two
existing special cases for S_ISBLK() in generic_file_write()?  they're
present only to provide the old (pre-LFS) blockdevice semantics on 2.4,
we shouldn't keept them around forever..

