Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVKOKla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVKOKla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 05:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVKOKla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 05:41:30 -0500
Received: from cantor2.suse.de ([195.135.220.15]:31374 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751420AbVKOKla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 05:41:30 -0500
From: Neil Brown <neilb@suse.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Nov 2005 21:41:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17273.47953.233462.316302@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH ] Fix some problems with truncate and mtime semantics.
In-Reply-To: message from Miklos Szeredi on Tuesday November 15
References: <20051115125657.9403.patches@notabene>
	<1051115020002.9459@suse.de>
	<E1Ebxp3-0003me-00@dorka.pomaz.szeredi.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 15, miklos@szeredi.hu wrote:
> > Finally, if vmtruncate succeeds, and ATTR_SIZE is the only change
> > requested, we now fall-through and mark_inode_dirty.  If a filesystem
> > did not have a ->truncate function, then vmtruncate will have changed
> > i_size, without marking the inode as 'dirty', and I think this is wrong.
> 
> And if filesystem does not have a ->truncate() function and it caller
> was [f]truncate(), ctime and mtime won't be set.
> 
> That's wrong too, isn't it?

I don't think that is a problem.  
The filesystem would have had a ->setattr function which would have
been told that the size had changed, and it would have had to change
the inode, and so would have updated the ctime and probably mtime.

Changing i_size without marking the inode dirty is an issue of
consistency of common data structures and inode_setattr should be
careful about that.

Changing ctime/mtime when the isize changes is an issue of filesystem
correctness, and the filesystem callbacks should handle that.

Changing mtime when isize DOESN'T change is an issue of obscure
POSIX/SUS semantics.  It was less clear where this should be handled.
I think the handle of this is now better.

NeilBrown
