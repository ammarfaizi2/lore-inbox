Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbRF0UZ4>; Wed, 27 Jun 2001 16:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbRF0UZq>; Wed, 27 Jun 2001 16:25:46 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:32015
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265180AbRF0UZe>; Wed, 27 Jun 2001 16:25:34 -0400
Date: Wed, 27 Jun 2001 16:24:10 -0400
From: Chris Mason <mason@suse.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
        andrea@suse.de,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
Message-ID: <933130000.993673450@tiny>
In-Reply-To: <Pine.LNX.4.33L.0106271641570.23373-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, June 27, 2001 04:43:28 PM -0300 Rik van Riel
<riel@conectiva.com.br> wrote:

> On Wed, 27 Jun 2001, Chris Mason wrote:
> 
>> Reiserfs expects write_inode() calls initiated by kswapd to
>> always have sync==0.  Otherwise, kswapd ends up waiting on the
>> log, which isn't what we want at all.
> 
> If you don't have free memory, you are limited to 2 choices:
> 
> 1) wait on IO
> 2) spin endlessly, wasting CPU until the IO is done
> 
> If (1) isn't possible in reiserfs, I'd say something in
> reiserfs needs to be fixed, otherwise you will always
> have problems when the system has lots of dirty mappings
> that need to be written out.
> 

Ok, I need to describe the problem a little better.  reiserfs inodes need
to be logged, which means you have to join/start a transaction in order to
write them.

So, if kswapd tries to write them, it might end up waiting on the log.
Normally this is not a big deal, but almost allocations in reiserfs use
GFP_BUFFER, which means we never end up doing i/o ourselves in
page_launder, and always end up waiting on kswapd.  So, kswapd waits on
reiserfs and reiserfs waits on kswapd (none of these are spin locks ;-)

The work around I've been using is the dirty_inode method.  Whenever
mark_inode_dirty is called, reiserfs logs the dirty inode.  This means
inode changes are _always_ reflected in the buffer cache right away, and
the inode itself is never actually dirty.

So, the only time reiserfs_write_inode needs to do something is for fsync
and/or O_SYNC writes, and all it needs to do is commit the transaction.  

Any time kswapd is calling write_inode, it is just trying to free the inode
struct, and reiserfs can safely ignore the write request, regardless of if
a sync is requested.

-chris

