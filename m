Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVDEJok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVDEJok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVDEJmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:42:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:53949 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261677AbVDEJhw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:37:52 -0400
Subject: Re: [RFC] shared subtrees
From: Ram <linuxram@us.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
	 <20050116160213.GB13624@fieldses.org>
	 <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050116184209.GD13624@fieldses.org>
	 <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1112693868.4258.105.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Apr 2005 02:37:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 22:11, Al Viro wrote:
> On Sun, Jan 16, 2005 at 01:42:09PM -0500, J. Bruce Fields wrote:
> > On Sun, Jan 16, 2005 at 06:06:56PM +0000, Al Viro wrote:
> > > On Sun, Jan 16, 2005 at 11:02:13AM -0500, J. Bruce Fields wrote:
> > > > On Thu, Jan 13, 2005 at 10:18:51PM +0000, Al Viro wrote:
> > > > > 	6. mount --move
> > > > > prohibited if what we are moving is in some p-node, otherwise we move
> > > > > as usual to intended mountpoint and create copies for everything that
> > > > > gets propagation from there (as we would do for rbind).
> > > > 
> > > > Why this prohibition?
> > > 
> > > How do you propagate that?  We can weaken that to "in a p-node that
> > > owns something or contains more than one vfsmount", but it's not
> > > worth the trouble, AFAICS.
> > 
> > I guess I'm not seeing what there is to propagate.  If the vfsmount we
> > are moving is mounted under a vfsmount that's in a p-node, then there'd
> > be something to propagate, but since the --move doesn't change the
> > structure of mounts underneath the moved mountpoint, I wouldn't expect
> > any changes to be propagated from it to other mountpoints.
> > 
> > I must be missing something fundamental....
> 
> No - I have been missing a typo.  Make that "if mountpoint of what we
> are moving...".

Ok. I have been spending time lately on implementing this RFC. So time
for some questions.

If the vfsmount that is being moved is mounted within a shared-vfsmount
(i.e is in p-node) why should the move operation be prohibited?

The way I look at it is: umount the vfsmount, propogate the unmount
event to all corresponding vfsmounts, and mount the vfsmount struct at
its destination and if applicable propogate the mount event.

An example:

     If A is a vfsmount contained in pnode p  and B is a vfsmount
mounted on A, and B is moved to a mountpoint on vfsmount C the
operations involved are:

1. umount B from A and  propogate the unmount to all vfsmount 	contained
in p as well as recursively to all slave-pnodes 
         and slave vfsstructs.
2. mount B on the mountpoint in C, and if C is in
   some p-node,  propogate the mount to all vfsmounts in that
   pnode as well as recursively to its slave p-nodes and
   slave vfsstructs.



RP


> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

