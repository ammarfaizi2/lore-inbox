Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVAMXnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVAMXnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVAMXmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:42:13 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:21674 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S261817AbVAMXbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:31:06 -0500
Date: Thu, 13 Jan 2005 18:30:50 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] shared subtrees
In-reply-to: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <41E704AA.9000305@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just a few comments below.  Some of this will take time to digest ;)

Al Viro wrote:
> [apologies for delay - there'd been lots of unrelated crap lately]
> ======================================================================
> NOTE: as far as I'm concerned, that's a beginning of VFS-2.7 branch.
> All that work will stay in a separate tree, with gradual merge back
> into 2.6 once the things start settling down.
> ======================================================================
> 
> OK, here comes the first draft of proposed semantics for subtree
> sharing.  What we want is being able to propagate events between
> the parts of mount trees.  Below is a description of what I think
> might be a workable semantics; it does *NOT* describe the data
> structures I would consider final and there are considerable
> areas where we still need to figure out the right behaviour.
> 
> Let's start with introducing a notion of propagation node; I consider
> it only as a convenient way to describe the desired behaviour - it
> almost certainly won't be a data structure in the final variant.
> 
> 1) each p-node corresponds to a group of 1 or more vfsmounts.
> 2) there is at most 1 p-node containing a given vfsmount.
> 3) each p-node owns a possibly empty set of p-nodes and vfsmounts
> 4) no p-node or vfsmount can be owned by more than one p-node
> 5) only vfsmounts that are not contained in any p-nodes might be owned.
> 6) no p-node can own (directly or via intermediates) itself (i.e. the
> graph of p-node ownership is a forest).
> 
> These guys define propagation:
> 	a) if vfsmounts A and B are contained in the same p-node, events
> propagate from A to B
> 	b) if vfsmount A is contained in p-node p, vfsmount B is contained
> in p-node q and p owns q, events propagate from A to B
> 	c) if vfsmount A is contained in p-node p and vfsmount B is owned
> by p, events propagate from A to B

How is (c) different from (a)? Is there a distinction between
'containing' and 'owning' here?

> 	d) propagation is transitive: if events propagate from A to B and
> from B to C, they propagate from A to C.
> 
> In other words, members of the same p-node are equivalent and events anywhere
> in p-node are propagated to all its slaves.  Note that not any transitive
> relation can be represented that way; it has to satisfy the following
> condition:
> 	* A->C and B->C => A->B or B->A
> All propagation setups we are going to deal with will satisfy that condition.
> 
> 
> How do we set them up?
> 
> 	* we can mark a subtree sharable.  Every vfsmount in the subtree
> that is not already in some p-node gets a single-element p-node of its
> own.
> 	* we can mark a subtree slave.  That removes all vfsmounts in
> the subtree from their p-nodes and makes them owned by said p-nodes.
> p-nodes that became empty will disappear and everything they used to
> own will be repossessed by their owners (if any).

Would this be better read as "That removes each vfsmount A in the
subtree from its respective p-node p and makes it contained by a new
p-node p' (containing only A), and p' becomes 'owned' by p." ?


> 	* we can mark a subtree private.  Same as above, but followed
> by taking all vfsmounts in our subtree and making them *not* owned
> by anybody.
> 
> 
> Of course, namespace operations (clone, mount, etc.) affect that structure
> and are affected by it (that's what it's for, after all).
> 
> 	1. CLONE_NS
> 
> That one is simple - we copy vfsmounts as usual
> 	* if vfsmount A is contained in p-node p, then copy of A goes into
> the same p-node
> 	* if A is owned by p, then copy of A is also owned by p
> 	* no new p-nodes are created.
> 
> 	2. mount
> 
> We have a new vfsmount A and want to attach it to mountpoint somewhere in
> vfsmount B.  If B does not belong to any p-node, everything is as usual; A
> doesn't become a member or slave of any p-node and is simply attached to B.
> 
> If B belongs to a p-node p, consider all vfsmounts B1,...,Bn that get events
> propagated from B and all p-nodes p1,...,pk that contain them.

By p1,...,pk, I assume you mean all p-nodes in the effective propagation
tree?  If so, the following looks okay.

> 	* A gets cloned into n copies and these copies (A1,...,An) are attached
> to corresponding points in B1,...,Bn.
> 	* k new p-nodes (q1,...,qk) are created
> 	* Ai is contained in qj <=> Bi is contained in qj
> 	* qi owns qj <=> pi owns pj
> 	* qi owns Aj <=> pi owns Bj
> 
> In other words, mount is propagated and propagation among the new vfsmounts
> mirrors the propagation between mountpoints.
> 
> 	3. bind
> 
> bind works almost identically to mount; new vfsmount is created for every
> place that gets propagation from mountpoint and propagation is set up to
> mirror that between the mountpoints.  However, there is a difference: unlike
> the case of mount, vfsmount we were going to attach (say it, A) has some
> history - it was created as a  copy of some pre-existing vfsmount V.  And
> that's where the things get interesting:
> 	* if V is contained in some p-node p, A is placed into the same
> p-node.  That may require merging one of the p-nodes we'd just created
> with p (that will be the counterpart of the p-node containing the mountpoint).
> 	* if V is owned by some p-node p, then A (or p-node containing A)
> becomes owned by p.

I don't follow this.  I still don't see the distinction between being
owned and being contained.  Also, for statements like 'A belongs to B',
which is it?

> 
> 	4. rbind
> rbind is recursive bind, so we just do binds for everything we had in
> a subtree we are binding in obvious order; everything is described
> by previous case.
> 
> 	5. umount
> umount everything that gets propagation from victim.
> 
> 	6. mount --move
> prohibited if what we are moving is in some p-node, otherwise we move
> as usual to intended mountpoint and create copies for everything that
> gets propagation from there (as we would do for rbind).
> 
> 	7. pivot_root
> similar to --move
> 
> 
> How to use all that stuff?
> 
> Example 1:
> 	mount --bind /floppy /floppy
> 	mount --make-shared /floppy
> 	mount --rbind / /jail
> 	<finish setting the jail up, umount whatever doesn't belong there,
> etc.>
> 	mount --make-slave /jail/floppy
> and we get /floppy in chroot jail slave to /floppy outside - if somebody
> (u)mounts stuff on it, that will get propagated to jail.
> 
> Example 2:
> 	same, but with the namespaces instead of chroots.
> 
> Example 3:
> 	same subtree visible (and kept in sync) in several places - just
> mark it shared and rbind; it will stay in sync
> 
> Example 4:
> 	have some daemon control the stuff in a subtree sharable with many
> namespaces, chroots, etc. without any magic:
> 	mark that subtree sharable
> 	clone with CLONE_NS
> 	parent marks that subtree slave
> 	child keeps working on the tree in its private namespace.
> 
> There's a lot more applications of the same idea, of course - AFS and its
> ilk, autofs-like stuff (with proper handling of MNT_EXPIRE and traps - see
> below), etc., etc.
> 
> 
> 
> 	Areas where we still have to figure things out:
> 
> * MNT_EXPIRE handling done right; there are some fun ideas in that area,
> but they still need to be done in more details (basically, lazy expire -
> mount in a slave expiring into a trap that would clone a copy from master
> when stepped upon).
> 
> * traps and their sharing.  What we want is an ability to use the master/slave
> mechanisms for *all* cross-namespace/cross-chroot issues in autofs, so that
> daemon would only need to work with the namespace of its own and no nothing
> about other instances.
> 
> * implementation ;-)  It certainly looks reasonably easy to do; memory
> demands are linear by number of vfsmounts involved and locking appears
> to be solvable.
> 
> * whatever issues that might come up from MVFS demands (and AFS, and...)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


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

iD8DBQFB5wSpdQs4kOxk3/MRAvKoAJ9hpJhSZFSED6yLKvFL8VvwgZfJNwCZAe+x
Ibm55ty86r4EfPVd32OUkTw=
=V1jV
-----END PGP SIGNATURE-----
