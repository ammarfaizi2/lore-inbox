Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423057AbWJZJ5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423057AbWJZJ5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423078AbWJZJ5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:57:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59360 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423057AbWJZJ5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:57:13 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061025202155.GB3854@filer.fsl.cs.sunysb.edu> 
References: <20061025202155.GB3854@filer.fsl.cs.sunysb.edu>  <16969.1161771256@redhat.com> 
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 10:56:08 +0100
Message-ID: <7864.1161856568@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:

> Hrm. How do you do DAC checks if you don't copy over the permissions without
> alteration?

You have to remember there are two filesystem layers involved.  NFS or other
netfs does the DAC, MAC, whatever checks to see whether the user can access a
file.  NFS then asks the cache to back the netfs file and the cache creates a
file in the local filesystem to do that.

The cache file doesn't need the DAC/MAC/whatever attributes applied to the
netfs file, and, in fact, may not be able to support what the netfs deals
with.

> I'm wondering, why don't just you duplicate all the attributes of the files
> (including xattrs)? That would take care of most if not all the DAC/MAC
> issues, no?

You're forgetting that the userspace cache manager daemon still has to access
the cache.

> >  (1) Do all the cache operations in their own thread (sort of like knfsd).
>  
> In our case it works well, however we have only very specific times when we
> need to use the work queue, so the performance hit doesn't hurt us as much
> as it would hurt you - I'm assuming you'd be using the thread for a sizable
> portion of calls you get.

I'm not sure exactly.  Actually, I could probably deal with read/write ops
inline - though I don't have a file struct to carry a security context - but
getting and releasing inodes would certainly wind up being farmed off.
Consider the automounter releasing an NFS share that's been heavily used...

> I'm thinking that it would be nice to combine the caching related security
> code with those for stackable filesystems.

That's fine by me, though I want the security on a cache file to be different
to that on the netfs file it's backing.

David
