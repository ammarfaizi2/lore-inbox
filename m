Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVCNAuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVCNAuf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVCNAue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:50:34 -0500
Received: from pat.uio.no ([129.240.130.16]:64745 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261612AbVCNAu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:50:26 -0500
Subject: Re: [CHECKER] inconsistent NFS stat cache (NFS on ext3, 2.6.11)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050314003512.GA16875@nevyn.them.org>
References: <Pine.GSO.4.44.0503120335160.12085-100000@elaine24.Stanford.EDU>
	 <1110690267.24123.7.camel@lade.trondhjem.org>
	 <20050313200412.GA21521@nevyn.them.org>
	 <1110746550.23876.8.camel@lade.trondhjem.org>
	 <20050314003512.GA16875@nevyn.them.org>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 19:50:09 -0500
Message-Id: <1110761410.30085.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 13.03.2005 Klokka 19:35 (-0500) skreiv Daniel Jacobowitz:
> On Sun, Mar 13, 2005 at 03:42:29PM -0500, Trond Myklebust wrote:
> > su den 13.03.2005 Klokka 15:04 (-0500) skreiv Daniel Jacobowitz:
> > 
> > > I can't find any documentation about this, but it seems like the same
> > > problem that has been causing me headaches lately; when I replace glibc
> > > from the server side of an nfsroot, the client has a couple of
> > > variously wrong reads before it sees the new files.  If it breaks NFS
> > > so badly, why is it the default for the Linux NFS server?
> > 
> > No, that's a very different issue: you are violating the NFS cache
> > consistency rules if you are changing a file that is being held open by
> > other machines.
> > The correct way to do the above is to use GNU install with the '-b'
> > option: that will rename the version of glibc that is in use, and then
> > install the new glibc in a different inode.
> 
> [closed and/or irrelevant lists removed from CC:]
> 
> No, the copy of glibc in question is not in use at the time.  The next
> attempt to open it on the client will sometimes generate a "stale NFS
> handle" message, or if the open succeeds a read will sometimes return
> EIO.  But it sounds like this is a different problem than the original
> poster was testing for.

Sorry, but you should _never_ have gotten an ESTALE error if the file
was not in use when you deleted the old copy of glibc. A fresh call to
open() will always result in a new lookup of the filehandle.
What may have happened in the case of the EIO error is that you may have
raced: i.e. a client starts reading the file while it is being copied
to.

You'll rather want to ask Neil Brown about why subtree_check is still
the default for knfsd. He is the NFS server maintainer.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

