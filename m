Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbULQWx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbULQWx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbULQWwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:52:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:2973 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262220AbULQWtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:49:50 -0500
Date: Fri, 17 Dec 2004 16:49:44 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: wli@holomorphy.com, mingo@elte.hu
Subject: Oops on 2.4.x invalid procfs i_ino value
Message-ID: <Pine.SGI.4.61.0412171611120.27132@kzerza.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've run into a number of crashes while closing procfs stat files
when a system is under load.  I think I've found the problem, but
am a little unsure how to proceed.  This all happens to be on a
2.4.21 based kernel, but by my brief code inspection I think the
problem still exists on more recent 2.4.x kernels.

In procfs the fake_ino() macro is used to construct the inode number
for each entry.

	#define fake_ino(pid,ino) (((pid)<<16)|(ino))

In particular this is used in proc_pid_make_inode:

	inode->i_ino = fake_ino(task->pid, ino);

Note that a pid may be more than 16 bits in width (e.g. in IA64), and
we're trying to stuff it into the upper 16 bits of the inode number.
This isn't usually a problem, except when the lower 16 bits of the
inode happen to be 0 (i.e. pids that are a multiple of 65536).

Why does zero matter?  Glad you asked.

In proc_delete_inode there is a check to see if the inode is is
a "proper" (whatever that means) procfs inode.  The whole function
is:

static void proc_delete_inode(struct inode *inode)
{
	struct proc_dir_entry *de = inode->u.generic_ip;

	inode->i_state = I_CLEAR;

	if (PROC_INODE_PROPER(inode)) {
		proc_pid_delete_inode(inode);
		return;
	}
	if (de) {
		if (de->owner)
			__MOD_DEC_USE_COUNT(de->owner);
		de_put(de);
	}
}

PROC_INODE_PROPER() is:

	#define PROC_INODE_PROPER(inode) ((inode)->i_ino & ~0xffff)

In other words, it checks whether the top 16 bits of the inode number
(equivalent to the bottom 16 bits of the pid) are non-zero.

Thus closing a proc entry for any task with a pid that is a multiple of
65536 will fail this check, skip proc_pid_delete_inode, and call
__MOD_DEC_USE_COUNT, more than likely causing a panic on an invalid
memory access, and minimally corrupting something in memory otherwise.

I don't have a solution coded up (mostly because I'm a bit bleary
eyed after looking at crash dumps all day) -- but are there any
thoughts on how to go about addressing this one?  An obvious workaround
is setting kernel.pid_max to 65535, but that's only a workaround, not
a solution.

On a related note, if it matters, on about half the crash dumps I've
looked at, I see a pid of 0 has been assigned to a user process,
tripping this same problem.  I suspect there's another bug somewhere
that's allowing a pid of 0 to be chosen in the first place -- but I
don't totally discount that this problem may lay in SGI's patches to
this particular kernel -- I'll need to take a more thorough look.

Thanks,
Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
