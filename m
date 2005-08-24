Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVHXMFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVHXMFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 08:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVHXMFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 08:05:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:5534 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750846AbVHXMFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 08:05:03 -0400
Date: Wed, 24 Aug 2005 05:04:54 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cpu_exclusive sched domains fix broke ppc64
Message-Id: <20050824050454.012f8af1.pj@sgi.com>
In-Reply-To: <17164.11361.437380.179789@cargo.ozlabs.ibm.com>
References: <17164.11361.437380.179789@cargo.ozlabs.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> I'm not sure what the best way to fix this is

Thank-you for reporting this.  Likely the best way to fix this for now,
since we are late in a release (Linus will probably want to wack me
upside the head for breaking his build ;) is to leave the
node_to_cpumask and for_each_cpu_mask exactly as they are, and have the
code that my cpu_exclusive sched domain patch added make a local copy
of the cpumask.

I just sent off a patch to do this - quite untested so far.

I am trying now to get fire up crosstools to verify the build.
But if you can get it to build anytime soon, let me know.  My
crosstools are rusty -- it might take me a bit to resuscitate them.

I also am not sure what is the best way to fix this detail with
node_to_cpumask and for_each_cpu_mask in the long term.  The choices I
see are:

 1) Leave it be - which makes it easy trip the build bug I hit,
    due to the different styles of node_to_cpumask, inline or
    macro, on different archs.

 2) Make node_to_cpumask a macro on all archs, though that
    makes it even easier than it is now to write code that
    appears to modify a local variable, but actually modifies
    some global array of the per-node cpumasks, which could
    lead to some juicy runtime bugs.

 3) Make node_to_cpumask an inline on all archs, though that might
    force a local stack copy of a cpumask in places that might
    be performance critical on arch's with big cpumasks.

 4) Perhaps some more subtle combination of macros/inlines
    can be all things to all arch's.

I'm not going to unravel the above tonight.

> it seems unfortunate that for_each_cpu_mask
> requires the mask to be an lvalue, but that isn't documented anywhere
> that I can see.

Are you saying that it's unfortunate that for_each_cpu_mask requires
an lvalue, or that it's unfortunate that this isn't documented?

Or both ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
