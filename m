Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUBZQIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbUBZQFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:05:42 -0500
Received: from nevyn.them.org ([66.93.172.17]:11149 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262809AbUBZQCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:02:54 -0500
Date: Thu, 26 Feb 2004 11:02:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, kingsley@aurema.com,
       linux-kernel@vger.kernel.org
Subject: Re: /proc visibility patch breaks GDB, etc.
Message-ID: <20040226160240.GA28873@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Peter Chubb <peter@chubb.wattle.id.au>, kingsley@aurema.com,
	linux-kernel@vger.kernel.org
References: <16445.37304.155370.819929@wombat.chubb.wattle.id.au> <20040225224410.3eb21312.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225224410.3eb21312.akpm@osdl.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 10:44:10PM -0800, Andrew Morton wrote:
> Peter Chubb <peter@chubb.wattle.id.au> wrote:
> >
> > 
> > In fs/proc/base.c:proc_pid_lookup(), the patch
> > 
> >         read_unlock(&tasklist_lock); 
> >         if (!task) 
> >                 goto out; 
> > +       if (!thread_group_leader(task)) 
> > +               goto out_drop_task; 
> >   
> >         inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO); 
> > 
> > means that threads other than the thread group leader don't appear in
> > the /proc top-level directory.  Programs that are informed via pid of
> > events can no longer find the appropriate process -- for example,
> > using gdb on a multi-threaded process, or profiling using perfmon.
> > 
> > The immediate symptom is GDB saying:
> >     Could not open /proc/757/status
> > when 757 is a TID not a PID.
> 
> What does `ls /proc/757' say?  Presumably no such file or directory?
> It's fairly bizare behaviour to be able to open files which don't exist
> according to readdir, which is why we made that change.
> 
> The node to tid 757 should appear under its thread group leader's
> directory: /proc/NNN/757.  That node should be visible to readdir, and that
> is the node which gdb and perfmon should be looking for.
> 
> Of course, we may have burnt our boats with the initial silliness.  It's a
> shame that gdb and perfmon went and used it.

GDB has used it since long before any of this happened.  LinuxThreads
didn't use thread groups, remember?

There is no way from GDB to figure out which thread is the thread group
leader, either, so I don't know how you propose it find the proc
directory now.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
