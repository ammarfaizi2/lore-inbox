Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281963AbRKZSJv>; Mon, 26 Nov 2001 13:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281998AbRKZSJG>; Mon, 26 Nov 2001 13:09:06 -0500
Received: from ns.caldera.de ([212.34.180.1]:45506 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281995AbRKZSIe>;
	Mon, 26 Nov 2001 13:08:34 -0500
Date: Mon, 26 Nov 2001 19:08:20 +0100
Message-Id: <200111261808.fAQI8KK26768@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: mingo@elte.hu (Ingo Molnar)
Cc: "David S. Miller" <davem@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0111262026120.15876-100000@localhost.localdomain>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

In article <Pine.LNX.4.33.0111262026120.15876-100000@localhost.localdomain> you wrote:
> On 26 Nov 2001, Momchil Velikov wrote:
>
>> Yep.  Folks on #kernelnewbies told me about it, when there were only
>> changes to ``shrink_cache'' left.  So, I decided to funish mine ;)
>
> ok :) A search on Google for 'scalable pagecache' brings you straight to
> our patch. I've uploaded the patch against 2.4.16 as well:
>
>   http://redhat.com/~mingo/smp-pagecache-patches/pagecache-2.4.16-A1
>
> this is a (tested) port of the patch to the latest VM.

This patch seems to have a number of interesting changes compared to
older versions.

 - do_generic_file_read() now takes an additional integer parameter,
   'nonblock'.  This one always is zero, though.  Why do you break
   the interface?
 - there is a new global function, flush_inode_pages().  It is not
   used at all.  What is this one supposed to do?
 - file_send_actor() is no more static in mm/filemap.c.  I'm perfectly
   fine with that as I will need that for the UnixWare sendv64 emulation
   in Linux-ABI, but again no user outside of filemap.c exists.
 - you change a number of parameters called 'offset' into 'index',
   this makes sense to me, but doesn't really belong into this diff..
 - due to the additional per-bucket spinlock the pagecache size
   dramatically increases.  Wouldn't it be a good idea to switch to
   bootmem allocation so very big machines still can have the full
   size, not limited by __get_free_pages failing?

