Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUIAM1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUIAM1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUIAM1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:27:47 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:14787 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S266252AbUIAM0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:26:42 -0400
Subject: Re: ncpfs problems
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Peter Astrand <peter@cendio.se>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409011322580.29446-100000@maggie.lkpg.cendio.se>
References: <Pine.LNX.4.44.0409011322580.29446-100000@maggie.lkpg.cendio.se>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Message-Id: <1094041592.20655.110.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 13:26:33 +0100
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 12:57, Peter Astrand wrote:
> Thanks for your quick response. 
> 
> > > I'm having severe problems with ncpfs. What I'm trying to accomplish is to
> > > run KDE with a NCP-mounted home directory. This actually worked with the 2.4
> > > kernel, 

Interesting.  On our suse 9.0 based system we have problems with KDE
shutting down.  The DCOP server in particular fails to shutdown.  We
tracked this to be the problem that the DCOP server opens a file,
deletes it immediately and then still uses it.  But ncpfs doesn't have
posix semantics and the file is gone for good as soon as it is deleted
hence the dcop server cannot access it and it hangs.

Note this same problem breaks openoffice and other applications, too,
because the wrapper script suse installs uses perl -i and other apps use
that too or sed -i, too.  I had to modify everything to use -i.orig to
make things work.  (Aside: -i means open file, delete it, create it,
parse opened,deleted file and write modified version to the newly
created file, close deleted file, close new file and since on ncpfs
"delete it" destroys the file completely, "parse opened,deleted file"
returns nothing at all and so the total effect of doing perl -i or sed
-i is to truncate the file you are modifying to zero size!)

> but the problem with "df"/"statfs" reporting zero bytes free
> > > required patching of the startkde script. 

I patched ncpfs to always report 2GiB free space on all mount points. 
That works for us as quota is done on a per directory level so there is
no meaningful concept of free space for "df"/"statfs" and many
applications require "df" to return free space or they fail to run...

And the other problem we have is that ncpfs kernel driver doesn't
implement hardlinks but this one I solved by writing a Vurtial HardLink
implementation for ncpfs which basically implements hardlinks but only
on the local machine and only until you "umount" after which they
disappear.  That makes most applications work as they all only use
hardlinks for locking or instead of rename and hence no hard links are
left after the program has finished running and hence at umount time
nothing bad happens (my modifications would give a warning message the
user if any hardlinks are left at umount time).

> > With 2.6.x you should get free space on a volume if you mount volume
> > or subdirectory instead of all volumes from server (i.e. you used -V
> > option to ncpmount).
> 
> Yes, this works. 
> 
> > > * When shutting down KDE, the file system startas reporting EIO 
> > > (Input/output error). It's also very un-responsive; if one process runs
> > > read() (returning EIO) in a tight loop, other processes hangs forever (well,
> > > at least > 12 hours). 
> > 
> > Someone aborted process in the middle of ncpfs operation with SIGKIL.  
> > As ncp request/responses are handled in context of calling
> > process, if you SIGKILL process after it sent request but before it
> > received response, connection is invalidated.  
> 
> This is _major_ drawback. The mount shouldn't stop working just because 
> you killed a process. 

I quite agree.  This sounds like it might be the explanation for our
ncpfs problems where the ncp sequence numbers become out of sync and we
cannot talk to the server any more.  The machine then needs to be
rebooted before the user can log back in again.  However we seem to be
getting these quite randomly and I don't think it only happens when
killing applications.

> > But it should not hang other processes which have nothing to do with
> > ncpfs.
> 
> Probably it doesn't; all hangs I've experienced has been with processes
> using NCP mount.
> 
> > If you run in a loop process which does some (failing) ncpfs operation,
> > other processes which want to use that mountpoint of course blocks:
> > Linux semaphores are not fair.
> 
> So, the ncpfs client is sort of "single-threaded"? 
> 
> > If you do not want SIGKILL to abort connection, replace
> > sigmask(SIGKILL) with sigmask(0) in fs/ncpfs/sock.c.  But then you may
> > get unkillable process in the case TCP connected server dies, or if you'll
> > set infinite timeout for UDP/IPX servers.
> 
> Not good. Are these two alternatives the only ones? Patching the kernel is 
> not an option for us; our customers are only using unmodified kernels from 
> their distribution or perhaps kernel.org. 
> 
> Having unkillable processes are frustrating, but it's probably better than
> being able to kill the entire mount by a single SIGKILL. So, if these are
> the only options, I guess the unkillable process solution should be
> default.
> 
> > > * Some files are impossible to remove, for example the files in 
> > > ~/.kde/socket-dhcp-253-234: An unlink returns EBUSY:
> > > 
> > > unlink("kdeinit_maggie_2")              = -1 EBUSY (Device or resource busy)
> > > 
> > > Do you have any ideas what can cause this? Do you consider ncpfs stable
> > > enough to be used for the home directory? 
> > 
> > File is open... You cannot remove opened files from Netware filesystem.
> 
> In my opinion, ncpfs should try to emulate POSIX semantics as close as
> possible. This means that "strong" should be default, and it should be
> possible to remove open files. Even if the Netware server refuses this
> operation, why cannot it be simulated by ncpfs? At least this should be
> possible to implement by using "silly deletes", as NFS does, but since NCP
> is stateful, too me it seems like this shouldn't be necessary.

Amen.  I am probably going to be implementing posix semantics on unlink
for our 2.4 kernel based ncpfs module to fix our dcop server shutdown
problems soon.  Let me know if you want a copy of the patch...  Note you
might have to rework it quite a bit for 2.6 and even for a kernel.org
2.4 since we have a _lot_ of ncpfs patches locally to make it work for
us.

> > I cannot think about any other reason why you should get EBUSY.
> 
> The glibc 2.3.3 manpage for unlink actually says that EBUSY shouldn't
> happen on Linux.
> 
> 
> (Please CC me on this topic.)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

