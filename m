Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVARTvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVARTvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVARTri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:47:38 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:9427 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261421AbVARTpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:45:15 -0500
Date: Tue, 18 Jan 2005 14:44:58 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <20050117203926.GU26051@parcelfarce.linux.theplanet.co.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <41ED673A.1010906@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
 <41EC0466.9010509@sun.com> <20050117190028.GF24830@fieldses.org>
 <41EC1253.8080902@sun.com> <20050117193206.GH24830@fieldses.org>
 <41EC1BE6.1030506@sun.com>
 <20050117203926.GU26051@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Al Viro wrote:
> On Mon, Jan 17, 2005 at 03:11:18PM -0500, Mike Waychison wrote:
>  
> 
>>I don't think that solves the problem.  B should receive copies (with
>>shared semantics if called for) of all mountpoints C1,..,Cn that are
>>children of A if A->A.  This is regardless of whether or not propagation
>>occurs before or after the attach.
> 
> 
> ... when that makes sense.  Do you see any real problems with the proposed
> behaviour (i.e. propagation happens before attachment)?
> 
> BTW, you do realize that rbind also has "copy before attaching" semantics,
> right?

Ya, okay, that semantic will work.  Please add it to the RFC though :)

>  
> 
>>Allowing this is like allowing directory aliasing in the sense that an
>>aliased directory that is nested within itself opens us to
>>badness/headaches 8)
>>
>>I still think the only way to handle this is to disallow vfsmounts in a
>>p-node to have (grand)parent-child relationships.  This may have to be
>>extended to the 'owned by' case as well.
> 
> 
> Not feasible (and think what _that_ will do to --move, especially since
> propagation can span namespace boundaries).

Fair enough.

Changing the topic slightly: How should we handle propagation events for
the detach_mnt() case?  Is it fair to say: a detach_mnt of A mounted on
dentry d on parent B will 'umount -l Ai' all Ai where Ai is mounted on
dentry d in all peers and private derivatives of the p-node which B
belong to?

Steps to above:
- - Detaching A from parent B (mounted on dentry d)
  - Let S = set of all peer vfsmounts in B's p-node p (if any)
    unioned with all vfsmounts owned by p (expanding owned p-nodes
    recursively):
  - For each C in S
    - If (C has a child mountpoint D mounted on dentry d)
      && (D is equivalent to A)
      - umount -l D

Thoughts?

Also, brainstorming mountpoint expiry: How about something like this:

- - Each p-node has a recently-touched flag, like how vfsmount currently
has a mnt_expiry_mark.
- - A call to umount with MNT_EXPIRE of vfsmount A which is in a non-empty
p-node will:
  - Will check to see if *all* Ai in A's p-node (and derivatives) are
not busy, if not, return -EBUSY
  - Otherwise:
    - Will clear the recently-touched flag of the p-node if set
    - Otherwise it will umount all Ai.

This only works btw for autofs iff we have vfs native traps.  Otherwise
we'll need to do recursive MNT_EXPIRE (overload MNT_EXPIRE | MNT_DETACH?)

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

iD8DBQFB7Wc6dQs4kOxk3/MRAo9/AJ415IkSmKqT7rpvo7Uwr8HZqI0okwCfXYs+
iuXoqlEyzGMCnPKwLlSfgvI=
=OAAC
-----END PGP SIGNATURE-----
