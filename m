Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUIAMBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUIAMBe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUIAL7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:59:04 -0400
Received: from cheddar.cendio.se ([193.12.253.77]:6896 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S266252AbUIAL52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:57:28 -0400
Date: Wed, 1 Sep 2004 13:57:23 +0200 (CEST)
From: Peter Astrand <peter@cendio.se>
X-X-Sender: peter@maggie.lkpg.cendio.se
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: ncpfs problems
In-Reply-To: <2505C593E0E@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0409011322580.29446-100000@maggie.lkpg.cendio.se>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your quick response. 

> > I'm having severe problems with ncpfs. What I'm trying to accomplish is to
> > run KDE with a NCP-mounted home directory. This actually worked with the 2.4
> > kernel, but the problem with "df"/"statfs" reporting zero bytes free
> > required patching of the startkde script. 
> 
> With 2.6.x you should get free space on a volume if you mount volume
> or subdirectory instead of all volumes from server (i.e. you used -V
> option to ncpmount).

Yes, this works. 


> > * When shutting down KDE, the file system startas reporting EIO 
> > (Input/output error). It's also very un-responsive; if one process runs
> > read() (returning EIO) in a tight loop, other processes hangs forever (well,
> > at least > 12 hours). 
> 
> Someone aborted process in the middle of ncpfs operation with SIGKIL.  
> As ncp request/responses are handled in context of calling
> process, if you SIGKILL process after it sent request but before it
> received response, connection is invalidated.  

This is _major_ drawback. The mount shouldn't stop working just because 
you killed a process. 


> But it should not hang other processes which have nothing to do with
> ncpfs.

Probably it doesn't; all hangs I've experienced has been with processes
using NCP mount.


> If you run in a loop process which does some (failing) ncpfs operation,
> other processes which want to use that mountpoint of course blocks:
> Linux semaphores are not fair.

So, the ncpfs client is sort of "single-threaded"? 


> If you do not want SIGKILL to abort connection, replace
> sigmask(SIGKILL) with sigmask(0) in fs/ncpfs/sock.c.  But then you may
> get unkillable process in the case TCP connected server dies, or if you'll
> set infinite timeout for UDP/IPX servers.

Not good. Are these two alternatives the only ones? Patching the kernel is 
not an option for us; our customers are only using unmodified kernels from 
their distribution or perhaps kernel.org. 

Having unkillable processes are frustrating, but it's probably better than
being able to kill the entire mount by a single SIGKILL. So, if these are
the only options, I guess the unkillable process solution should be
default.


> > * Some files are impossible to remove, for example the files in 
> > ~/.kde/socket-dhcp-253-234: An unlink returns EBUSY:
> > 
> > unlink("kdeinit_maggie_2")              = -1 EBUSY (Device or resource busy)
> > 
> > Do you have any ideas what can cause this? Do you consider ncpfs stable
> > enough to be used for the home directory? 
> 
> File is open... You cannot remove opened files from Netware filesystem.

In my opinion, ncpfs should try to emulate POSIX semantics as close as
possible. This means that "strong" should be default, and it should be
possible to remove open files. Even if the Netware server refuses this
operation, why cannot it be simulated by ncpfs? At least this should be
possible to implement by using "silly deletes", as NFS does, but since NCP
is stateful, too me it seems like this shouldn't be necessary.


> I cannot think about any other reason why you should get EBUSY.

The glibc 2.3.3 manpage for unlink actually says that EBUSY shouldn't
happen on Linux.


(Please CC me on this topic.)

Regards, Peter


