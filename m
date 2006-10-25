Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWJYUY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWJYUY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWJYUY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:24:29 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:12247 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S965230AbWJYUY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:24:28 -0400
Date: Wed, 25 Oct 2006 16:21:55 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: David Howells <dhowells@redhat.com>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching
Message-ID: <20061025202155.GB3854@filer.fsl.cs.sunysb.edu>
References: <16969.1161771256@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16969.1161771256@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 11:14:16AM +0100, David Howells wrote:
..
> Currently, CacheFiles temporarily changes fsuid and fsgid to 0 whilst doing its
> own pathwalk through the cache and whilst creating files and directories in the
> cache.  This allows it to deal with DAC security directly.  All the directories
> it creates are given permissions mask 0700 and all files 0000.

Unionfs used to do the same thing, until we decided that it was better to do
it some other way. (We went with a work queue approach.)

Hrm. How do you do DAC checks if you don't copy over the permissions without
alteration?

I'm wondering, why don't just you duplicate all the attributes of the files
(including xattrs)? That would take care of most if not all the DAC/MAC
issues, no?

> I can see a few ways to deal with this:
> 
>  (1) Do all the cache operations in their own thread (sort of like knfsd).
 
In our case it works well, however we have only very specific times when we
need to use the work queue, so the performance hit doesn't hurt us as much
as it would hurt you - I'm assuming you'd be using the thread for a sizable
portion of calls you get.
 
>  (2) Add further security ops for the caching code to call.  These might be of
>      use elsewhere in the kernel.  These would set cache-specific security
>      labels and check for them.

I'm thinking that it would be nice to combine the caching related security
code with those for stackable filesystems. I realize that there may not
really be many things that need to have LSM hooks, but stackable filesystems
should be something to keep in mind now that ecryptfs is in (and hopefully
Unionfs will follow shortly :) ). The SELinux guys would probably know
what's needed.

>  (3) Add a flag or something to current to override the normal security on the
>      basis that it should be using the cache's security rather than the
>      process's security.

Umm...this sounds little bit too hacky (and a fair amount of code would have
to get changed.) I'd prefer a more general solution that applies to more
than just caching.
 
Josef "Jeff" Sipek.

-- 
*NOTE: This message is ROT-13 encrypted twice for extra protection*
