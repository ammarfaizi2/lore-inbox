Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTJFUep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTJFUeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:34:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42390 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261740AbTJFUem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:34:42 -0400
Date: Mon, 6 Oct 2003 21:34:38 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Patrick Mochel <mochel@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006203437.GU7665@parcelfarce.linux.theplanet.co.uk>
References: <20031006085915.GE4220@in.ibm.com> <Pine.LNX.4.44.0310061123110.985-100000@localhost.localdomain> <20031006192713.GE1788@in.ibm.com> <20031006193050.GT7665@parcelfarce.linux.theplanet.co.uk> <20031006200110.GA9908@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006200110.GA9908@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 01:31:10AM +0530, Dipankar Sarma wrote:
> > What's more important, for leaves of the sysfs tree your overhead is also
> > a loss - we don't need to pin dentry down for them even with current sysfs
> > design.   And that can be done with minimal code changes and no data changes
> > at all.  Your patch will have to be more attractive than that.  What's the
> > expected ratio of directories to non-directories in sysfs?
> 
> ISTR, a large number of files in sysfs are attributes which are leaves.
> So, keeping a kobject tree partially connected using dentries as backing 
> store as opposed to having everything connected might just be enough.
> It will be looked into.

Note that main reason why sysfs uses ramfs model is that it gets good
interaction with VFS locking for free - it just uses ->i_sem of associated
inodes for tree protection and that gives us all we need.  Very nice,
but it means that we need these associated inodes.  And since operations
are done deep in tree, we don't want to walk all the way from root, bringing
them in-core.

However, having them for all nodes is an overkill - if we keep them only
for non-leaves, we get all the benefits of ramfs approach with less overhead.
Indeed, even if argument of sysfs operation is a leaf node (and I'm not sure
that we actually have such beasts), we can always take the parent node and
be done with that.

All we need is
	a) ->lookup() that would look for an attribute (all directories are
in cache, so if there's no attribute with such name and ->lookup() had been
called, we'd need to return negative anyway).
	b) sysfs code slightly modified in several places - mostly,
sysfs_get_dentry() callers.
