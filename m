Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVHDNXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVHDNXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVHDNXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:23:40 -0400
Received: from ns1.suse.de ([195.135.220.2]:21893 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262525AbVHDNXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:23:39 -0400
Date: Thu, 4 Aug 2005 15:23:38 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>, cr@sap.com, linux-mm@kvack.org
Subject: Re: Getting rid of SHMMAX/SHMALL ?
Message-ID: <20050804132338.GT8266@wotan.suse.de>
References: <20050804113941.GP8266@wotan.suse.de> <Pine.LNX.4.61.0508041409540.3500@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508041409540.3500@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 02:19:21PM +0100, Hugh Dickins wrote:
> On Thu, 4 Aug 2005, Andi Kleen wrote:
> 
> > I noticed that even 64bit architectures have a ridiculously low 
> > max limit on shared memory segments by default:
> > 
> > #define SHMMAX 0x2000000                 /* max shared seg size (bytes) */
> > #define SHMMNI 4096                      /* max num of segs system wide */
> > #define SHMALL (SHMMAX/PAGE_SIZE*(SHMMNI/16)) /* max shm system wide (pages) */
> > 
> > Even on 32bit architectures it is far too small and doesn't
> > make much sense. Does anybody remember why we even have this limit?
> 
> To be like the UNIXes.

Ok, no other more fundamental reason  ? :) 
I cannot think of any at least.

> 
> > IMHO per process shm mappings should just be controlled by the normal
> > process and global mappings with the same heuristics as tmpfs
> > (by default max memory / 2 or more if shmfs is mounted with more)
> > Actually I suspect databases will usually want to use more 
> > so it might even make sense to support max memory - 1/8*max_memory
> > 
> > I would propose to get rid of of shmmax completely
> > and only keep the old shmall sysctl for compatibility.
> 
> Anton proposed raising the limits last autumn, but I was a bit
> discouraging back then, having noticed that even Solaris 9 was more
> restrictive than Linux.  They seem to be ancient traditional limits
> which everyone knows must be raised to get real work done.
> 
> It's possible that if we raise the limits, installation
> of this or that application will then lower them again?

I think we should just get rid of the per process limit and keep
the global limit, but make it auto tuning based on available memory.
That is still not very nice because that would likely keep it < available 
memory/2, but I suspect databases usually want more than that. So
I would even make it bigger than tmpfs for reasonably big machines.
Let's say

if (main memory >= 1GB)
	maxmem = main memory - main memory/8 
else  
	maxmem = main memory / 2

possible increase the 4096 segments limit too, it seems quite low,
or also auto tune based on memory.

One possible problem with getting rid of /proc/sys/kernel/shmmni 
would be that some programs might read it and fail if it's not available. i
So I would probably keep it read only but always return LONG_MAX.

> 
> I don't think my opinion is worth much on this:
> what would the distro tuners like to see there?

suse has shipped larger default limits for a long time.
And all the databases and some other software documents increasing these
values.

-Andi
