Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161452AbWI2GtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161452AbWI2GtH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWI2GtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:49:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56014 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030329AbWI2GtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:49:05 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 16:48:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17692.49605.248998.607609@cse.unsw.edu.au>
Cc: "David M. Grimes" <dgrimes@navisite.com>,
       Atal Shargorodsky <atal@codefidence.com>,
       Gilad Ben-Yossef <gilad@codefidence.com>,
       Hugh Dickins <hugh@veritas.com>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 001 of 8] knfsd: Add nfs-export support to tmpfs
In-Reply-To: message from Andrew Morton on Thursday September 28
References: <20060929130518.23919.patches@notabene>
	<1060929030839.24024@suse.de>
	<20060928232953.6da08f19.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday September 28, akpm@osdl.org wrote:
> On Fri, 29 Sep 2006 13:08:39 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> > +static int shmem_encode_fh(struct dentry *dentry, __u32 *fh, int *len, int connectable)
> > +{
> > +	struct inode *inode = dentry->d_inode;
> > +
> > +	if (*len < 2)
> > +		return 255;
> > +
> > +	if (hlist_unhashed(&inode->i_hash)) {
> > +		/* Unfortunately insert_inode_hash is not idempotent,
> > +		 * so as we hash inodes here rather than at creation
> > +		 * time, we need a lock to ensure we only try
> > +		 * to do it once
> > +		 */
> > +		static DEFINE_SPINLOCK(lock);
> > +		spin_lock(&lock);
> > +		if (hlist_unhashed(&inode->i_hash))
> > +			insert_inode_hash(inode);
> > +		spin_unlock(&lock);
> > +	}
> 
> This looks fishy.
> 
> How do we get two callers in here at the same time for the same inode?

Probably not very easily.
But imagine a file has two hard links in different directories.
And two clients issue LOOKUP requests, one for each link.
They could conceivably be processed at exactly the same time and so
shmem_encode_fh could be running on two different CPU's at the same
time for the same inode.

> 
> Why don't other filesystems have the same problem?
> 

Because most filesystems that hash their inodes do so at the point
where the 'struct inode' is initialised, and that has suitable locking
(I_NEW).  Here in shmem, we are hashing the inode later, the first
time we need an NFS file handle for it.  We no longer have I_NEW to
ensure only one thread tries to add it to the hash table.

The comment tries to explain this, but obviously isn't completely
successful.

NeilBrown
