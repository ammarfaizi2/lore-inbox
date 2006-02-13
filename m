Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWBMKfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWBMKfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWBMKfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:35:40 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22238
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751745AbWBMKfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:35:17 -0500
Date: Mon, 13 Feb 2006 02:34:30 -0800 (PST)
Message-Id: <20060213.023430.126649129.davem@davemloft.net>
To: heiko.carstens@de.ibm.com
Cc: mingo@elte.hu, hare@suse.de, linux-kernel@vger.kernel.org
Subject: Re: calibrate_migration_costs takes ages on s390
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 13 Feb 2006 11:26:34 +0100

> The boot sequence on s390 sometimes takes ages and we spend a very long time
> (up to one or two minutes) in calibrate_migration_costs. The time spent there
> differs from boot to boot. Also the calculated costs differ a lot. I've seen
> differences by up to a factor of 15 (yes, factor not percent).
> Also I doubt that making these measurements make much sense on a completely
> virtualized architecture where you cannot tell how much cpu time you will
> get anyway.
> Is there any workaround or fix available so we can avoid seeing this?

Things are not as slow, but definitely slow on sparc64 too, and it's
also due to the migration cost calculations.

It's also really bad that it's using vmalloc(), for one thing, because
this thrashes the TLB (some of us have 64-entry software replaced
TLBs) and also because you can make no guarentees about how well the
backing physical pages will distribute into the L2 cache.

As a result, wildly different run-to-run results can be expected
particularly for systems with 1-way or 2-way set assosciative L2
caches, which are common on sparc64.  I don't know about s390.

I think the migration cost calculator is way overboard and needs to be
toned down a little bit.
