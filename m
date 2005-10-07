Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbVJGOBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbVJGOBc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVJGOBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:01:32 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:23568 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932617AbVJGOBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:01:31 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128692289.8519.75.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 07 Oct 2005 09:38:09 -0400)
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
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu> <1128692289.8519.75.camel@lade.trondhjem.org>
Message-Id: <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 07 Oct 2005 15:59:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I just think that filesystem code should _never_ need to care about
> > > > mounts.  If you want to do the lookup+open, you somehow will have to
> > > > deal with mounts, which is ugly.
> > > 
> > > You appear to think that atomic lookup+open is a question of choice. It
> > > is not.
> > 
> > Atomic lookup+open is an optimization, and as such a question of
> > choice.  Atomic create+open is not.
> 
> Really? Under NFSv4, the one and only OPEN command does an atomic lookup
> +open, It _has to_ in order to deal with all the races.
> 
> Once that is the case, then separating lookup and open into two
> operations means that you need to worry about namespace changes on the
> server too (since OPEN takes a name argument rather than a filehandle).

So, you are saying OPEN has to do the lookup too.  That's OK, but that
_does not_ mean that you have to do the OPEN operation from the
->lookup() or ->d_revalidate() methods.  In fact you cannot do the
later without getting into trouble over mounts.

> If you end up opening a different file to the one you looked up, things
> can get very interesting.

You can replace the inode in ->create_open() if you want to.  Or let
the VFS redo the lookup (as if d_revalidate() returned 0).

> > I know you are thinking of the non-exclusive create case when between
> > the lookup and the open the file is removed or transmuted on the
> > server..
> 
> > Yes, it's tricky to sovle, but by no means impossible without atomic
> > lookup+open.  E.g. consider this pseudo-code (only the atomic
> > open+create case) in open_namei():
> 
> Firstly, that pseudo-code doesn't deal at all with the race you describe
> above. It only deals with lookup + file creation.

It does deal with the race:

__lookup_hash() returns a positive dentry

file is removed on server

"else if (!(flag & O_EXCL) && may_create(dir))" condition is met

__follow_mount() return false

vfs_create_open() calls ->create_open()

NFS does OPEN (O_CREAT), file is opened, dentry replaced (this is not
ellaborated in the pseudocode).


> Secondly, it also fails to deal with the issue of propagation of open
> context.
> If you open a file, then that creates open context/state on the server.
> Most protocols will then have some way of tracking that state using an
> identifier (the equivalent of the POSIX open file descriptor). I see
> absolutely nothing in your proposal that will allow me to save the state
> identifier that results from atomic open+create and then propagate it to
> the struct file.

If you read the original patch, ->open_create() has a 'struct file *'
parameter, just like ->open().

Miklos
