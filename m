Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWDIXYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWDIXYH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 19:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWDIXYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 19:24:07 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:39377 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750826AbWDIXYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 19:24:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: shrink_all_memory tweaks (was: Re: Userland swsusp failure (mm-related))
Date: Mon, 10 Apr 2006 09:23:23 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Fabio Comolli <fabio.comolli@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <200604090924.04951.kernel@kolivas.org> <200604092236.45768.rjw@sisk.pl>
In-Reply-To: <200604092236.45768.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604100923.24768.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 April 2006 06:36, Rafael J. Wysocki wrote:
> Still I've been doing a crash course in mm internals recently and I can say
> a bit more about your patch now. ;-)

Great.
>
> First, I agree that using balance_pgdat() for freeing memory by swsusp is
> overkill, so the removal of its second argument seems to be a good idea to
> me.  However, I'd rather avoid modifying struct scan_control and
> shrink_zone() and reimplement the shrink_zone()'s logic directly in
> shrink_all_memory(), with some modifications (eg. we can explicitly avoid
> shrinking of the active list until we decide it's worth it) -- or we can
> define a separate function for this purpose.

I was trying to reuse as much code as possible.

> Second, there are a couple of details I'd do in a different way.  For
> example I think we should call shrink_slab() with the non-zero first
> argument (otherwise it'll use SWAP_CLUSTER_MAX)

Sounds good.

> and instead of setting 
> zone->prev_priority to 0 I'd set vm_swappiness to 100 temporarily
> (or maybe l'd left it to the user to set swappiness before suspend?).

Probably can't rely on just the user setting. Setting priority to 0 is 
explicit and overrides any swappiness setting which is a tunable. Priority 
will recover by itself unlike swappiness which needs to be set and reset.

> Also I think we can try to avoid slab shrinking until we start to shrink
> the active zone or IOW until we can't get any more pages from the inactive
> list alone.

I tried that and it didn't shrink enough, but then that's because of the 
SWAP_CLUSTER_MAX limit you mentioned above. But slab can be massive if you do 
for example a lot of 'find's and shrinking slab doesn't affect the user 
experence as much as shrinking the active/inactive lists.

> If you don't mind, I'll try to rework your patch a bit in accordance with
> the above remarks in the next couple of days.

By all means :)

-- 
-ck
