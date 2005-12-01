Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVLAMD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVLAMD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVLAMD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:03:57 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:30183 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932166AbVLAMD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:03:57 -0500
Date: Thu, 1 Dec 2005 20:11:01 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, christoph@lameter.com, riel@redhat.com,
       a.p.zijlstra@chello.nl, npiggin@suse.de, andrea@suse.de,
       marcelo.tosatti@cyclades.com, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051201121101.GB6011@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
	npiggin@suse.de, andrea@suse.de, marcelo.tosatti@cyclades.com,
	magnus.damm@gmail.com
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201023714.612f0bbf.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 02:37:14AM -0800, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> >  The zone aging rates are currently imbalanced,
> 
> ZONE_DMA is out of whack.  It shouldn't be, and I'm not aware of anyone
> getting in and working out why.  I certainly wouldn't want to go and add
> all this stuff without having a good understanding of _why_ it's out of
> whack.  Perhaps it's just some silly bug, like the thing I pointed at in
> the previous email.

Yep, my rule is that if ever the DMA zone is reclaimed for watermark, it will
be running wild ;) So I leave it out by setting classzone_idx=0, and let the
age balancing code to catch it up. This scheme works fine: tested to be OK from
64M to 2G memory.

> > the gap can be as large as 3 times,
> 
> What's the testcase?
> 
> > which can severely damage read-ahead requests and shorten their
> >  effective life time.
> 
> Have you any performance numbers for this?

That's months ago, if I remember it right, the number of concurrent readers the
adaptive read-ahead code can handle without much thrashing was raised from ~100
to 800 with the balancing work.

This is my original announce back then:

    The page aging problem showed up when I was testing many slow reads with
    limited memory. Pages in the DMA zone were found out to be aged about 3
    times faster than that of Normal zone in systems with 64-512M memory.
    That is a BIG threat to the read-ahead pages. So I added some code to
    make the aging rates synchronized. You can see the effect by running:
    $ tar c / | cat > /dev/null &
    $ watch -n1 'grep "age " /proc/zoneinfo'
    There are still some extra DMA scans in the direct page reclaim path.
    It tend to happen in large memory system and is therefore not a big
    problem.

And here is some numbers collected by Magnus Damm:
http://lkml.org/lkml/2005/10/25/50

Good night!
Wu
