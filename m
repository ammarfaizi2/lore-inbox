Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVEFIRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVEFIRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 04:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVEFIRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 04:17:31 -0400
Received: from casper2.cs.uct.ac.za ([137.158.96.99]:33766 "EHLO
	casper2.cs.uct.ac.za") by vger.kernel.org with ESMTP
	id S261170AbVEFIRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 04:17:21 -0400
Date: Fri, 6 May 2005 10:17:54 +0200
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Holding ref to /proc/<pid> dentry prevents task being freed
Message-ID: <20050506081753.GA3759@omnius.cs.uct.ac.za>
References: <20050505091131.GA4472@omnius.cs.uct.ac.za> <20050505163413.GW23013@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505163413.GW23013@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
From: bmerry@cs.uct.ac.za
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 09:34:13AM -0700, Chris Wright wrote:
> * bmerry@cs.uct.ac.za (bmerry@cs.uct.ac.za) wrote:
> > I'm busy writing a security module that does some very basic ACL stuff
> > on a per-task basis. If my module obtains and holds a dentry for
> > /proc/<pid> (via path_lookup), then the task_free_security hook is
> > never called for that process. Since the module releases the dentry in
> > task_free_security, this creates a chicken-and-egg problem and neither
> > the task nor the dentry is ever released. A side-effect is that the
> > module refcount never drops to 0.
> 
> Why are you holding that dentry?  Some more background please.

Just realised that I never mentioned what kernel I've been using:
2.6.11.7.

The security module is for sandboxing. The basic idea is that a wrapper
process passes a bunch of paths to the module, then execs the program
that should be sandboxed. After the exec, the process should only be
allowed access to those paths and their subdirectories (actually there
are some flags passed too to say what permissions are granted, but
that isn't really relevant).

Rather than calling d_path on every access request and doing string
matching (sounds hideously slow), I use path_lookup to get a dentry/mnt
pair for each path passed in (once when it is passed in). Then the
inode_permission hook walks up the filesystem, matching dentries.

Some processes have a legitimate reason for accessing /proc/<pid> (pid
of that process). Java, for example, does readlink("/proc/self/exe") to
find the binary. So the wrapper passes /proc/<pid> to the module, which
looks up and holds the dentry for it. I don't want to give blanket
permission to /proc, since preventing the sandbox from getting
information about what else is happening on the system is fairly
important to my application.

At the moment I'm looking at hard-coding special behaviour for /proc
into the module, but I was wondering if there was a simpler way around
this problem.

Incidentally, is it intentional that vfsmount_lock is not exported to
modules? My walk-up-the-tree code is essentially d_path without
constructing the string, but I've had to remove the lock and unlock of
vfsmount_lock because I don't have the symbol.

Thanks
Bruce

[Please cc me on replies. I'm not subscribed to LKML]
-- 
/--------------------------------------------------------------------\
| Bruce Merry                      | bmerry at cs . uct . ac . za    |
| Proud user of Gentoo GNU/Linux   | http://www.cs.uct.ac.za/~bmerry |
|       In the force if Yoda's so strong, construct a sentence       |
|         with words in the proper order then why can't he?          |
\--------------------------------------------------------------------/
