Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTFKCOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTFKCOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:14:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25024 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263997AbTFKCOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:14:11 -0400
Date: Wed, 11 Jun 2003 03:27:54 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Frank Cusack <fcusack@fcusack.com>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030611022754.GC6754@parcelfarce.linux.theplanet.co.uk>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <16102.36078.894833.262461@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16102.36078.894833.262461@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 03:59:10AM +0200, Trond Myklebust wrote:
> AFAICS the problem is the following:
> 
>   - NFS sillyrenames dentry 1
>   - Upon return from nfs_unlink(), VFS unhashes dentry 1
> 
>   - Upon next lookup, VFS+NFS conspire to create aliased dentry 2 to
>     sillyrenamed file
>   - Upon last close of files associated with dentry 1, NFS completes
>     sillyrename. File is unlinked on server.
>   - Aliased dentry 2 is still around, but it is now pointing to stale
>     fh.
> 
> IOW we just want to prevent VFS from unhashing the dentry in the first
> place: dentry aliasing cannot work together with sillyrename.

Aliasing could be dealt with.  They would have the same inode, so it's
easy to detect.  The real problem is different: what happens if I take
silly-renamed file and rename it away?  You suddenly get ->dir and ->dentry
if your nfs_unlinkdata having nothing to do with each other.

_If_ we want to be able to work with silly-renamed dentry, we need much
more careful async unlink.  Your current code assumes that these dentries
won't go anywhere.   AFAICS, dcache will not get into inconsistent state,
but it will have very little to do with state of server...
