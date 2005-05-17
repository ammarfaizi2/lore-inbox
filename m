Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVEQFfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVEQFfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 01:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVEQFfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 01:35:38 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:21514 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261151AbVEQFf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 01:35:27 -0400
To: jamie@shareable.org
CC: linuxram@us.ibm.com, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20050517012854.GC32226@mail.shareable.org> (message from Jamie
	Lokier on Tue, 17 May 2005 02:28:54 +0100)
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
References: <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <20050516111408.GA21145@mail.shareable.org> <1116301843.4154.88.camel@localhost> <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu> <20050517012854.GC32226@mail.shareable.org>
Message-Id: <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 May 2005 07:34:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's a bit smaller (source and compiled) as:
> 
> 	if (ns2 < ns1)
> 		down_write(&ns2->sem);
> 	down_write(&ns1->sem);
> 	if (ns2 > ns1)
> 		down_write(&ns2->sem);
> 
> (And you'll notice that does the right thing if ns2==ns1 too, in case
> that gives you any ideas.)

Nice.

> Otherwise, the patch looks convincing to me.

There's another problem with it: we don't hold a reference to
old_nd.mnt->mnt_namespace, and the namespace going away could race
with this function.

So first obtain the necessary reference:

	spin_lock(&vfsmount_lock);
	ns2 = old_nd.mnt->mnt_namespace;
	if (ns2)
		get_namespace(ns2);
	spin_unlock(&vfsmount_lock);

Then take the semaphores.

Then recheck old_nd.mnt->mnt_namespace, because it might have been
detached between the spin_unlock() and the down_write(&ns2->sem).

It's starting to get a bit complex, and I'm wondering if it's worth it :)

Miklos

