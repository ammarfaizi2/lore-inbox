Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVANA2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVANA2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVANAUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:20:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52200 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261778AbVANATV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:19:21 -0500
Date: Fri, 14 Jan 2005 00:19:20 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050114001920.GJ26051@parcelfarce.linux.theplanet.co.uk>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <41E704AA.9000305@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E704AA.9000305@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 06:30:50PM -0500, Mike Waychison wrote:
> > 1) each p-node corresponds to a group of 1 or more vfsmounts.
> > 2) there is at most 1 p-node containing a given vfsmount.
> > 3) each p-node owns a possibly empty set of p-nodes and vfsmounts
> > 4) no p-node or vfsmount can be owned by more than one p-node
> > 5) only vfsmounts that are not contained in any p-nodes might be owned.
> > 6) no p-node can own (directly or via intermediates) itself (i.e. the
> > graph of p-node ownership is a forest).
> > 
> > These guys define propagation:
> > 	a) if vfsmounts A and B are contained in the same p-node, events
> > propagate from A to B
> > 	b) if vfsmount A is contained in p-node p, vfsmount B is contained
> > in p-node q and p owns q, events propagate from A to B
> > 	c) if vfsmount A is contained in p-node p and vfsmount B is owned
> > by p, events propagate from A to B
> 
> How is (c) different from (a)? Is there a distinction between
> 'containing' and 'owning' here?

Yes.  See (3) and (1) above.  Consider the following:
p = {A, B}
p owns C

Then we have propagation between A and B _and_ from either to C.

> > 	* we can mark a subtree slave.  That removes all vfsmounts in
> > the subtree from their p-nodes and makes them owned by said p-nodes.
> > p-nodes that became empty will disappear and everything they used to
> > own will be repossessed by their owners (if any).
> 
> Would this be better read as "That removes each vfsmount A in the
> subtree from its respective p-node p and makes it contained by a new
> p-node p' (containing only A), and p' becomes 'owned' by p." ?

No.  "Belongs to a single-element p-node" != "doesn't belong to any
p-node".  The former means "share on copy" (and might have slaves).
The latter is noone's master.  Again, see the propagation rules and
behaviour on clone/rbind.

> > 	* if V is contained in some p-node p, A is placed into the same
> > p-node.  That may require merging one of the p-nodes we'd just created
> > with p (that will be the counterpart of the p-node containing the mountpoint).
> > 	* if V is owned by some p-node p, then A (or p-node containing A)
> > becomes owned by p.
> 
> I don't follow this.  I still don't see the distinction between being
> owned and being contained.  Also, for statements like 'A belongs to B',
> which is it?

"V owned by p" == "V is a slave of (equivelent) members of p"
"p contains V" == "V is one of the members of p, whatever happens to it
will happen to all of them".

"element belongs to set" means what it usually means ;-) (again, p-nodes
are sets of vfsmounts).
