Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbRF0Uxa>; Wed, 27 Jun 2001 16:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265399AbRF0UxU>; Wed, 27 Jun 2001 16:53:20 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:45071
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265396AbRF0UxQ>; Wed, 27 Jun 2001 16:53:16 -0400
Date: Wed, 27 Jun 2001 16:52:25 -0400
From: Chris Mason <mason@suse.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
        andrea@suse.de,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
Message-ID: <946960000.993675145@tiny>
In-Reply-To: <Pine.LNX.4.33L.0106271733280.23373-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, June 27, 2001 05:36:45 PM -0300 Rik van Riel
<riel@conectiva.com.br> wrote:

> On Wed, 27 Jun 2001, Chris Mason wrote:
>> On Wednesday, June 27, 2001 04:43:28 PM -0300 Rik van Riel
> 
>> > If you don't have free memory, you are limited to 2 choices:
>> > 
>> > 1) wait on IO
>> > 2) spin endlessly, wasting CPU until the IO is done
>> 
>> Ok, I need to describe the problem a little better.  reiserfs
>> inodes need to be logged, which means you have to join/start a
>> transaction in order to write them.
> 
>> So, the only time reiserfs_write_inode needs to do something is for fsync
>> and/or O_SYNC writes, and all it needs to do is commit the transaction.
>> 
>> Any time kswapd is calling write_inode, it is just trying to
>> free the inode struct, and reiserfs can safely ignore the write
>> request, regardless of if a sync is requested.
> 
> OK, sounds sane enough to me ;)

Well, I guess that's one word for it...I'll bet $5 Al's got a few others
;-) A better fix is to have private inode dirty lists....

> 
> So the fix is just to let reiserfs_write_inode always be
> asynchronous, independent of its arguments, as long as
> we're not in fsync() or O_SYNC.

I think so, but there needs to be some testing there.  Note that I managed
to run a heavy stress test (put my machine far, far into swap) for 3 solid
days without hitting this.  When I initially made the dirty_inode kludge, I
could trigger it in ~10 minutes.  

> 
> OTOH, if we are called synchronously, we could also just
> walk down the code path taken when we _are_ called by
> fsync(), right ?

sorry, not sure what you mean.  In fsync we do a commit, which might wait
on the current transaction, so kswapd can't go down that code path.

-chris


