Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUCGJhz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 04:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUCGJhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 04:37:55 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:11782 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261784AbUCGJhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 04:37:54 -0500
Date: Sun, 7 Mar 2004 09:37:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com, Dave Blaschke <blaschke@us.ibm.com>
Subject: Re: [PATCH] JFS DMAPI
Message-ID: <20040307093745.A14680@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
	Dave Blaschke <blaschke@us.ibm.com>
References: <1078444492.9162.56.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1078444492.9162.56.camel@shaggy.austin.ibm.com>; from shaggy@austin.ibm.com on Thu, Mar 04, 2004 at 05:54:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 05:54:52PM -0600, Dave Kleikamp wrote:
> Andrew,
> Would you consider adding this patch to -mm?  This would add the DMAPI
> interface to JFS.  This function has long been requested by HSMs
> (Hierarchical Storage Managers).  It is based on SGI's XFS
> implementation, but has been clean up to avoid their vnode interface.

Umm, no.  There's a reason the XFS code this is based on isn't merged, and
the problem is the DMAPI spec.  E.g. you still have this utterly incompatible
to Linux semantics of providing a mount option to specifiy the canonical
name for a mount  point as dmapi doesn't understand the concept of multiple
mounts for a given fs or namespaces, you still don't get the post-unmount
even rights, the handle2path stuff is still as broken, how do you handle
the mprotect vs dmapi regions interaction the 2.4 XFS tree has the mprotect
vm operation hack for, etc..?

So the question is whether IBM just wants to provide this for customers that
can live with the incompatbilities or really wants to provide HSM support
for mainline.

In the first case I'd suggest you clean up the changes to the JFS core to
not require ifdefs all over the place and submit that one for mainline
inclusion so the dmapi dir can more less be dropped into the tree ala
XFS.

If IBM actually wants to support proper HSM support for Linux let's go back
to the drawing board.  Some specific requirements:

 - move the events from fs-specific code to common code.  That we have two
   filesystems now that want it shows pretty much that fs-specific code
   is the wrong place.
 - get rid of the concept of a canoical path in kernelspace.  If userspace
   wants it they can't search the mount tab for the right st_dev to provide
   dmapi semantics.
 - clean up the whole ioctl API mess.  I think we'd mostly be done with
   a O_HSM option for open to avoid interactions with the callouts and some
   generic handle API.

