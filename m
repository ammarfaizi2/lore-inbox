Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVD3JYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVD3JYE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 05:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVD3JYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 05:24:04 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:24240 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261167AbVD3JX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 05:23:58 -0400
To: hch@infradead.org
CC: 7eggert@gmx.de, smfrench@austin.rr.com, linux-kernel@vger.kernel.org
In-reply-to: <20050430082952.GA23253@infradead.org> (message from Christoph
	Hellwig on Sat, 30 Apr 2005 09:29:52 +0100)
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu> <20050430082952.GA23253@infradead.org>
Message-Id: <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Apr 2005 11:22:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> >   - global limit on user mounts
> 
> I don't think we need that one.

We have that for open files '/proc/sys/fs/file-max'.  It limits the
total memory usage of the thing.  Which otherwise is hard if you have
a system with lots of users.

> >   - possibly per user limit on mounts
> 
> Makes sense as an ulimit, that way the sysadmin can easily disable the
> user mount feature aswell.
> 
> >   - acceptable mountpoints (unlimited writablity is probably a good minimum)
> 
> Yupp.
> 
> >   - acceptable mount options (nosuid, nodev are obviously not)
> 
> noexecis a bit too much, so the above look good.
> 
> >   - filesystems "safe" to mount by users
> 
> what filesystem do you think is unsafe?
> 
>  - virtual filesystems exporting kernel data are obviously safe as
>    they enforce permissions no matter who mounted them.  (actually we'd
>    need to check for some odd mount options)

Maybe sysadmin doesn't want to let users see /sys for example.  How
would you disable it if users can mount it themselfes?  OK, you can
disable user mounts completely, but that's probably not fine grained
enough for some.

>  - block-based filesystems should be safe as long as the mounter has
>    access to the underlying block device

Not true if user controls the baking device (e.g. loopback).  Most
block based filesystems are probably unsafe at the moment, because not
enough consistency checking is done at runtime.  Are things like
non-cyclic directory graphs ensured by all filesystems?  My guess is
not.  See also Linus' comment about the state of the iso9660
filesystem:

  http://lwn.net/Articles/128744/

>  - network/userspace filesystems should be fine aswell

They should, but again I wonder if NFS with all it's complexity is
being careful enough with what it accepts from the server.

Smbfs might be close to safe, since it's already available for users
to mount from an arbitrary server.

So safeness is a per-filesystem property, determined, how well it
checks input.

Miklos
