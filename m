Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319375AbSH3DHy>; Thu, 29 Aug 2002 23:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319402AbSH3DHw>; Thu, 29 Aug 2002 23:07:52 -0400
Received: from holomorphy.com ([66.224.33.161]:32390 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319375AbSH3DHv>;
	Thu, 29 Aug 2002 23:07:51 -0400
Date: Thu, 29 Aug 2002 20:12:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com
Subject: Re: statm_pgd_range() sucks!
Message-ID: <20020830031208.GK888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, riel@surriel.com
References: <20020830015814.GN18114@holomorphy.com> <3D6EDDC0.F9ADC015@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D6EDDC0.F9ADC015@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> (1) shared, lib, text, & total are now reported as what's mapped
>>         instead of what's resident. This actually fixes two bugs:

On Thu, Aug 29, 2002 at 07:51:44PM -0700, Andrew Morton wrote:
> hmm.  Personally, I've never believed, or even bothered to try to
> understand what those columns are measuring.  Does anyone actually
> find them useful for anything?  If so, what are they being used for?
> What info do we really, actually want to know?

I'm basically looking for VSZ, RSS, %cpu, & pid -- after that I don't
care. top(1) examines a lot more than it feeds into the display, for
reasons unknown. In principle, there are ways of recovering the other
bits that seem too complex to be worthy of doing:

(1) update a mm->shared counter on every PG_direct break/collapse
(2) walk the pte_chain updating mm->dirty for each pte every time
	set_page_dirty() or ClearPageDirty() is done
(3) binfmt helpers + arch specific helpers for the binfmt helpers for
	keeping count of up mm->lib

(1) doesn't sound good because pte_chain stuff is already a big hotspot
(2) doesn't sound good for the same reason
(3) sounds like a portability nightmare

i.e. Not worth doing. esp. for stats of which only (1) is used/usable,
and the value of (1) in question (IMHO) due to the longstanding
misreporting.


On Thu, Aug 29, 2002 at 07:51:44PM -0700, Andrew Morton wrote:
> Reporting the size of the vma is really inaccurate for many situations, 
> and the info which you're showing here can be generated from
> /proc/pid/maps.  And it would be nice to get something useful out of this.
> Would it be hard to add an `nr_pages' occupancy counter to vm_area_struct?
> Go and add all those up?

If top(1) understood/used /proc/$PID/maps that'd be fine. It's more or
less a "vaguely compatible placeholder" aside from RSS, and there's
some kind of burden of vague compatibility for /proc/ stuff.

Per-vma RSS is trivial, just less self-contained. Everywhere the
mm->rss is touched, the vma to account that to is also known, except
for put_dirty_page(), and that can be repaired as its caller knows.



Cheers,
Bill
