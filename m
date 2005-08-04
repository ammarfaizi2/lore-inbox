Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVHDOYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVHDOYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVHDOW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:22:29 -0400
Received: from mail.zmailer.org ([62.78.96.67]:52871 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261728AbVHDOUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:20:42 -0400
Date: Thu, 4 Aug 2005 17:20:40 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>, cr@sap.com, linux-mm@kvack.org
Subject: Re: Getting rid of SHMMAX/SHMALL ?
Message-ID: <20050804142040.GB22165@mea-ext.zmailer.org>
References: <20050804113941.GP8266@wotan.suse.de> <Pine.LNX.4.61.0508041409540.3500@goblin.wat.veritas.com> <20050804132338.GT8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804132338.GT8266@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 03:23:38PM +0200, Andi Kleen wrote:
> On Thu, Aug 04, 2005 at 02:19:21PM +0100, Hugh Dickins wrote:
> > On Thu, 4 Aug 2005, Andi Kleen wrote:
> > 
> > > I noticed that even 64bit architectures have a ridiculously low 
> > > max limit on shared memory segments by default:
> > > 
> > > #define SHMMAX 0x2000000                 /* max shared seg size (bytes) */
> > > #define SHMMNI 4096                      /* max num of segs system wide */
> > > #define SHMALL (SHMMAX/PAGE_SIZE*(SHMMNI/16)) /* max shm system wide (pages) */
> > > 
> > > Even on 32bit architectures it is far too small and doesn't
> > > make much sense. Does anybody remember why we even have this limit?
> > 
> > To be like the UNIXes.
> 
> Ok, no other more fundamental reason  ? :) 
> I cannot think of any at least.

Those supply DEFAULT values for bootup time, and they can be
adjusted with sysctl.   Existence of the limits is good.
Their easy tunability (even easier than at Solaris, where
you tune them only with a reboot) is even better.

SHM resources are non-swappable, thus I would not by default
let user programs go and allocate very much SHM spaces at all.
Such is usually spelled as: "denial-of-service-attack"
For that reason I would not raise builtin defaults either.

...

> 
> I think we should just get rid of the per process limit and keep
> the global limit, but make it auto tuning based on available memory.

Err...  No thanks!   I would prefer to have even finer grained control
of how much SHM somebody can allocate.  For normal user the value
might be zero, but for users in a group "SHM1" there could be a level
of N MB, etc.  (Except that such mechanisms are rather complex...)

For dedicated servers there is no problem of letting there be single
global limit and its default value being in highish realms, but pick
any machine with multiple users running their own programs....
Consider all of them hostile (clueless can do as much damage
as any intentionally hostile.)

Mmm...  Apparently X (and/or other parts of the desktop) do ask for
a number of shared memory segments.  Default user allocation limit
can't be zero.


> That is still not very nice because that would likely keep it < available 
> memory/2, but I suspect databases usually want more than that. So
> I would even make it bigger than tmpfs for reasonably big machines.
> Let's say
> 
> if (main memory >= 1GB)
> 	maxmem = main memory - main memory/8 
> else  
> 	maxmem = main memory / 2
> 
> possible increase the 4096 segments limit too, it seems quite low,
> or also auto tune based on memory.
> 
> One possible problem with getting rid of /proc/sys/kernel/shmmni 
> would be that some programs might read it and fail if it's not available. i
> So I would probably keep it read only but always return LONG_MAX.
>  
> > I don't think my opinion is worth much on this:
> > what would the distro tuners like to see there?
> 
> suse has shipped larger default limits for a long time.
> And all the databases and some other software documents
> increasing these values.

If there were kernels that are optimized for database servers, then
the hard-wired defaults might be risen, of course.  On the other hand,
sysadmin knows for the best, and we have adjustment tools that don't
require kernel recompile, nor even reboot to be effective.


> -Andi

  /Matti Aarnio
