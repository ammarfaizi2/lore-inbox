Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265974AbRF1O0q>; Thu, 28 Jun 2001 10:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265972AbRF1O0i>; Thu, 28 Jun 2001 10:26:38 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:17669
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265967AbRF1O01>; Thu, 28 Jun 2001 10:26:27 -0400
Date: Thu, 28 Jun 2001 10:25:17 -0400
From: Chris Mason <mason@suse.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
        andrea@suse.de,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
Message-ID: <1075290000.993738317@tiny>
In-Reply-To: <3B3B3A65.844C3880@uow.edu.au>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday, June 29, 2001 12:08:37 AM +1000 Andrew Morton
<andrewm@uow.edu.au> wrote:

> The reason ->write_inode() can be a no-op is that __sync_one()
> marks the inode clean, then calls ->write_inode().  We *know*
> that we took a copy of the inode in mark_inode_dirty(), so
> we don't need to do anything.

Yes, the only exception is that write_inode needs to honor the sync flag,
at least when not called under PF_MEMALLOC.  The biggest reason I can find
so far is knfsd, who calls write_inode_now and expects the inode to be
securely on disk.  It doesn't call mark_inode_dirty directly, it calls some
FS func (link, create, whatever) and then uses write_inode_now to commit.

> 
> Of course this absolutely requires all inode dirtiers to
> call mark_inode_dirty() after doing the dirty, which is a risk.
> But we face that risk with the PF_MEMALLOC case anyway.  No
> problems have appeared in testing.

I haven't seen any problems caused by it yet, but that might be because
reiserfs does all the important inode writes on its own.  I believe
generic_commit_write is the only place outside the FS that calls
mark_inode_dirty with something other than an atime update.

-chris

