Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUHNUln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUHNUln (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUHNUln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:41:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:20945 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265288AbUHNUll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:41:41 -0400
Date: Sat, 14 Aug 2004 13:41:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][LIBFS] Move transaction file ops into libfs + cleanup (update)
Message-ID: <20040814134137.Y1924@build.pdx.osdl.net>
References: <Xine.LNX.4.44.0408131157350.23262-100000@dhcp83-76.boston.redhat.com> <Xine.LNX.4.44.0408141231300.27007-100000@dhcp83-76.boston.redhat.com> <20040814125501.U1973@build.pdx.osdl.net> <20040814202343.GA12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040814202343.GA12308@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Sat, Aug 14, 2004 at 09:23:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* viro@parcelfarce.linux.theplanet.co.uk (viro@parcelfarce.linux.theplanet.co.uk) wrote:
> On Sat, Aug 14, 2004 at 12:55:01PM -0700, Chris Wright wrote:
> > Looks nice. I didn't realize you were working on this consolidation too.
> > I cooked up a similar patch.  In this case the user loads its inode
> > specific write_ops on open, then just uses the generic helpers.  I also
> > fully serialized all write/read transactions per inode.  It's lightly
> > tested.  If there's anything you like in there, feel free to use it.
> 
> This is *wrong*.

Thanks for peeking at it.

> First of all, it ties you to ->i_ino values.  Which is OK on a specific
> fs, but not in a generic helper functions.

Good point.

> What's more, there is no point in any extra structures here - you are
> getting a file-specific method anyway, so you make it ->write() (which
> is where behaviour differs) instead of ->open().  Which kills the
> need of callbacks.
> 
> As a general rule, it's better to provide several helpers and let the
> users of interface call them rather than trying to fit everything into
> callbacks, flags, etc.

Yes, I took too simplistic a view on moving the common code over to
generic.

> Consider for instance a driver that wants one such request/reply file.
> With your scheme it will have to declare two functions - foo_write_op()
> and foo_open(), the latter being a boilerplate _and_ declare (for fsck
> knows what reason) a single-element array so that foo_open() could pass
> array - file->f_dentry->d_inode->i_ino, only to compensate for use of
> ->i_ino in your helper.
> 
> Lots of glue for no good reason _and_ a new function type to deal with.
> As opposed to one function (foo_write()) that is a normal instance of
> ->write() and is actually smaller than your foo_write_op() + foo_open().
> No arrays, no magic, no boilerplate code...

Agreed.  Thanks for the feedback.
-chris
