Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVC3WUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVC3WUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVC3WUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:20:35 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:26860 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262457AbVC3WUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:20:12 -0500
Date: Wed, 30 Mar 2005 17:20:08 -0500
To: linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Cc: rweight@us.ibm.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Set MS_ACTIVE in isofs_fill_super()
Message-ID: <20050330221947.GA3827@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"viro@parcelfarce.linux.theplanet.co.uk" <viro@parcelfarce.linux.theplanet.co.uk>,
	rweight@us.ibm.com, Andrew Morton <akpm@osdl.org>
References: <1112213392.25362.65.camel@russw.beaverton.ibm.com> <20050330123907.10740bc1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330123907.10740bc1.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 12:39:07PM -0800, Andrew Morton wrote:
> Russ Weight <rweight@us.ibm.com> wrote:
> > This patch sets the MS_ACTIVE bit in isofs_fill_super() prior to calling
> > iget() or iput(). This eliminates a race condition between mount
> > (for isofs) and kswapd that results in a system panic.
> 
> The patch is obviously safe enough, but seems a bit kludgy.

Ehh, I think every filesystem must have that bug, since fill_super AFAIK
is expected to initialize the root dentry (sb->s_root), or at least that
is what the function used to do before it became 'fill_super'.

When I saw this bugreport I immediately knew that Coda did the same
thing "wrong". Let's see,

    ext2/ext3, iget in fill_super
    reiserfs,  iget5_locked in fill_super
    ramfs,     new_inode in fill_super

There probably isn't a reason to keep looking further at this point...

I think logically if a filesystem needs to perform any setup before it
can handle VFS request that should probably be done in the registered
get_sb function before that function then calls back into the VFS to get
the actual superblock with get_sb_dev/nodev/single(..., fill_super).

Not sure how realistic this thought is, since we don't have an
initialized superblock at this time to hang things off of.

> I wonder if it would make more sense for all the ->fill_super callers to
> set MS_ACTIVE prior to calling ->fill_super(), and clear MS_ACTIVE if
> fill_super() failed?

This sounds like a better solution, although filesystems might have to
handle some operations earlier than they currently expect.

Jan

