Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUGZXCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUGZXCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbUGZXCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:02:13 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:16583 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S266170AbUGZXBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:01:14 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jul 2004 09:00:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16645.36138.385234.785650@cse.unsw.edu.au>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 and SPEC SFS Run rules.
In-Reply-To: message from Andrew Morton on Monday July 26
References: <20040726000313.3fbf8403.akpm@osdl.org>
	<Pine.LNX.4.44.0407261010400.32233-100000@localhost.localdomain>
	<20040726130128.668c0722.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday July 26, akpm@osdl.org wrote:
> >    2. For NFS Version 3, the server adheres to the protocol specification. 
> > In particular the requirement that for STABLE write requests and COMMIT 
> > operations the NFS server must not reply to the NFS client before any 
> > modified file system data or metadata, with the exception of access times, 
> > are written to stable storage for that specific or related operation. See 
> > RFC 1813, NFSv3 protocol specification for a definition of STABLE and 
> > COMMIT for NFS write requests.

Providing you use the "sync" export option, the Linux kNFSd should
meet this requirement.

> >    3. For NFS Version 3, operations which are specified to return wcc data 
> > must, in all cases, return TRUE and the correct attribute data. Those 
> > operations are:
> > 
> >       NFS Version 3
> >       SETATTR
> >       READLINK
> >       CREATE
> >       MKDIR
> >       SYMLINK
> >       MKNOD
> >       REMOVE
> >       RMDIR
> >       RENAME
> >       LINK
> 
> To confirm this we'd need to undertake an audit of the server
> implementation, and we'll need to ask Neil about it.

To help with the audit: the wcc data is set by "fh_unlock".  i.e. when
a filehandle is unlocked (up(i_sem)) a copy of the state information
is taken and included where appropriate in the reply.

The only place that I am aware of where we *do*not* return wcc data is
for the WRITE request (which you have not listed).  As the underlying
filesystem is left to do whatever locking it thinks is appropriate,
and vfs_write does none, nfsd is not in a position to lock it itself
against sys_write and so cannot record before and after stat
information that is atomic w.r.t the update.

NeilBrown
