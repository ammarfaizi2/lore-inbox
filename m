Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWFSTJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWFSTJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWFSTJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:09:52 -0400
Received: from thunk.org ([69.25.196.29]:2202 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932465AbWFSTJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:09:51 -0400
Date: Mon, 19 Jun 2006 15:09:55 -0400
From: Theodore Tso <tytso@mit.edu>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 0/8] Inode slimming
Message-ID: <20060619190955.GI15216@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <Pine.LNX.4.64.0606190953180.21382@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606190953180.21382@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 09:54:22AM -0700, Christoph Lameter wrote:
> On Mon, 19 Jun 2006, Theodore Tso wrote:
> 
> > What else remains to be done?  There are a large number of fields in
> > struct inode which are never populated unless the inode is open, and
> > those should get moved into another structure which is populated only
> > when needed.  There are a large number of inodes which are read into
> > memory only because stat(2) was called on them (thanks to things like
> > color ls, et. al).  
> 
> One could remove the reclaim list and use the slab lists of the slab 
> allocator to scan through the inodes and reclaim them in such a way
> that would maximize the number of pages freed. I will post an RFC on that 
> one later. This may reduce the complexity of inode reclaim.

That may very well be a good thing to do (although if it is too
aggressive we may end up reducing the utility of the dentry cache ---
your patch is going to try to free the dentries pinning inodes, right?
Otherwise it will probably not have much effect), but I think that's a
largely orthogonal issue.  It will still be good to be able to cache
inodes (and dentries), but it would be desireable if we can do this in
less memory than it currently takes, and separating out those fields
which are only needed when the inode is opened, or when its pages are
cached in the page cache, would be a good way of minimizing the
footprint of inodes who only needs to have their stat(2) information
cached.

Regards,

						- Ted

