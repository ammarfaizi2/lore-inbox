Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266145AbUBJTd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUBJTd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:33:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266145AbUBJTdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:33:51 -0500
Date: Tue, 10 Feb 2004 19:33:49 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] How should delete_resource() handle children?
Message-ID: <20040210193349.GI13351@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you call release_resource() on a resource that has children, all
of those children are silently removed from the list too.  Does anybody
currently depend on that behaviour?

There are three valid behaviours I can think of for this:

 * Current behaviour, on the assumption that all the children of this
   resource are also owned by this device, and so removing them is the
   right thing to do.

 * BUG_ON() on the basis you should never do this.

 * Reparent the children to the parent resource of the one being released.

The first option has the problem that if the children of the resource
belong to some other part of the system, they still have pointers into
their parent which is now gone.  Memory corruption will follow.

The second option has the problem that if you *do* need to delete this
resource but keep its children linked in, you can't do it in a race-free
manner.

The third option has the problem that if you were relying on the current
behaviour of release_resource(), the parent/siblings of the deleted
resource still have references to objects you thought were deleted.


I like the third option best.  Now that we have insert_resource(), the
corresponding release_resource() should leave the children in the state
they were in before.

An alternative possibility would be to introduce a remove_resource()
that implements the reparenting option and leave the current behaviour
of release_resource() alone.


Comments?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
