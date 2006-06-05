Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751028AbWFEL5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWFEL5b (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWFEL5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:57:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:18852 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751014AbWFEL5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:57:30 -0400
Subject: Re: [PATCH] jfs: possible deadlocks - continue
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: Ingo Molnar <mingo@elte.hu>, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060605050022.GA15176@rain.homenetwork>
References: <20060604154409.GA13899@rain.homenetwork>
	 <1149457796.10576.14.camel@kleikamp.austin.ibm.com>
	 <20060605050022.GA15176@rain.homenetwork>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 06:57:28 -0500
Message-Id: <1149508648.10215.19.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 09:00 +0400, Evgeniy Dushistov wrote:
> On Sun, Jun 04, 2006 at 04:49:56PM -0500, Dave Kleikamp wrote:
> > On Sun, 2006-06-04 at 19:44 +0400, Evgeniy Dushistov wrote:
> > > I should add that this happened during boot, when root jfs
> > > file system become from ro->rw
> > > 
> > > I look at code, and see that
> > > 1)locks wasn't release in the opposite order in which
> > > they were taken
> > 
> > Why does this matter?
> > 
> Like "3" it make code more understandable,
> reader of code don't have to think why
> code looks like:
> lock A, lock B unlock A, unlock B
> while a normal practice in kernel:
> lock A, lock B unlock B unlock A
> the goal of change just simplicity and clearness,
> and nothing more.

Well, when the locks are released at one place, I don't buy that it make
the code any easier to understand.  However, I understand that it makes
it easier for the validator to do its job, so I'm happy with all three
parts of the patch.  I'll push it to the -mm tree.

> 
> > I think the warning needs to be fixed by introducing mutex_lock_nested
> > in some places.  I'll take a look at it.
> > 
> To avoid incomprehension, previous patch just make code more
> understandable and unlock mutex on "error path", it doesn't fix
> this warning and I have no idea why it happend:

I understand the warning.  jfs is taking the same mutex (commit_mutex)
on two inodes, which has the potential to for two threads to deadlock.
I believe the order the locks are taken is safe (always taking the
parent first).  In fact, I think any operations involving more than one
inode are already protected by i_mutex on the parents.  I'm sure I can
fix it with mutex_lock_nested.

> ====================================
> [ BUG: possible deadlock detected! ]
> ------------------------------------
> mount/5587 is trying to acquire lock:
>  (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
> 
> but task is already holding lock:
>  (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
> 
> which could potentially lead to deadlocks!
> 
> other info that might help us debug this:
> 2 locks held by mount/5587:
>  #0:  (&inode->i_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15
>  #1:  (&jfs_ip->commit_mutex){--..}, at: [<c02f7096>] mutex_lock+0x12/0x15

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

