Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVAGBVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVAGBVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAGBV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:21:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58245 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261266AbVAGBUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:20:47 -0500
Date: Fri, 7 Jan 2005 01:20:41 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107012040.GU26051@parcelfarce.linux.theplanet.co.uk>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050107010119.GS1292@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107010119.GS1292@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 05:01:19PM -0800, Paul E. McKenney wrote:
> Thank you for the pointer!  By this, you mean do mount operations in
> conjunction with namespaces, right?

Namespaces or chroots, not much difference...  The point is that you want
to duplicate the mount tree with your stuff added at some point.  Instead
of doing duplication on directory tree level (i.e. having your fs code
try and mirror the stuff from other filesystems), you can do that completely
outside of fs code; either by cloning the namespace first or by building
a chroot jail with mount --rbind / <location of jail> and chrooting in
there.  Then just mount the stuff that really comes from your data at
whatever place you want.

> I will follow up with more detail as I learn more.  The current issue
> seems to be with removeable devices.  Their users want to be accessing
> a particular version, but still see a memory stick that was subsequently
> mounted outside of the view.  Straightforward use of mounts and namespaces
> would prevent the memory stick from being visible to users that were
> already in view.

There is a way to deal with that and since 2.7 is not going to materialize,
we'd better go and resurrect that project in 2.6...  Basically, having
shared and asymmetrically shared subtrees between namespaces/locations
in the same namespace.

I'll try to get the detailed description of that stuff (partial sharing)
written down in a couple of days and post an RFC on l-k and fsdevel.

It's doable, it's not particulary scary, but it sure as hell *far* easier
to do in generic code; there we have access to vfsmount trees and there
lives all code that modifies them, so we don't have to screw with mirroring
directory trees of other filesystems.

	Note that even now you can simply go ahead and mount that stick inside
of view explicitly.  That will work; the question is how to make it automatic
and do that in a sane way.
