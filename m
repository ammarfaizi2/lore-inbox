Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVCCIX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVCCIX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVCCIXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:23:25 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:6564 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261591AbVCCIV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:21:58 -0500
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch - 2.6.11-rc5-mm1] genalloc - general purpose allocator
References: <16934.4191.474769.320391@jaguar.mkp.net>
	<16934.5385.841758.628631@napali.hpl.hp.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 03 Mar 2005 03:21:56 -0500
In-Reply-To: <16934.5385.841758.628631@napali.hpl.hp.com>
Message-ID: <yq03bvdf8bf.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

David> At the risk of asking the obvious: what's preventing genalloc
David> to be implemented in terms of mempool?

David,

Taking another look at mempool, there's several reasons why mempool
isn't well suited for this job.

Basically for the uncached page case we want to first pull out all the
spill pages in the lower granules[1] and only after those have been
used, do we want to start converting pages from cached to uncached.

mempool on the other hand will first try and call the user provided
allocation function and only if that fails try and take memory from
the pool, this will force us to convert pages from cached to uncached
if we don't have to.

The other issue is that mempool isn't designed to handle the case
where you do not want to hand the memory back to the system using the
user provided free() function, somehing which we can't even do for the
spill pages and converting the normal pages back is a nightmare since
you have to wait for a full granule to reappear.

Last, mempool interacts quite a lot with the vm, kicking bdflush if it
is unable to allocate memory which will not have any effect for these
kinds of pages anyway.

One could probably do this via mempool, but it would basically require
one to put another object allocator below mempool which really makes
the whole exercise pointless as this could just as well be done
standalone ... ie. genalloc.

Cheers,
Jes

[1]: For those who are interested, on ia64 one has to convert a full
granule, 16MB, at a time in order to avoid data corruption due to the
CPU might be doing speculative loads within a full granule.
