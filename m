Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWFSSz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWFSSz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWFSSz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:55:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34276 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964852AbWFSSz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:55:57 -0400
Date: Mon, 19 Jun 2006 19:55:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619185555.GA15389@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org> <20060619155821.GA27867@infradead.org> <20060619161651.GS29684@ca-server1.us.oracle.com> <20060619172014.GD15216@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619172014.GD15216@thunk.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 01:20:14PM -0400, Theodore Tso wrote:
> On Mon, Jun 19, 2006 at 09:16:51AM -0700, Joel Becker wrote:
> > On Mon, Jun 19, 2006 at 04:58:21PM +0100, Christoph Hellwig wrote:
> > > Blease don't add a field to the superblock for the optimal I/O size.
> > > Any filesystem that wants to override it can do so directly in ->getattr.
> > 
> > 	I don't disagree with you, but the idea of everyone implementing
> > ->getattr where they just let it work before scares me.  It's a ton of
> > cut-n-paste error waiting to happen.  Especially if we make something
> > stale.
> > 	Perhaps add generic_fillattr_blksize()?
> 
> Well, as far as I know the only filesystems today that would need to
> do something different are xfs, ocfs2, and reiserfs,

And to answer Joel's statment of these three two already implement their
own ->getattr.  Also it doesn't mean a filesystem has to completely
reimplement it, they just have to override it by reusing generic_fillattr,
e.g.

static int my_getattr(struct vfsmount *mnt, struct dentry *dentry,
		struct kstat *stat)
{
	int error = generic_fillattr(dentry->d_inode, stat);
	if (!error)
		stat->blksize = something_useful;
	return error;
}		
