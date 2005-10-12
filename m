Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVJLNyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVJLNyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 09:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVJLNyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 09:54:05 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:41994 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964782AbVJLNyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 09:54:03 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1129123257.8561.27.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Wed, 12 Oct 2005 09:20:57 -0400)
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
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
	 <1128698035.8583.36.camel@lade.trondhjem.org>
	 <E1ENu8h-0005Kd-00@dorka.pomaz.szeredi.hu>
	 <1128702227.8583.69.camel@lade.trondhjem.org>
	 <E1ENvzx-0005VT-00@dorka.pomaz.szeredi.hu>
	 <1129061494.11164.38.camel@lade.trondhjem.org>
	 <E1EPeM4-0000Xz-00@dorka.pomaz.szeredi.hu> <1129123257.8561.27.camel@lade.trondhjem.org>
Message-Id: <E1EPh1j-0000jR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 12 Oct 2005 15:52:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > However I don't really like that the filesystem is reentered from
> > lookup_instantiate_filp() via __dentry_open() and ->open().  Is this
> > necessary?
> 
> If filesystems need to be able to change the value of f_mapping, then
> yes, however if none of the potential users of lookup_instantiate_filp()
> care about doing so, then we can get rid of it.

That would be nice.  Filesysteem could set intent.open.file->f_mapping
before call to lookup_instantiate_filp(), which would check it before
resetting to inode->i_mapping.

> I don't care either way since we will not be supporting non-intent based
> opens for NFSv4.

I need this for FUSE, since non-create opens and non-exclusive open of
positive dentry will be done through ->open().

There is an ugly workaround: filesystem sets
nd->intent.open.file->private_data to some non-NULL value before
calling lookup_instantiate_filp() and in ->open() skip open based on
value of file->private_data.

But I'd prefer if lookup_instantiate_filp() would simply not call
->open().

> > I see you've fixed the O_TRUNC problem.  The accmode==3 case is still
> > slightly broken, since now the file is being opened in read-write mode
> > instead of no-read-no-write mode.  This probably won't break anything
> > too badly though.
> 
> It is non-portable and it was never supported on NFSv4 anyway. If
> someone cares, they can fix it, but I don't see much need.

I suggest that nameidata_to_filp() to check this ((flags & O_ACCMODE)
== 3) if the file is already open and bail out with -EINVAL.

This would make sure, that things that relied on the old behavior at
least fail loudly instead of silently.

Miklos
