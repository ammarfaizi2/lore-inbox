Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUIIVFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUIIVFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUIIVEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:04:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:61655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266903AbUIIVEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:04:04 -0400
Date: Thu, 9 Sep 2004 14:03:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
Cc: "Serge E. Hallyn" <hallyn@CS.WM.EDU>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication of binaries
Message-ID: <20040909140349.C1924@build.pdx.osdl.net>
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net> <41409378.5060908@ericsson.com> <20040909105520.U1924@build.pdx.osdl.net> <20040909190511.GB28807@escher.cs.wm.edu> <4140BFCE.8010701@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4140BFCE.8010701@ericsson.com>; from Makan.Pourzandi@ericsson.com on Thu, Sep 09, 2004 at 04:40:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Makan Pourzandi (Makan.Pourzandi@ericsson.com) wrote:
> Serge E. Hallyn wrote:
> > Quoting Chris Wright (chrisw@osdl.org):
> >>AFAICT, this means anybody with read access to a file can block all
> >>writes.  This doesn't sound great.
> > 
> > True.
> 
> I want to narrow down the discussion, I believe that some people could 
> get confused with the mention of "file" here. AFAICT, the above problem 
> only concerns the shared libraries. Digsig applies only to binaries: in 
> digsig_file_mmap() implementing the file_mmap LSM hook, if the file is 
> not executable there is a return and no verification or any other 
> blocking is done.

No, it's the mmap PROT check that's the issue.

> For executables, there is no meaning to load them on read mode, you 
> should have execute permission. if you then load them for execution 
> IMHO, it makes sense to block the writing on that file.

Thing is, x86 makes no distinction btween r/x so, have you tried mmaping
with read, then executing (I haven't)?  If it works, then you may find
that there are dumb things out there that do that as well (which you
wouldn't be able to protect, and become one attack vector).  You can make
a file read-only (no exec bits), and still execute it with ld.so.  Same
as bash can interpret readonly shell script files.  Now, ld.so _will_
mmap PROT_EXEC, so it works for you.

> For shared libraries, you're right. the problem exists, the shared 
> libraries can be loaded being only readable (even though I remember 
> reading in exec.c:sys_uselib() kernel 2.6.8.1 that the shared libraries 
> must be both readable and executable due to "security reasons", but I'm 
> not an expert and definitely readable is enough to load the shared 
> library but I'll be happy to learn more about this.)
> 
> > This could be fixed by adding a check at the top of dsi_file_mmap for
> > file->f_dentry->d_inode->i_mode & MAY_EXEC.  Of course then shared
> > libraries which are installed without execute permissions will cause
> > apps to break.  On my quick test, I couldn't run xterm or vi  :)
> > 
> > Note that blocking writes requires that the file be a valid ELF file,
> > as this is all that digsig mediates.  So I'm not sure which we worry
> > about more - the fact that all shared libraries have to be installed
> > with execute permissions (under the proposed solution), or that write
> 
> 
> My 2 cents, a quick browsing on my machine (fedora core 1) shows that 
> almost all my shared libraries are installed with both execution and 
> read permissions.  IMHO, I don't believe then that this should be 
> considered as a major issue.

This has nothing to do with file permissions aside of read.  All you need
is read permission, then you can mmap(PROT_EXEC) which will kick off the
check, and do deny_write_access.  It's a freeform way to lock writers
out of any readable file in the system.  This is why MAP_EXECUTABLE and
MAP_DENYWRITE are masked off at syscall entry.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
