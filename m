Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316268AbSEKTqd>; Sat, 11 May 2002 15:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316269AbSEKTqc>; Sat, 11 May 2002 15:46:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38151 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316268AbSEKTqc>;
	Sat, 11 May 2002 15:46:32 -0400
Date: Sat, 11 May 2002 20:45:51 +0100
From: Matthew Wilcox <willy@debian.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: matthew@wil.cx, linux-kernel@vger.kernel.org
Subject: Re: fs/locks.c BKL removal
Message-ID: <20020511204551.M32414@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <3CDC4037.8040104@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 02:48:39PM -0700, Dave Hansen wrote:
> I'm looking into the fs/locks.c mess.  It appears that there was an 
> attempt to convert this over to a semaphore, but it was removed just 
> before the 2.4 release because of some deadlocks.

Actually, performance problems ...

> Whenever the i_flock list is traversed, the BKL is held.  It is also 
> held while running through the file_lock_list which I think is used 
> only for /proc/locks.

Correct.

> We definitely need a semaphore because of all the blocking that goes 
> on.  We can either have a global lock for all of them, which I think 
> was tried last time.  Or, we can split it up a bit more.  With the 
> current design, there will need to be a lock for the global list, each 
> individual list, and one for each individual lock to protect against 
> access from the reference in the file_lock_list and the inode->i_flock 
> list.

Nah.  Though I'm glad you missed it too; it means that I'm not as
stupid as I thought I was for only noticing it 2 years later.  Look at
locks_wake_up_blocks (this is basically the _only_ tricky part).  This has
to be called with a wait argument which is true.  The only time that
can happen is if locks_delete_lock is called with a `true' parameter.
And the only time _that_ happens is when the _type_ of an flock lock is
being changed.

And really, what's happening here?  We have a BSD flock which is blocking
one or more locks.  Those processes have to have the opportunity
to acquire the lock before the previously-blocking process gets the
opportunity to acquire its lock.  But that doesn't mean we need to schedule once
for _each_ task which is blocked; we only need to yield once.

So we can eliminate the `wait' argument to locks_delete_lock,
locks_wake_up_blocks and the arm of the conditional in
locks_wake_up_blocks which sleeps.  We only need to check in
flock_lock_file whether we're unlocking and yield if we aren't.

I'm currently doing a major restructure of fs/locks.c, and this problem
(along with several others) simply disappears.  I'm looking for a
testsuite before I release this code to the world ... anybody got one?

> However, I think that the file_lock_list complexity may be able to be 
> reduced.  If we make the file_lock_list a list of inodes (or just the 
> i_flocks) with active locks, we can avoid the complexity of having an 
> individual file_lock lock.  That way, we at least reduce the number of 
> _types_ of locks.  It increases the number of dereferences, but this 
> is /proc we're talking about.  Any comments?

Ick... I'd really like to see one spinlock protecting all activity in this
area.  And obviously not the magic BKL ;-)

> Talking about locks for locks is confusing :)

Tell me about it!  I'm close to calling things `blocks' `plocks',
`leases' and `mlocks', just to reduce the namespace conflicts.  But it's
not obvious those refer to BSD locks, POSIX locks and Mandatory locks...

-- 
Revolutions do not require corporate support.
