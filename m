Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVAYVxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVAYVxB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVAYVv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:51:56 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:62935 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262165AbVAYVrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:47:31 -0500
Date: Tue, 25 Jan 2005 16:47:04 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <1106687232.3298.37.camel@localhost>
To: Ram <linuxram@us.ibm.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <41F6BE58.50208@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
 <20050116160213.GB13624@fieldses.org>
 <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
 <20050116184209.GD13624@fieldses.org>
 <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
 <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Ram,

I can't speak for Al, but the following is how I understand it:

Ram wrote:
> On Mon, 2005-01-17 at 09:32, J. Bruce Fields wrote:
> 
>>On Mon, Jan 17, 2005 at 06:11:50AM +0000, Al Viro wrote:
>>
>>>No - I have been missing a typo.  Make that "if mountpoint of what we
>>>are moving...".
>>
>>OK, got it, so the point is that its not clear how you'd propagate the
>>removal of the subtree from the vfsmount of the source mountpoint.
>>
>>By the way, I wrote up some notes this weekend in an attempt to explain
>>the shared subtrees RFC to myself.  They may or may not be helpful to
>>anyone else:
>>
>>http://www.fieldses.org/~bfields/kernel/viro_mount_propagation.txt
> 
> 
> 
> Question 1:
> 
> If there exists a private subtree in a larger shared subtree, what
> happens when the larger shared subtree is rbound to some other place? 
> Is a new private subtree created in the new larger shared subtree? or
> will that be pruned out in the new larger subtree?
> 
> Concrete example:
> 
>         mount <device1> /tmp/mnt1
>         mount <device2> /tmp/mnt1/mnt1.1
>         mount <device3> /tmp/mnt1/mnt1.1/mnt1.1.1
>         make --make-shared /tmp/mnt1
>         mount --make-private /tmp/mnt1/mnt1.1

Not needed, see below:

>         make --rbind /tmp/mnt1  /tmp/mnt2
> 
>         Question: will I see the mount at /tmp/mnt2/mnt1.1/mnt1.1.1 ?
> 
>         My guess is since /tmp/mnt1/mnt1.1 is private that subtree
> 	should not be even seen under /tmp/mnt2/mnt1.1 , Is that 
> 	the case? Or does the subtree get mirrored in /tmp/mnt2/mnt1.1;
>         however propogation is not set between the vfsstruct  of
> 	/mnt/mnt1/mnt1.1 and /mnt/mnt2/mnt1.1 ?
> 
>         I believe its the former case.

Although Al hasn't explicitly defined the semantics for mount
- --make-shared, I think the idea is that 'only' that mountpoint becomes
tagged as shared (becomes a member of a p-node of size 1).  The
- --make-shared / --make-private / --make-slave should probably all be
non-recursive actions.

/tmp/mnt1/mnt1.1 and /tmp/mnt1/mnt1.1/mnt1.1.1 will remain private.

The --rbind is described as simply walking the vfsmount tree rooted at
the argument and performing --bind.

So:

- - /tmp/mnt2 becomes a peer of /tmp/mnt1, because /tmp/mnt1 was in a
non-empty p-node.
- - /tmp/mnt2/mnt1.1 becomes a copy of /tmp/mnt1/mnt1.1 because the latter
was not in a p-node.
- - /tmp/mnt2/mnt1.1.1 becomes a copy of /tmp/mnt1/mnt1.1/mnt1.1.1 because
the latter was not in a p-node.

Only new mounts placed on top of /tmp/mnt1 and /tmp/mmnt2 will get
propagated back and forth.

> 
> 
> Question 2:
> 
> When a mount gets propogated to a slave, but the slave
> has mounted something else at the same place, and hence 
> that mount point is masked, what will happen?
> 
>         Concrete example:
> 
>         mount <device1> /tmp/mnt1
>         mkdir -p /tmp/mnt1/a/b
>         mount --rbind /tmp/mnt1 /tmp/mnt2
>         mount --make-slave /tmp/mnt2

EINVAL.  You should only be able to demote a mountpoint to a slave if it
was part of a p-node (shared).

>         mount <device2> /tmp/mnt2/a
>         rm -f /tmp/mnt2/a/*
> 
>         what happens when a mount is attempted on /tmp/mnt1/a/b?
>         will that be reflected in /tmp/mnt2/a ?
> 
>         I believe the answer is 'no', because that part of the subtree 
>         in /tmp/mnt2 no more mirrors its parent subtree.
> 
> RP 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9r5YdQs4kOxk3/MRApT3AJ9xxpdacU0mp8IvsY395MDtEktJ+wCeOvRT
/g7qXO9nGxMT/iFAZoUO8F4=
=9D2G
-----END PGP SIGNATURE-----
