Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266678AbUHBSD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266678AbUHBSD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUHBSD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:03:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:21679 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266678AbUHBSDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:03:05 -0400
Message-ID: <410E81C3.2070804@us.ibm.com>
Date: Mon, 02 Aug 2004 11:02:43 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@yahoo.com>
CC: lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com>
In-Reply-To: <20040802155312.56128.qmail@web14923.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
>>4) DRM code reorganization. There were several requests to reorganize
>>DRM to more closely follow the Linux kernel guidelines. This
>>reorganization should occur before new features are added.
> 
> What should be the model for reorganizing DRM? An obvious change is
> eliminate the naming macros. 
> 
> Another is to change to a personality with helper library model like
> fbdev has. All of the common DRM code would go into a library module.
> Each card would then have a small device specific module which depends
> on the library module for common code. 

This would be *very* non-trivial to do.  Doing the DRM like this has 
come up probably a dozen times (or more) over the last 3 years.  The 
problem is that each driver has different needs based on hardware 
functionality.  We've managed to classify these needs into a few groups, 
and drivers can select which functionality they need via a set of 
defines.  These per-driver defines determine what code gets compiled 
into the different routines (as well as which routines even get built).

Trying to make this into a library would just be a mess.  It would 
either break cases where multiple DRMs are built (or loaded) into the 
kernel or result in a *ton* of unused, nearly duplicate routines being 
built into the library.

If this is something that we really want to pursue, someone needs to dig 
in and figure out:

1. How much / which code can be "trivially" shared?
2. How much / which code can be shared with very little work?
3. How much / which code would we rather get a root-canal than try to 
make shared?

The concern has been that, by making a "generic" library layer, we'd 
actually make the DRM more difficult to maintain.  Nobody has really had 
the time to do the research required to either substantiate or refute 
those claims.  Based on the little experience I have in the DRM, I tend 
to believe them.

> ian: what about splitting the current memory management code into a
> module that can be swapped for your new version?

AFAIK, the only drivers that have any sort of in-kernel memory manager 
are the radeon (only used by the R200 driver) and i830.  That memory 
manager only exists to support an NV_vertex_array_range-like extension 
that some Tungsten customers needed.  I don't think there would be any 
benefit to making that swappable.

Once the new memory manager is in, 80% (or more) of the code will be in 
user-mode anyway.  The code that will be in the kernel should be generic 
enough to be completely sharable (i.e., in a generic DRM library).

> Are other structure changes needed?
