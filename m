Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291293AbSBGUwq>; Thu, 7 Feb 2002 15:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291294AbSBGUwf>; Thu, 7 Feb 2002 15:52:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14865 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291293AbSBGUw2>;
	Thu, 7 Feb 2002 15:52:28 -0500
Message-ID: <3C62E8D6.9FDAF382@zip.com.au>
Date: Thu, 07 Feb 2002 12:51:34 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] VM_IO fixes
In-Reply-To: <3C621B44.10C424B9@zip.com.au> <Pine.LNX.4.33.0202071259510.5900-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> On Wed, 6 Feb 2002, Andrew Morton wrote:
> 
> > Any filesystem which implements its own mmap() method, and which
> > does not call generic_file_mmap() needs to be changed to clear
> > VM_IO inside its mmap function.  All in-kernel filesystems are
> > OK, as is XFS.  And the only breakage this can cause to out-of-kernel
> > filesystems is failure to include mappings in core files, and
> > inability to use PEEKUSR.
> 
> You forgot shared memory via mm/shmem.c and ipc/shm.c.
> Another possibility is to test whether the driver provides a nopage
> function, as i/o areas are usually mapped with io_remap_page_range. The
> only exception I found are drivers under drivers/sgi/char, which use some
> really dirty tricks in their nopage function.

ugh.  This just isn't working out.

Sure, inverting the default value of VM_IO is much safer, because
the penalty for getting it wrong is broken coredumps and ptrace,
rather than kernel crashes.

But there are still many areas which need changing, and thinking
about.  Stuff like ftape_mmap, sound_mmap, packet_mmap, mmap_mem,
mmap_zero, ...

I'm wondering if we can automagically determine whether the
mapping is safe to peek and coredump within the mmap and mremap
functions themselves?  All this would take is the ability to
determine that the entire vma is backed by valid page structs.

Is there a fast and portable way of doing this?

-
