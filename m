Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUBSBza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUBSBz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:55:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:63719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267438AbUBSBzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:55:24 -0500
Date: Wed, 18 Feb 2004 17:48:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] How should delete_resource() handle children?
Message-Id: <20040218174800.0a3183ec.rddunlap@osdl.org>
In-Reply-To: <20040210193349.GI13351@parcelfarce.linux.theplanet.co.uk>
References: <20040210193349.GI13351@parcelfarce.linux.theplanet.co.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 19:33:49 +0000 Matthew Wilcox <willy@debian.org> wrote:

| 
| If you call release_resource() on a resource that has children, all
| of those children are silently removed from the list too.  Does anybody
| currently depend on that behaviour?
| 
| There are three valid behaviours I can think of for this:
| 
|  * Current behaviour, on the assumption that all the children of this
|    resource are also owned by this device, and so removing them is the
|    right thing to do.
| 
|  * BUG_ON() on the basis you should never do this.
| 
|  * Reparent the children to the parent resource of the one being released.
| 
| The first option has the problem that if the children of the resource
| belong to some other part of the system, they still have pointers into
| their parent which is now gone.  Memory corruption will follow.
| 
| The second option has the problem that if you *do* need to delete this
| resource but keep its children linked in, you can't do it in a race-free
| manner.
| 
| The third option has the problem that if you were relying on the current
| behaviour of release_resource(), the parent/siblings of the deleted
| resource still have references to objects you thought were deleted.
| 
| 
| I like the third option best.  Now that we have insert_resource(), the
| corresponding release_resource() should leave the children in the state
| they were in before.
| 
| An alternative possibility would be to introduce a remove_resource()
| that implements the reparenting option and leave the current behaviour
| of release_resource() alone.
| 
| 
| Comments?

Ideally (or if nothing depends on the current behavior), I think it
should just be an error (return -EINVAL), not a BUG_ON().  I.e.,
releasing a resource should be an explicit action.

Do we know of cases where parents are removed but children need to
remain?  Examples?

--
~Randy
