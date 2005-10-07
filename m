Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVJGPUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVJGPUi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVJGPUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:20:38 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:785 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1030277AbVJGPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:20:37 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128696477.8583.17.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 07 Oct 2005 10:47:57 -0400)
Subject: Re: [RFC] atomic create+open
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
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu> <1128696477.8583.17.camel@lade.trondhjem.org>
Message-Id: <E1ENtzt-0005Jb-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 07 Oct 2005 17:18:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fr den 07.10.2005 Klokka 15:59 (+0200) skreiv Miklos Szeredi:
> > So, you are saying OPEN has to do the lookup too.  That's OK, but that
> > _does not_ mean that you have to do the OPEN operation from the
> > ->lookup() or ->d_revalidate() methods.  In fact you cannot do the
> > later without getting into trouble over mounts.
> 
> You cannot do anything else without getting into trouble over dentry
> races. Given that choice, I prefer to take my chances with the mounts as
> those are rare.
> 
> We can add locking in order to exclude the mount races, or we can just
> ignore them. AFAICS there are 2 cases:
> 
>   1) umount races
> 	refcounting of any in-use dentry is supposed to prevent trouble here.

Refcounting solves nothing.  The problem is that you try to do the
mount handling partly in the filesystem, and partly outside of it.

I hate the idea of this, but if there's no alternative...

>   2) mount races. Either
> 	Just ignore if the filesystem has already opened the file.

Yes, ignoring is perfectly fine.  Unlike the umount case, mounting
cannot cause problems.

> > You can replace the inode in ->create_open() if you want to.  Or let
> > the VFS redo the lookup (as if d_revalidate() returned 0).
> 
> ...but I cannot do that once I get to dentry_open(). You are ignoring
> the case of generic file open without creation.

You can't do open by inode number (or file handle, whatever)?  Only by
name?  In that case yes, I see your problem.

> > NFS does OPEN (O_CREAT), file is opened, dentry replaced (this is not
> > ellaborated in the pseudocode).
> 
> Which again only deals with the case of open(O_CREAT). My point is that
> the race exists for the case of generic open().

And so does for setattr() etc.  You can safely return -ENOENT in these
cases.  O_CREAT is problematic only because it cannot return -ENOENT
if the file was removed between ->lookup and ->open.

Miklos
