Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVGGRXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVGGRXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVGGRUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:20:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261466AbVGGRTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:19:01 -0400
Date: Thu, 7 Jul 2005 10:21:45 -0700
From: Nick Wilson <njw@osdl.org>
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: trond.myklebust@fys.uio.no, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] NFS: fix client hang due to race condition
Message-ID: <20050707172145.GA5888@njw.pdx.osdl.net>
References: <482A3FA0050D21419C269D13989C611308539D6E@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482A3FA0050D21419C269D13989C611308539D6E@lavender-fe.eng.netapp.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 07:11:25PM -0700, Lever, Charles wrote:
> > The flags field in struct nfs_inode is protected by the BKL.  The
> > following two code paths (there may be more, but my test program only
> > hits these two) modify the flags without obtaining the lock:
> > 
> >     nfs_end_data_update
> >     nfs_release
> >     nfs_file_release
> >     __fput
> >     fput
> >     filp_close
> >     sys_close
> >     syscall_call
> > 
> >     nfs_revalidate_mapping
> >     nfs_file_write
> >     do_sync_write
> >     vfs_write
> >     sys_write
> >     syscall_call
> > 
> > Running multiple instances of a simple program [1] that opens, writes
> > to, and closes NFS mounted files eventually results in the programs
> > hanging on an SMP system (see kernel .config [3]).
> > 
> > I've been testing this with 100 instances of the program:
> >     $ ./breaknfs 100 &
> > 
> > Usually within 10 minutes, all instances of breaknfs will hang.  They
> > disappear from the output of 'top' and there is no NFS 
> > activity between
> > the client and server.
> 
> [ sysrq output snipped... ]
> 
> > I've reproduced this bug on 2.6.11.10, 2.6.12-mm2, and 2.6.13-rc2.
> > 
> > With my patch against 2.6.13-rc2 below, I ran 100 instances 
> > of breaknfs
> > with this patch for 14 hours and I was unable to get the 
> > client to hang.
> 
> i agree this is a problem.
> 
> but instead of using heavyweight synchronization, why not convert the
> NFS_INO flags into atomic bitops?  i have a patch that does that; would
> need to be ported to the latest kernels and tested to see if it
> addresses the problem.
> 
> nick, are you interested in trying it out?

Sure.  Send it my way and I'll see if I can get it updated to the latest
kernels and test it out.

Nick
