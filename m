Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVJGOsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVJGOsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVJGOsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:48:12 -0400
Received: from pat.uio.no ([129.240.130.16]:55281 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030261AbVJGOsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:48:10 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
	 <1128633138.31797.52.camel@lade.trondhjem.org>
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
	 <1128692289.8519.75.camel@lade.trondhjem.org>
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 10:47:57 -0400
Message-Id: <1128696477.8583.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.905, required 12,
	autolearn=disabled, AWL 1.09, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 07.10.2005 Klokka 15:59 (+0200) skreiv Miklos Szeredi:
> So, you are saying OPEN has to do the lookup too.  That's OK, but that
> _does not_ mean that you have to do the OPEN operation from the
> ->lookup() or ->d_revalidate() methods.  In fact you cannot do the
> later without getting into trouble over mounts.

You cannot do anything else without getting into trouble over dentry
races. Given that choice, I prefer to take my chances with the mounts as
those are rare.

We can add locking in order to exclude the mount races, or we can just
ignore them. AFAICS there are 2 cases:

  1) umount races
	refcounting of any in-use dentry is supposed to prevent trouble here.

  2) mount races. Either
	Just ignore if the filesystem has already opened the file.
     or
	Add locking to prevent races.

> > If you end up opening a different file to the one you looked up, things
> > can get very interesting.
> 
> You can replace the inode in ->create_open() if you want to.  Or let
> the VFS redo the lookup (as if d_revalidate() returned 0).

...but I cannot do that once I get to dentry_open(). You are ignoring
the case of generic file open without creation.

> > > I know you are thinking of the non-exclusive create case when between
> > > the lookup and the open the file is removed or transmuted on the
> > > server..
> > 
> > > Yes, it's tricky to sovle, but by no means impossible without atomic
> > > lookup+open.  E.g. consider this pseudo-code (only the atomic
> > > open+create case) in open_namei():
> > 
> > Firstly, that pseudo-code doesn't deal at all with the race you describe
> > above. It only deals with lookup + file creation.
> 
> It does deal with the race:
> 
> __lookup_hash() returns a positive dentry
> 
> file is removed on server
> 
> "else if (!(flag & O_EXCL) && may_create(dir))" condition is met
> 
> __follow_mount() return false
> 
> vfs_create_open() calls ->create_open()
> 
> NFS does OPEN (O_CREAT), file is opened, dentry replaced (this is not
> ellaborated in the pseudocode).

Which again only deals with the case of open(O_CREAT). My point is that
the race exists for the case of generic open().

If you first lookup the dentry in open_namei(), then end up opening a
completely different file in dentry_open(), then you are fscked.

Cheers,
  Trond

