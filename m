Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbTFKCrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTFKCrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:47:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51648 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264042AbTFKCrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:47:01 -0400
Date: Wed, 11 Jun 2003 04:00:41 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Frank Cusack <fcusack@fcusack.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030611030041.GE6754@parcelfarce.linux.theplanet.co.uk>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <16102.36078.894833.262461@charged.uio.no> <20030611022754.GC6754@parcelfarce.linux.theplanet.co.uk> <20030610194333.B18623@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610194333.B18623@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 07:43:33PM -0700, Frank Cusack wrote:
> On Wed, Jun 11, 2003 at 03:27:54AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Wed, Jun 11, 2003 at 03:59:10AM +0200, Trond Myklebust wrote:
> > > IOW we just want to prevent VFS from unhashing the dentry in the first
> > > place: dentry aliasing cannot work together with sillyrename.
> > 
> > Aliasing could be dealt with.  They would have the same inode, so it's
> > easy to detect.
> 
> dentry only contains the inode, not the fh.  On the server, the inode
> can go away and come back as a new fh, but with the same inode.  Is
> that detectable (would comparison hooks have to be added?)?  Although,
> I guess the inode is enough; you can do an NFS_I(inode)->fh to get
> the fh, but I wouldn't guess you'd want that in the VFS.  Bah, here
> I go again ... forgive me if that's nonsense.

You wouldn't need to do that anywhere near VFS - all relevant code is
inside NFS and yes, there we _are_ allowed to look at ->fh ;-)

FWIW, we could probably simply do the following: have nfs_lookup()
return ERR_PTR(-EINVAL) if it notices that it's about to give us
such alias.  IOW, no access to such guys at all - if it's going
to die, we refuse to do anything with it.  I'll try to do that
variant when I get some sleep - I'd rather not mess with anything
in that area until I'm completely awake...
