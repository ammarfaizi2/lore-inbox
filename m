Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVGNB1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVGNB1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 21:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVGNB1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 21:27:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:26599 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262204AbVGNB1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 21:27:31 -0400
Subject: Re: [RFC PATCH 1/8] share/private/slave a subtree
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       mike@waychison.com, bfields@fieldses.org
In-Reply-To: <E1DqyqO-00057C-00@dorka.pomaz.szeredi.hu>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120817463.30164.43.camel@localhost>
	 <E1Dqttu-0004kx-00@dorka.pomaz.szeredi.hu>
	 <1120839568.30164.88.camel@localhost>
	 <E1Dqw4W-0004sT-00@dorka.pomaz.szeredi.hu>
	 <1120845120.30164.139.camel@localhost>
	 <E1DqyqO-00057C-00@dorka.pomaz.szeredi.hu>
Content-Type: multipart/mixed; boundary="=-rloDelZGb8/j++oazRCJ"
Organization: IBM 
Message-Id: <1121304437.5288.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Jul 2005 18:27:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rloDelZGb8/j++oazRCJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-07-08 at 12:49, Miklos Szeredi wrote:
> > The reason why I implemented that way, is to less confuse the user and
> > provide more flexibility. With my implementation, we have the ability
> > to share any part of the tree, without bothering if it is a mountpoint
> > or not. The side effect of this operation is, it ends up creating 
> > a vfsmount if the dentry is not a mountpoint.
> > 
> > so when a user says
> >       mount --make-shared /tmp/abc
> > the tree under /tmp/abc becomes shared. 
> > With your suggestion either the user will get -EINVAL or the tree
> > under / will become shared. The second behavior will be really
> > confusing.
> 
> You are right.
> 
> > I am ok with -EINVAL. 
> 
> I think it should be this then.  These operations are similar to a
> remount (they don't actually mount something, just change some
> property of a mount).  Remount returns -EINVAL if not performed on the
> root of a mount.
> 
> > Also there is another reason why I used this behavior. Lets say /mnt
> > is a mountpoint and Say a user does
> > 		mount make-shared /mnt 
> > 
> > and then does 
> >                 mount --bind /mnt/abc  /mnt1
> > 
> > NOTE: we need propogation to be set up between /mnt/abc and /mnt1 and
> > propogation can only be set up for vfsmounts.  In this case /mnt/abc 
> > is not a mountpoint. I have two choices, either return -EINVAL
> > or create a vfsmount at that point. But -EINVAL is not consistent
> > with standard --bind behavior. So I chose the later behavior.
> > 
> > Now that we anyway need this behavior while doing bind mounts from
> > shared trees, I kept the same behavior for --make-shared.
> 
> Well, the mount program can easily implement this behavior if wanted,
> just by doing the 'bind dir dir' and then doing 'make-shared dir'.
> 
> The other way round (disabling the automatic 'bind dir dir') is much
> more difficult.

Ok. will make it -EINVAL. It was not clear in Al Viro's RFC what the
behavior should be.

> 
> > > Some notes (maybe outside the code) explaining the mechanism of the
> > > propagations would be nice.  Without these it's hard to understand the
> > > design decisions behind such an implementation.
> > 
> > Ok. I will make a small writeup on the mechanism.
> 
> That will help, thanks.

A small writeup is enclosed. Caution its too complex. :) 

RP

Sorry if reading it as a attachment is difficult. my mailer does
not allow me to inline properly. will try mutt next time.

--=-rloDelZGb8/j++oazRCJ
Content-Disposition: attachment; filename=pnode.writeup
Content-Type: text/plain; name=pnode.writeup
Content-Transfer-Encoding: 7bit

		Pnode traversal implementation.


This write-up explains the motivation and reason behind the implementation
of pnode_next() and pnode_traverse() functionality.

Section 1 explains the operations  involved during a mount in a shared subtree.
Section 2 explains the operations  involved during a umount in a shared subtree.
Section 3 explains the operations  involved to check of umount_busy in
	shared subtree.
Section 4 explains the operations  involved in making a overlay mount in
	a shared subtree. (make_mounted operation)
Section 5 explains the operations  involved in removing a overlay mount in
	a shared subtree. (make_umounted operation)

And finally section 6 explains the motivation behind the pnode_next()
and pnode_traverse().

	Caution: head can spin as you try to understand the detail. :)


Section 1. mount:

	to begin with we have a the following mount tree 

		         root
		      /	/  \  \ \
		     /	t1  t2 \  \ 
		   t0		t3 \
				    t4

	note: 
	t0, t1, t2, t3, t4 all contain mounts.
	t1 t2 t3 are the slave of t0. 
	t4 is the slave of t2.
	t4 and t3 is marked as shared.

	The corresponding propagation tree will be:

			p0
		      /   \
		     p1   p2
		     /     
	 	     p3	   


	***************************************************************
	      p0 contains the mount t0, and contains the slave mount t1
	      p1 contains the mount t2
	      p3 contains the mount t4
	      p2 contains the mount t3

	  NOTE: you may need to look at this multiple time as you try to
	  	understand the various scenarios.
	***************************************************************

	
	now if we mount something under the mount t0, the same has
	be mounted under all the other mounts (t1,t2,t3,and t4) and
	the new propagation tree for all these child mounts should
	look identical to the one of their parents.

	say I mounted something under /t0/abc the new mount tree will
	look like:

		         root
		      /	/  \  \ \
		     /	t1  t2 \  \ 
		   t0   /   /   t3 \
		   /   c1  c2	/   t4
		  c0	       c3    \
		  		     c4

		and we will have the following propagation trees.

			p0			s0  
		      /   \     	      /   \
		     p1   p2    	     s1   s2
		     /          	     /     
	 	     p3	         	     s3	   

		the propagation tree for all the new child mounts
		will look exactly like that of its parent.

	      s0 contains the mount c0, and contains the slave mount c1
	      s1 contains the mount c2
	      s3 contains the mount c4
	      s2 contains the mount c3


	In order to implement this functionality, we need to walk through
	the pnode tree of the parent mount. For each pnode encountered
	in the tree we have to create a new pnode and make the new child
	mounts as the members of their corresponding pnode, and finally
	set the master slave relationship between each of the newly
	created pnodes.

	lets step through the operations:
	1. start at pnode p0, create a new pnode s0.
	2. walk down to p1, create a new pnode s1.
	3. walk down to p3, create a new pnode s3.
	4. since there is no slave pnode for p3, complete the mount operations.
	      (a) create a new child mount c4 under t4 and make c4 member
	     		of s3.
	5. walk up back from p3 to p1, and make s3 the slave of s1.
	6. since there are no more slave pnodes for p3, complete the
		mount operations.
	      (a) create a new child mount c2 under t2 and make c2 member
	     		of s1.
	7. walk up back from p1 to p0 and make s1 the slave pnode of s0.
	8. since p2 is the next slave pnode of p0, walk down to p2, and
	   create a new pnode s2.
	9. since there is no slave pnodes of p2, complete the mount operations
	      (a) create a new child mount c3 under t3 and make c3 member
	     		of s2.
	10. walk up from p2 to p0 and make s2 the slave pnode of s0.
	11. since there are no more slave pnodes for p0, complete the
		mount operations.
	      (a) create a new child mount c0 under t0 and make c0 member
	     		of s0.
	      (b) create a new child mount c1 under t1 and make c1 
	      		slave-member of s0.
	11. done.

	
	The key point to be noted in the above set of operations is:
	each pnode does three different operations corresponding to each stage.

	A. when the pnode is encountered the first time, it has to create
		a new pnode for its child mounts.
	B. when the pnode is encountered again after it has traversed down
	   each slave pnode, it has to associate the slave pnode's newly created
	   pnode with the pnode's newly created pnode.
	C. when the pnode is encountered finally after having traversed through
		all its slave pnodes, it has to create new child mounts
		for each of its member mounts.

	that is the reason next_mnt() returns the same pnode multiple times
	with the following flags to indicate the context:
	(1) PNODE_DOWN to indicate context (A)
	(2) PNODE_MID to indicate context (B)
	(3) PNODE_UP to indicate context (C)


Section 2. umount:

	Umount is a less complex operation. The crux of its work
	lies when the pnode has walked through all of its slaves.
	(which is phase C). 

	Consider the following mount tree.
	and the following pnode trees.

		         root
		      /	/  \  \ \
		     /	t1  t2 \  \ 
		   t0   /   /   t3 \
		   /   c1  c2	/   t4
		  c0	       c3    \
		  		     c4

		and we will have 2 propagation trees.

			p0			s0  
		      /   \     	      /   \
		     p1   p2    	     s1   s2
		     /          	     /     
	 	     p3	         	     s3	   

	if a umount is attempted on c0, all the other child mounts 
	c0,c1,c2,c3,c4 should also be unmounted. The steps are:

	(1) start at pnode p0. nothing to do currently.
	(2) walk down to p1. nothing to do currently.
	(3) walk down to p3. nothing to do currently.
	(4) since p3 has no slave pnode.
		unmount mounts corresponding to its members. 
		In this case t4 is a member of p3, so unmount c4,
		and release c4 from its pnode s3.
	(5) walk back up to p1 and check if there are any more 
		slave pnodes.  Since there are no more slave pnodes
		unmount the mounts corresponding to its members.
		In this case, t2 is a member of p1, unmount c2,
		and release c2 from its pnode s1.
	(6) walk back up to p0 and check if there are any more 
		slave pnodes.  There is one more slave pnode p2.
		do nothing.
	(7) walk down to p2. nothing to do currently.
	(8) since p2 has no slave pnode, unmount mounts
		corresponding to its members. In this case t3 is
		a member of p2. So unmount c3, and release c3 from
		its pnode s2.
	(9) walk back up to p0 and check if there are any more slave
		pnodes. There is no more slave pnodes, so
		unmount mounts corresponding to its members. In 
		this case t0 and t1 are the member and slave-member
		mounts currently.  so unmount c0 and c1 and 
		detach them from their pnodes which is s0.
	(10) done!


	Again as in the mount case(section 1), here also we traverse
	the pnode tree similarly, but crux of the operations is
	done in the phase C i.e in the context of PNODE_UP.


Section 3. checking for umount busy
	The operations are again mostly identical to section (2),
	and the crux of the operations are in phase C i.e in the
	context of PNODE_UP.

Section 4. make mounted operation.
	this operations overlay mount on the same dentry. Its operations
	are mostly similar to that of mount.

Section 5. make unmounted operation.
	this operation is the inverse of make-mounted operation. Its operations
	are mostly similar to that of umount.



Section 6:

	The large amount of common of operations done during mount,umount,
	umount_busy, and others motivates the need of a common abstractions
	which all these operations can exploit. That is the reason for the
	function pnode_traverse()

	pnode_traverse() takes 3 different function pointers.
	1. pnode_pre_func() which is called when PNODE_DOWN is encountered.
	2. pnode_post_func() which is called when PNODE_MID is encountered.
	3. vfs_func() is called on each of the member/slave vfsmount 
		of the pnode this function is called when PNODE_UP 
		is encountered.

	There is scope for optimization, by colleasing the work done at phase
	(A) and phase (C), and maybe we can eliminate phase (B) using some
	intelligent techniques. 

	The reason I have not spent much time optimizing this right now is that,
	as we understand better about the functionality we may need all these
	phases. Once I am absolutely convinced that we don't need some of
	these phases, I will optimize them.

--=-rloDelZGb8/j++oazRCJ--

