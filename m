Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUHAGVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUHAGVl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 02:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUHAGVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 02:21:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53185 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265224AbUHAGVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 02:21:39 -0400
Date: Sat, 31 Jul 2004 23:21:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-Id: <20040731232126.1901760b.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Zwane, William proposed:
> +	return min(NR_CPUS, find_first_bit(srcp->bits, nbits));

Could you check the kernel text size, for some NUMA config, before and
after adding these min() calls in first_cpu() and next_cpu().  These two
macros are critical to the for_*_cpu() macros.

When I tried it just now on an ia64 sn2_defconfig, NR_CPUS == 512, it
increased each for_*_cpu() loop about 28 bytes of text, for a kernel
text size increase of 1352 bytes (this is on a private kernel I have,
your results will vary).

> The following caused some fireworks whilst merging i386 cpu hotplug.
> any_online_cpu(0x2) returns 32 on i386 if we're forced to continue past
> the only set bit due to the additional find_first_bit in the
> find_next_bit i386 implementation.

Could you explain this a bit more?  What value of NR_CPUS were you
using -- if NR_CPUS == 32, then I'd _expect_ any_online_cpu() to return
32 if none of the bits provided it were online.  The way you phrase
this, it sure seems that you are hinting at a bug in the i386 implementation
of find_next_bit().  But I can't quite make out the code, nor what you're
saying, so I'm still confused.

A specific example might help -- NR_CPUS is this, what's online is that,
called "any_online_cpu()" with so-and-so, expected thus as a return, got
something else instead.

I'd hate to see a bug in i386 find_next_bit() left to stand, at the
expense of increasing sometimes fairly interesting code loops by 28
bytes of text each.  If that's what's happening here ... 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
