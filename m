Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWGGXYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWGGXYf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWGGXYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:24:35 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:55455 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932385AbWGGXYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:24:33 -0400
Date: Fri, 7 Jul 2006 18:24:32 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steven M. French" <sfrench@us.ibm.com>,
       "David J. Kleikamp" <shaggy@us.ibm.com>, ezk@cs.sunysb.edu,
       fistgen@fsl.cs.sunysb.edu, jsipek@fsl.cs.sunysb.edu,
       unionfs@filesystems.org
Subject: Re: + ecryptfs-dont-muck-with-the-existing-nameidata-structures.patch added to -mm tree
Message-ID: <20060707232432.GA23350@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <200606192335.k5JNZWo6017881@shell0.pdx.osdl.net> <20060707120004.GA6101@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707120004.GA6101@lst.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 02:00:04PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 19, 2006 at 04:38:55PM -0700, akpm@osdl.org wrote:
> > The patch titled
> > 
> >      ecryptfs: don't muck with the existing nameidata structures
> > 
> > has been added to the -mm tree.  Its filename is
> > 
> >      ecryptfs-dont-muck-with-the-existing-nameidata-structures.patch
> > 
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> > out what to do about this
> 
> I think the only way to fix this is to stop passing down the whole
> nameidata.  Pass the intent only and do something smart with it in
> the interposing filesystem.  Not sure what though as the important
> part isn't just doing something smart with what we get, but rather
> the more important part is to do pass down the right thing to the
> underlying filesystem.
> 
> Have you tested ecryptfs with nfsv4?

I've tested with the older nfs, but not v4 yet. I don't think it will
work, for this reason.

do_filp_open()
 open_namei()
  path_lookup_open()
   __path_lookup_intent_open()
    do_path_lookup()
     link_path_walk()
      __link_path_walk()
       do_lookup()
        do_revalidate()
         d_revalidate()

d_revalidate is a pointer to ecryptfs_d_revalidate(), which passes its
own temporary nameidata to nfs_open_revalidate().

nfs_open_revalidate()
 nfs4_open_revalidate()
  nfs4_intent_set_file()
   lookup_instantiate_filp()

In lookup_instantiate_filp(), nd->intent.open.file = __dentry_open(...)

This is where it gets tricky. In my humble understanding of VFS
internals, my first inclination is to say that perhaps
ecryptfs_d_revalidate() could detect that intent.open.file was set,
then generate a corresponding lookup intent dentry and interpose the
two; it's not obvious to me why the bookkeeping has to be terribly
complicated. I do fear that some nameidata stacking infrastructure may
need to be introduced into nameidata structure itself
(nameidata.private pointer?) for this approach to work, but I will
have to poke around and think about it a bit more.

In any case, right now, ecryptfs_d_revalidate() drops the temporary
nameidata on the floor, leaving nd->intent.opt.file dangling. Then we
find our way back to do_filp_open(), which returns
nameidata_to_filp(), which returns an uninitialized
nd->intent.opt.file. If my observations are coherent, then this will
certainly need to be fixed for nfsv4.

The original form of ecryptfs_d_revalidate(), which just replaced the
dentry and vfsmount in the nd, has the obvious inconsistency problem
with the dcache.

I'll bring this up with the FiST folks to get their view on the issue.

Thanks,
Mike
