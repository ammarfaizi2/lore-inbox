Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274557AbRITQG6>; Thu, 20 Sep 2001 12:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274555AbRITQGl>; Thu, 20 Sep 2001 12:06:41 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:56720 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S274553AbRITQG2>; Thu, 20 Sep 2001 12:06:28 -0400
Date: Thu, 20 Sep 2001 12:06:49 -0400
To: Florian Schaefer <listbox@netego.de>
Cc: codalist@TELEMANN.coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: [PATCH] Re: Coda and Ext3
Message-ID: <20010920120648.A11130@cs.cmu.edu>
Mail-Followup-To: Florian Schaefer <listbox@netego.de>,
	codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
	ext3-users@redhat.com
In-Reply-To: <3B9792FB.7020708@progress.com> <20010906115302.B826@cs.cmu.edu> <1000909441.2017.20.camel@pcsshah> <20010919213713.D8947@cs.cmu.edu> <200109201238.f8KCcSo00731@dexter.netego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109201238.f8KCcSo00731@dexter.netego.de>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 01:38:26PM +0100, Florian Schaefer wrote:
> On Wed, 19 Sep 2001 21:37:14 -0400, Jan Harkes said:
> >On Wed, Sep 19, 2001 at 10:23:36AM -0400, Sujal Shah wrote:
> > >      The Linux Coda drivers and the ext3 patches don't seem to get along
> > > very well, at least in Linux 2.4.7.  I've got a stock 2.4.7 kernel with
> > 
> > The attached patch should fix it. I haven't tested it against ext3, but
> > with tmpfs which used to have the same problem, i.e. not using
> > generic_file_ functions to access the container files. I'll pass it on
> > to Linus and Alan once I get some feedback on whether this solves all
> > problems. I believe this will fix the whole batch of problems that are
> > have been reported with ext3fs, XFS, and tmpfs.
> 
> I just tried your patch together with coda-debug-client-5.3.15-1,
> kernel-2.4.9 and ext3-2.4-0.9.6-249 and still get the BUG message. The
> ksymoops output is attached.

No, different bug,

Fixed problem is basically what everyone is seeing when they are using
Coda on top of a filesystem that doesn't use generic_file_write. It was
simply there to avoid corrupting the underlying fs.

Your bug is unusual, because it happens during the mount, everybody
else successfully mounted Coda and could read files, it would just die
when trying to write anything.

The bug is triggered because the inode we just got passed from the VFS
has a superblock that has no pointer to the Coda specific info.

If you look at the trace, parts of it look right, but most of it doesn't
make sense, printk never calls back into FS specific code, coda_iget
does not call coda_cnode make, coda_inocmp isn't calling iget4, etc.

If you look at the logic of the mount operation,

coda_read_super

    Here we allocate the Coda info and link it to the superblock. If the
    allocation fails we return early. An upcall is made to venus to get
    the rootfid. Then we call coda_cnode_make, passing it the rootfid
    and the initialized superblock.

coda_cnode_make

    Makes a second upcall, getting the attributes of the root inode, if
    it fails we return. Else it calls coda_iget, passing the superblock,
    the rootfid and the attributes.

coda_iget
    Calls iget4 passing it the initialized superblock, a hash of the
    fid, and a callback function + rootfid to find the real inode.

iget4
    Should fail to find the inode, and calls get_new_inode again passing
    it the initialized superblock.

get_new_inode
    Allocates an inode, initializes inode->i_sb with the passed in
    superblock and calls the fs-specific read_inode.

coda_read_inode
    Craps out because the inode->i_sb.u.generic_sbp is NULL, wtf?

The only way I can see this happening is if the sb.u.generic_sbp field
is cleared, but it looks like even coda_put_super isn't doing that.

Summary, I'm clueless how this could have happened, and I can't see how it
could happen. Perhaps a patch got botched, or your kernel is mixing up
objects from before the patch with later ones. All those ksyms errors
and the illogical jumps in the trace don't make it look to healthy either.

Try to start from a fresh 2.4.9 tree, apply the ext3 patch and my Coda
patch, add -fs1 to EXTRAVERSION just to force this tree to install it's
modules in a separate directory. Copy the config of your existing tree,
make oldconfig ; make dep ; etc...

Jan

