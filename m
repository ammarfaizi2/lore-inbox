Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317581AbSGOSgK>; Mon, 15 Jul 2002 14:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSGOSgK>; Mon, 15 Jul 2002 14:36:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11794 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317581AbSGOSgH>;
	Mon, 15 Jul 2002 14:36:07 -0400
Message-ID: <3D331648.64AC0C25@zip.com.au>
Date: Mon, 15 Jul 2002 11:36:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Marcelo Tosatti'" <marcelo@conectiva.com.br>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Carter K. George'" <carter@polyserve.com>,
       "'Don Norton'" <djn@polyserve.com>,
       "'James S. Tybur'" <jtybur@polyserve.com>,
       "Gross, Mark" <mark.gross@intel.com>
Subject: Re: fsync fixes for 2.4
References: <01BDB7EEF8D4D3119D95009027AE99951B0E6428@fmsmsx33.fm.intel.com> <20020715100719.GE34@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> as for the scaling with async flushes to multiple devices, 2.4 has a
> single flushing thread, 2.5 as Andrew said (partly) fixes this as he
> explained me at OLS, with multiple pdflush. The only issue I seen in his
> design is that he works based on superblocks, so if a filesystem is on
> top of a lvm backed by a dozen of different harddisks, only one pdflush
> will pump on those dozen physical request queues, because the first
> pdflush entering the superblock will forbid other pdflush to work on the
> same superblock too. So the first physical queue that is full, will
> forbid pdflush to push more dirty pages to the other possibly empty
> physical queues.

Well.  There's no way in which we can get effective writeback against
200 spindles by relying on pdflush, so that daemon is mainly there
to permit background writeback under light-to-moderate loads.

Once things get heavy, the only sane approach is to use the actual
caller of write(2) as the resource for performing the writeback.
As we're currently doing, in balance_dirty[_pages]().  But the
problem there is that in both 2.4 and 2.5, a caller to that function
can easily get stuck on the wrong queue, and bandwidth really suffers.

I've been working on changing 2.5 so that the write(2) caller no
longer performs a general "writeback of everything" - that caller
instead performs writeback specifically against the queue which
he just dirtied.  Do this by using the address_space->backing_dev_info
as a key during a search across the superblocks and blockdev inodes.
That works quite well.

But there's still a problem where pdflush goes to writeback a queue
and fills it up, so the userspace program ends up blocking (due to
pdflush's activity) when it really should not.  Still undecided about
what to do about that.

And yes, point taken on the LVM thing.  If the chunk size is reasonably
small (a few megabytes) then we should normally get decent concurrency,
but there will be corner-cases.

-
