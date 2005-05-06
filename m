Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVEFRsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVEFRsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 13:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVEFRsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 13:48:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:3525 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261226AbVEFRr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 13:47:59 -0400
Date: Fri, 6 May 2005 10:47:41 -0700
From: Chris Wright <chrisw@osdl.org>
To: bmerry@cs.uct.ac.za
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Holding ref to /proc/<pid> dentry prevents task being freed
Message-ID: <20050506174741.GY23013@shell0.pdx.osdl.net>
References: <20050505091131.GA4472@omnius.cs.uct.ac.za> <20050505163413.GW23013@shell0.pdx.osdl.net> <20050506081753.GA3759@omnius.cs.uct.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506081753.GA3759@omnius.cs.uct.ac.za>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* bmerry@cs.uct.ac.za (bmerry@cs.uct.ac.za) wrote:
> On Thu, May 05, 2005 at 09:34:13AM -0700, Chris Wright wrote:
> > * bmerry@cs.uct.ac.za (bmerry@cs.uct.ac.za) wrote:
> > > I'm busy writing a security module that does some very basic ACL stuff
> > > on a per-task basis. If my module obtains and holds a dentry for
> > > /proc/<pid> (via path_lookup), then the task_free_security hook is
> > > never called for that process. Since the module releases the dentry in
> > > task_free_security, this creates a chicken-and-egg problem and neither
> > > the task nor the dentry is ever released. A side-effect is that the
> > > module refcount never drops to 0.
> > 
> > Why are you holding that dentry?  Some more background please.
> 
> Just realised that I never mentioned what kernel I've been using:
> 2.6.11.7.
> 
> The security module is for sandboxing. The basic idea is that a wrapper
> process passes a bunch of paths to the module, then execs the program
> that should be sandboxed. After the exec, the process should only be
> allowed access to those paths and their subdirectories (actually there
> are some flags passed too to say what permissions are granted, but
> that isn't really relevant).
> 
> Rather than calling d_path on every access request and doing string
> matching (sounds hideously slow), I use path_lookup to get a dentry/mnt
> pair for each path passed in (once when it is passed in). Then the
> inode_permission hook walks up the filesystem, matching dentries.

This can break with hard links, bind mounts, etc.  Can you not label the
inode directly?

> Some processes have a legitimate reason for accessing /proc/<pid> (pid
> of that process). Java, for example, does readlink("/proc/self/exe") to
> find the binary. So the wrapper passes /proc/<pid> to the module, which
> looks up and holds the dentry for it. I don't want to give blanket
> permission to /proc, since preventing the sandbox from getting
> information about what else is happening on the system is fairly
> important to my application.

Did you look at security_task_to_inode?  It's there to help you label the
task based proc entries' inodes directly.

> At the moment I'm looking at hard-coding special behaviour for /proc
> into the module, but I was wondering if there was a simpler way around
> this problem.

You'll likely regret hardcoding something like that.

> Incidentally, is it intentional that vfsmount_lock is not exported to
> modules? My walk-up-the-tree code is essentially d_path without
> constructing the string, but I've had to remove the lock and unlock of
> vfsmount_lock because I don't have the symbol.

It's on the grounds that you shouldn't be poking about vfsmounts as it's 
very core to vfs.  Right answer is to use helpers (or identify a
legimate need for a new helper).  In this case, your code is now
hopelessly racy, and I think would be better served by dealing with the
inode directly.

Hope that helps,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
