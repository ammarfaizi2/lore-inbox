Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVEGJcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVEGJcz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 05:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVEGJcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 05:32:55 -0400
Received: from casper2.cs.uct.ac.za ([137.158.96.99]:56055 "EHLO
	casper2.cs.uct.ac.za") by vger.kernel.org with ESMTP
	id S262902AbVEGJcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 05:32:50 -0400
Date: Sat, 7 May 2005 11:33:46 +0200
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Holding ref to /proc/<pid> dentry prevents task being freed
Message-ID: <20050507093346.GA20467@omnius.cs.uct.ac.za>
References: <20050505091131.GA4472@omnius.cs.uct.ac.za> <20050505163413.GW23013@shell0.pdx.osdl.net> <20050506081753.GA3759@omnius.cs.uct.ac.za> <20050506174741.GY23013@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506174741.GY23013@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
From: bmerry@cs.uct.ac.za
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 10:47:41AM -0700, Chris Wright wrote:
> > Rather than calling d_path on every access request and doing string
> > matching (sounds hideously slow), I use path_lookup to get a dentry/mnt
> > pair for each path passed in (once when it is passed in). Then the
> > inode_permission hook walks up the filesystem, matching dentries.
> 
> This can break with hard links, bind mounts, etc.  Can you not label the
> inode directly?

I assume you mean using security attributes in the FS, ala SE Linux?
The problem with that is that each task will have a different ACL. So
I'd have to label the inodes with per-pid tags, make sure the tags got
removed when the task exited, worry about PID reuse, worry about a
crash leaving bogus tags on inodes etc. Or do you mean storing data in
the inode->i_security field? That then raises questions about memory
consumption, since I need to store data per (task, inode) pair.

I also really do want to grant permission to directory trees. For
example, I may want it to be possible to run Java apps, which means
granting access to the whole of /opt/sun-jdk-1.5.0.02. Perhaps I should
just have userspace walk that tree and pass all the files in it to the
security module? Somehow that seems unclean, in that files added to the
tree after the walk are not included, and those moved out of the tree
are not excluded. The walk could also take quite a while if I grant
access to a large tree (/usr maybe), only a small fraction of which is
ever accessed.

I'm aware that there may well be no canonical path to an inode.
However, the sandboxed processes have no ability to do mounts or to
make hard links, so I don't think this is exploitable.

BTW if I do go with storing a big list of inodes in each 

> > Some processes have a legitimate reason for accessing /proc/<pid> (pid
> > of that process). Java, for example, does readlink("/proc/self/exe") to
> > find the binary. So the wrapper passes /proc/<pid> to the module, which
> > looks up and holds the dentry for it. I don't want to give blanket
> > permission to /proc, since preventing the sandbox from getting
> > information about what else is happening on the system is fairly
> > important to my application.
> 
> Did you look at security_task_to_inode?  It's there to help you label the
> task based proc entries' inodes directly.

Thanks, I wasn't aware of that. I'll look into it.

> 
> > At the moment I'm looking at hard-coding special behaviour for /proc
> > into the module, but I was wondering if there was a simpler way around
> > this problem.
> 
> You'll likely regret hardcoding something like that.

Quite. Hence I'm looking for a simpler way :-)

> > Incidentally, is it intentional that vfsmount_lock is not exported to
> > modules? My walk-up-the-tree code is essentially d_path without
> > constructing the string, but I've had to remove the lock and unlock of
> > vfsmount_lock because I don't have the symbol.

In fact it gets worse than this. Many of the LSM inode hooks get given
only a dentry, not a nameidata (i.e. no vfsmount). So I've hacked a
function to find a vfsmount from a superblock (again, without the
lock), but obviously bind mounts will mess that up totally.

> It's on the grounds that you shouldn't be poking about vfsmounts as it's 
> very core to vfs.  Right answer is to use helpers (or identify a
> legimate need for a new helper).  In this case, your code is now
> hopelessly racy, and I think would be better served by dealing with the
> inode directly.

Ok, I'm pretty new to kernel hacking, so I'm not familiar with all the
helpers available. Would path_walk("..", &nd) do what I want (i.e. give
me the parent of a nameidata)? And what would be the best way to map a
super_block to a vfsmount? I know that isn't necessarily a well-defined
operation, but I'll be happy to get *an* answer (on the system I will
be using the module on, there will be no bind mounts and filesystems
like /proc will only be mounted once, so there will be a unique answer).

At the moment this module will only be deployed on a single UP machine
with preemption disabled (a computer olympiad handin server, that runs
and marks code that people submit over the web), so races hopefully
shouldn't matter. But yes, every time I look at that code I start
twitching.

> Hope that helps,
> -chris

Yes, thanks for all your help on this. Even if I don't agree with the
inode-based approach, you've given me ideas and things to think about.

Bruce
-- 
/--------------------------------------------------------------------\
| Bruce Merry                      | bmerry at cs . uct . ac . za    |
| Proud user of Gentoo GNU/Linux   | http://www.cs.uct.ac.za/~bmerry |
|   "Oh dear, I think you'll find reality is on the blink again."    |
|          -- Marvin, the Hitchhikers Guide to the Galaxy.           |
\--------------------------------------------------------------------/
