Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbTCHSMb>; Sat, 8 Mar 2003 13:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbTCHSMa>; Sat, 8 Mar 2003 13:12:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25867 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262129AbTCHSM3>; Sat, 8 Mar 2003 13:12:29 -0500
Date: Sat, 8 Mar 2003 10:20:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 6/6 cacheline align files_lock
In-Reply-To: <20030308181011.A30313@infradead.org>
Message-ID: <Pine.LNX.4.44.0303081015440.2954-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Mar 2003, Christoph Hellwig wrote:
> 
> Agreed, that's what I actually though when looking into that stuff in more
> detail a while ago - I just couldn't remember everything now that Martin
> brought it up again.  Killing the freelist seems like a good idea anyway
> (or rather keep a small list for the reserved filp that is used only
> _after_ kmem_cache_alloc() failed)

Well, the sad part, though, is that the file lists are almost never 
actually _used_, so even if this is made per-superblock that won't get 
over the fact that

 (a) much of the time you'll still get the lock overhead (not very many
     superblocks would be impacted: it would usually spread out the
     current load over two or three super-blocks: pipes, networking and
     "real" filesystem) and

 (b) it would _still_ be for something that almost never happens -
     relatively speaking (ie it's currently used for hanging up terminals
     and for unmounts, and nothing else, I think)

I think we might actually be able to make it really go away, if the file
list was made per-dentry or something like that (and then use the existing
dentry->lock instead of dcache_lock). We already keep track of dentries
for "umount", and if we made the tty layer use another list, we'd get rid 
of this whole lock entirely.

At this point, though, the 2.6.x thing is clearly to just avoid the false 
sharing. But somebody can work on this if they feel like a 2.7.x 
challenge.

		Linus

