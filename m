Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTFTKI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTFTKI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:08:28 -0400
Received: from mail9.speakeasy.net ([216.254.0.209]:8682 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S262623AbTFTKIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:08:25 -0400
Reply-To: <mishka99@speakeasy.net>
From: "Michael Umansky" <mishka99@speakeasy.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rgooch@atnf.csiro.au>
Subject: Proposed fix for i_sem deadlock in devfs in 2.4.2x kernel
Date: Fri, 20 Jun 2003 03:20:49 -0700
Message-ID: <000001c33715$a1fbf1f0$6401a8c0@cowboy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wasn't sure to whom I should be sending this report and I'm sorry in
advance if this posting is too wordy for this list ...

In the recent must-fix list there is a comment about a deadlock in devfs
but there are no details as to exactly what that deadlock is and no
reference to a suggested fix or if it is being worked on.  Since I keep
hitting this particular problem (and others might too) I decided to
submit a fix for it.  Please copy my personal email address (in reply-to)
if responding to this posting.

Note, this fix does the same thing as the original code that opened the
hole for this deadlock but at least the logic is consistent and the fix
is simple enough to serve its purpose until a better solution (redesign?)
is provided.  With that in mind ...

This deadlock is very timing sensitive but my kernel builds just right
so that this deadlock occurs every single boot.  The deadlock is between
devfs_lookup() and devfs_d_revalidate_wait() routines in fs/devfs/base.c
(at least in my copy of the 2.4.21 kernel).

First lookup of a path in /dev (after mounting of devfs) via lookup_hash()
will fail in cached_lookup() and will fall through to inode->i_op->lookup()
which in this case will call to devfs_lookup().  That routine will do an
up() to release directory semaphore and will sleep via schedule() (from
wait_for_devfsd_finished()).  This release of the semaphore opens the hole
for the deadlock.

Second (or 3rd, ...) lookup on the same path comes along and hits jackpot
in cached_lookup() but now has to revalidate the data so it calls
dentry->d_op->d_revalidate() which ends up calling
devfs_d_revalidate_wait().
Under certain conditions that routine will go to sleep (WITHOUT releasing
directory semaphore which has been SUCCESSfully acquired in upper layers
because it was up'd in devfs_lookup() before it slept).

The wakeup for the devfs_d_revalidate_wait() sleep is done at the end of
the devfs_lookup() routine which, up to now, has been sleeping.  When it
(devfs_lookup()) wakes up it will try to do the down() to re-acquire the
directory semaphore but now it can't get the semaphore since the other
code path owns it AND the other code path (devfs_d_revalidate_wait())
can't finish because it is waiting for the wakeup from devfs_lookup()
- hence deadlock!

The proposed simple fix (with caveat mentioned above) is to add up()/down()
calls around the call to schedule() from within the
devfs_d_revalidate_wait()
routine.  I have tested this fix extensively and it works and I have not
(yet)
seen any adverse side effects of the extra up()/down() sequence.

Snippets of code below to show an example of the deadlock sequence.

======================================================

Somewhere in the kernel:

unix_bind()
{
	...
	down(&....i_sem);
	lookup_hash();		/* first lookup */
	up(&....i_sem);
	...
}

sys_unlink()
{
	...
	down(&....i_sem);
	lookup_hash();		/* second lookup */
	up(&....i_sem);
	...
}

lookup_hash()
{
	...
	dentry = cached_lookup();
	if (!dentry) {
		...
		/* first lookup will come here */
		dentry = inode->i_op->lookup() -> devfs_lookup()
		...
	}
	...
}

cached_lookup()
{
	...
	/* second lookup will come here */
	dentry->d_op->d_revalidate() -> devfs_d_revalidate_wait()
	...
}

In file fs/devfs/base.c (v1.12c):

devfs_d_revalidate_wait()
{
	...
	read_lock(...)
	...
	add_wait_queue(&lookup_info->wait_queue, ...);
	read_unlock(...)
	up(&dir->i_sem);		/* add for this proposed fix */
	schedule();
	down(&dir->i_sem);	/* add for this proposed fix */
	...
}


devfs_lookup()
{
	...
	up(&dir->i_sem);
	wait_for_devfsd_finished();	/* this will sleep via schedule() */
	down(&dir->i_sem);		/* this hangs - see above */
	...
	wake_up(&lookup_info.wait_queue);
	...
}

=================================

thanks
Michael Umansky
mishka99@speakeasy.net


