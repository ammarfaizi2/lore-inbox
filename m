Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292873AbSB0URY>; Wed, 27 Feb 2002 15:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292928AbSB0UQ6>; Wed, 27 Feb 2002 15:16:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32012 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292929AbSB0UQr>;
	Wed, 27 Feb 2002 15:16:47 -0500
Message-ID: <3C7D3E5A.490D939D@zip.com.au>
Date: Wed, 27 Feb 2002 12:15:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, viro@math.psu.edu
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
In-Reply-To: <3C7D374B.4621F9BA@zip.com.au>,
		<10460000.1014833979@w-hlinder.des>,	<10460000.1014833979@w-hlinder.des> <67850000.1014834875@flay> <3C7D374B.4621F9BA@zip.com.au> <86760000.1014840118@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> > inode_lock hold times are a problem for other reasons.  Leaving this
> > unfixed makes the preepmtible kernel rather pointless....  An ideal
> > fix would be to release inodes based on VM pressure against their backing
> > page.  But I don't think anyone's started looking at inode_lock yet.
> >
> > The big one is lru_list_lock, of course.  I'll be releasing code in
> > the next couple of days which should take that off the map.  Testing
> > would be appreciated.
> 
> Seeing as people seem to be interested ... there are some big holders
> of BKL around too - do_exit shows up badly (50ms in the data Hanna
> posted, and I've seen that a lot before).

That'll be where exit() takes down the tasks's address spaces.  
zap_page_range().  That's a nasty one.

> I've seen sync_old_buffers
> hold the BKL for 64ms on an 8way Specweb99 run (22Gb of RAM?)
> (though this was on an older 2.4 kernel, and might be fixed by now).

That will still be there - presumably it's where we walk the
per-superblock dirty inode list.  hmm.

For lru_list_lock we can do an end-around by not using
buffers at all.

The other big one is truncate_inode_pages().  With ratcache
it's not a contention problem, but it is a latency problem.
I expect that we can drastically reduce the lock hold time
there by simply snipping the wholly-truncated pages out of
the tree, and thus privatising them so they can be disposed
of outside any locking.

-
