Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314067AbSEAVoa>; Wed, 1 May 2002 17:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314068AbSEAVo3>; Wed, 1 May 2002 17:44:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53189 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314067AbSEAVo2>;
	Wed, 1 May 2002 17:44:28 -0400
Date: Wed, 1 May 2002 17:44:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alternative API for raw devices
In-Reply-To: <3CD057BE.2050603@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0205011724470.12640-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 May 2002, Jeff Garzik wrote:

> Alexander Viro wrote:
> 
> >Actual IO code is pretty much copied from old driver.  The main differences:
> >	* device is originally created with ownership/permissions of the
> >	  block device we'd used; you can chmod/chown it at any time,
> >	  obviously.
> >
> 
> Tangent a little bit to partitions.
> 
> Consider a filesystem which creates device nodes for N partitions on a 
> spindle, "msdos_partition_fs".  In a discussion a while back on 
> permissions, you suggested that inheriting permissions from the base 
> block device was the wrong way to go, and that (for now)  'uid' and 
> 'gid' mount options were the best route.
 
> Is inheriting permissions coming back into style?  Or am I reading too 
> much into the permissions scheme you describe above?

Umm...  Let me put it that way: partitions are persistent objects.  We
have very legitimate reasons to assign equally persistent ownership and
permissions to them; moreover, different ownership and permissions.

For a raw device, bindings are not persistent.  Unlike partitions, there's
simply no way to tell by device number what will it be associated with.
So persistent ownership/permissions for these guys make no sense whatsoever;
moreover, the data they give you access to is simply the contents of block
device; there's no such thing as "permissions to access this part".

So we simply set permissions/ownership in obviously safe way (i.e. such that
it doesn't change access rights compared to what we had before binding -
set ownership/permissions identical to these of block device) and leave
it to whoever had created a binding to do explicit chown/chmod if he
wants to do that.

Moreover, when we lift the restrictions on mount (i.e. creator of namespace
may mount on places he has sufficient access to, but filesystem needs to be
convinced that he deserves to mount it in the first place) we might allow
to create raw devices to everyone; in that case chmod/chown after mounting
is obviously the only safe scheme.

