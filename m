Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293687AbSCATmx>; Fri, 1 Mar 2002 14:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293679AbSCATmO>; Fri, 1 Mar 2002 14:42:14 -0500
Received: from pc-62-31-74-76-ed.blueyonder.co.uk ([62.31.74.76]:43906 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S293672AbSCATmF>; Fri, 1 Mar 2002 14:42:05 -0500
Date: Fri, 1 Mar 2002 19:41:55 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [OOPS 2.5.5-dj2] ext3 BUG in do_get_write_access()
Message-ID: <20020301194155.H2682@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0202281703130.4893-100000@mf1.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0202281703130.4893-100000@mf1.private>; from whitney@math.berkeley.edu on Thu, Feb 28, 2002 at 05:19:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 28, 2002 at 05:19:44PM -0800, Wayne Whitney wrote:
 
> I managed to generate the oops below on 2.5.5-dj2 by doing the following:
>   cp -ax / /mnt &
>   <some delay, don't know if it matters>
>   tune2fs -L root /dev/hdc5 

> tune2fs -L should be safe on a mounted filesystem, non?

Hmmm.

There's a fundamental problem here.  Journaling filesystems expect to
be in control over when data gets written to the disk.  tune2fs is
writing to the superblock in the buffer cache directly, and ext3 is
really, really paranoid about finding unexpected dirty buffers since
they usually imply that we have just violated the filesystem's write
ordering expectations.

Clearly in this case something legal has just happened, but it still
means that the superblock can get flushed to disk before the
filesystem expects it, and this can result in an inconsistency on
disk after recovery if we crash just after that flush.

So saying "this is legal" means data corruption, and protecting the fs
from such interference (eg. by moving the on-disk superblock
representation into the page cache) will prevent tune2fs from working
at all: the updated fields will just be overwritten by the
filesystem's copy.


In this particular case, I think I'll just have to relax the assertion
and cause it to printk instead of BUG()ing, because I don't want to
lose the protection of this test entirely.  

I'd really like to be able to detect such direct buffered-io
"interference" from user-space, though, so that I could preserve the
BUG() in cases where ext3 is getting this wrong internally.  I'll look
at that --- I may be able to achieve it through ext3's existing
metadata flags.

Cheers,
 Stephen
