Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUGOBzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUGOBzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 21:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUGOBzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 21:55:02 -0400
Received: from holomorphy.com ([207.189.100.168]:22433 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265055AbUGOByl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 21:54:41 -0400
Date: Wed, 14 Jul 2004 18:54:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Zaitsev <peter@mysql.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040715015431.GF3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
	andrea@suse.de, linux-kernel@vger.kernel.org
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040714154427.14234822.akpm@osdl.org> <1089851451.15336.3962.camel@abyss.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089851451.15336.3962.camel@abyss.home>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 15:44, Andrew Morton wrote:
>> If the kernel has no swap there is nothing it can do with an anonymous page
>> (ie: the thing whcih malloc() gives you).  It is effectively pinned memory,
>> because there's nowhere we can write it to get rid of it.

On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> Why can't it be moved to other zone if there is a lot of place where ?
> In general I was not pushing system in some kind of stress mode - There
> was still a lot of cache memory available. Why it could not be instead
> shrunk to accommodate allocation ? 

The only method the kernel now has to relocate userspace memory is IO.
When mlocked, or if anonymous when there's no swap, it's pinned.


On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> As I understand in my case with 4G there is  Normal zone and HighMem
> zone where "user" anonymous memory can be located in any of these zones.
> Is this observation correct ? 

Yes.


On Wed, 2004-07-14 at 15:44, Andrew Morton wrote:
>> If you end up pinning all of your ZONE_NORMAL pages with anonymous memory,
>> further GFP_KERNEL allocation attempts will go oom.

On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> Aha I see. So user level memory allocations can't cause OOM only kernel
> level allocations can ?   In this case why do not you have some reserved
> amount of space for these types of allocations by default ? 

Userspace allocations can also trigger OOM, it's merely that in this
case only allocations restricted to ZONE_NORMAL or below, e.g. kernel
allocations, are affected. Your memory pressure is restricted to one zone.


On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> In this case I also do not understand how swap space helps here ? If you
> can't move page to over zone or shrink cache because of allocation type
> how it happens you can however perform page swap ? 

In order to relocate a userspace page, the kernel performs IO to write
the page to some backing store, then lazily faults it back in later. When
the userspace page lacks a backing store, e.g. anonymous pages on
swapless systems, Linux does not now understand how to relocate them.


-- wli
