Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVJFSum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVJFSum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVJFSum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:50:42 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:10001 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751297AbVJFSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:50:41 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128623899.31797.14.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Thu, 06 Oct 2005 14:38:19 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu> <1128623899.31797.14.camel@lade.trondhjem.org>
Message-Id: <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 20:49:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And if the bind is umounted after NFS determined not to open the file,
> > and at the same time it changes to a symlink on the server (not very
> > likely I agree, but possible nonetheless), then shit happens.
> 
> Please elaborate. What would you expect to see happen in this situation?

For simplicity case let's omit the creation of simlink, just say, the
file is removed.

So NFS calls have_submounts(), which returns true.

Then the bind is umounted.  Nothing prevents this happening
concurrently with the lookup.

Then the file is removed on the server.

When open_namei() gets around to following the mounts, it is not there
any more, so the dentry for /mnt/foo (the NFS one is returned) and
NFS's ->open is called on the file, which returns -ENOENT.  But
open(..., O_CREAT, ...) should never return -ENOENT.

The symlink case is similar, just even more unlikely.

Miklos

