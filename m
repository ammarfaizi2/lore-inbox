Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVAYVYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVAYVYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVAYVMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:12:42 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:27588 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262146AbVAYVHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:07:35 -0500
Subject: Re: [RFC] shared subtrees
From: Ram <linuxram@us.ibm.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050117173213.GC24830@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
	 <20050116160213.GB13624@fieldses.org>
	 <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050116184209.GD13624@fieldses.org>
	 <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
	 <20050117173213.GC24830@fieldses.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1106687232.3298.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 Jan 2005 13:07:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 09:32, J. Bruce Fields wrote:
> On Mon, Jan 17, 2005 at 06:11:50AM +0000, Al Viro wrote:
> > No - I have been missing a typo.  Make that "if mountpoint of what we
> > are moving...".
> 
> OK, got it, so the point is that its not clear how you'd propagate the
> removal of the subtree from the vfsmount of the source mountpoint.
> 
> By the way, I wrote up some notes this weekend in an attempt to explain
> the shared subtrees RFC to myself.  They may or may not be helpful to
> anyone else:
> 
> http://www.fieldses.org/~bfields/kernel/viro_mount_propagation.txt


Question 1:

If there exists a private subtree in a larger shared subtree, what
happens when the larger shared subtree is rbound to some other place? 
Is a new private subtree created in the new larger shared subtree? or
will that be pruned out in the new larger subtree?

Concrete example:

        mount <device1> /tmp/mnt1
        mount <device2> /tmp/mnt1/mnt1.1
        mount <device3> /tmp/mnt1/mnt1.1/mnt1.1.1
        make --make-shared /tmp/mnt1
        mount --make-private /tmp/mnt1/mnt1.1
        make --rbind /tmp/mnt1  /tmp/mnt2

        Question: will I see the mount at /tmp/mnt2/mnt1.1/mnt1.1.1 ?

        My guess is since /tmp/mnt1/mnt1.1 is private that subtree
	should not be even seen under /tmp/mnt2/mnt1.1 , Is that 
	the case? Or does the subtree get mirrored in /tmp/mnt2/mnt1.1;
        however propogation is not set between the vfsstruct  of
	/mnt/mnt1/mnt1.1 and /mnt/mnt2/mnt1.1 ?

        I believe its the former case.


Question 2:

When a mount gets propogated to a slave, but the slave
has mounted something else at the same place, and hence 
that mount point is masked, what will happen?

        Concrete example:

        mount <device1> /tmp/mnt1
        mkdir -p /tmp/mnt1/a/b
        mount --rbind /tmp/mnt1 /tmp/mnt2
        mount --make-slave /tmp/mnt2
        mount <device2> /tmp/mnt2/a
        rm -f /tmp/mnt2/a/*

        what happens when a mount is attempted on /tmp/mnt1/a/b?
        will that be reflected in /tmp/mnt2/a ?

        I believe the answer is 'no', because that part of the subtree 
        in /tmp/mnt2 no more mirrors its parent subtree.

RP 

