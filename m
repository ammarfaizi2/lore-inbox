Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWIPWMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWIPWMP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 18:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWIPWMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 18:12:15 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:3761 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1751832AbWIPWMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 18:12:13 -0400
Date: Sat, 16 Sep 2006 23:33:56 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Cc: linux-kernel@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
       sparclinux@vger.kernel.org, davem@davemloft.net, aeb@cwi.nl
Subject: Re: fix 2.4.33.3 / sun partition size
Message-ID: <20060916213356.GA1420@1wt.eu>
References: <DA6197CAE190A847B662079EF7631C06015692C6@OEKAW2EXVS03.hbi.ad.harman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015692C6@OEKAW2EXVS03.hbi.ad.harman.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Andries CCed since he's the partition maintainer]

Hi Dieter,

On Wed, Sep 13, 2006 at 07:40:26AM +0200, Jurzitza, Dieter wrote:
> Dear Willy,
> one final thougth here: ist there any real reason to *not* make
> add_gd_partition (struct gendisk, int minor, unsigned long start, unsigned long size){...}
> (see fs/partitions/check.c)
> as:
> 
> - within add_gd_partition the two values start and size are assigned to a field of type unsigned long,
> - we both agree that there is no reason to use signed ints in this case,
> - any byte size conversion issue would be covered by the fact that it does not hurt assigning too small numbers to oversized ones.
> 
> Just my two cents here ...

I agree with your analysis here. I've checked the code right now, and using signed
ints in add_gd_partition() makes no sense to me as the hd_struct uses unsigned longs.
So a cast is performed within add_gd_partition() anyway.

We should make add_gd_partition() accept unsigned longs so that only its users will
have to cast to unsigned long if needed, and this way it will be easier to track
invalid signedness use.

I've quickly checked if 2.6 needs a fix, but 2.6 declares add_partition() with
sector_t values which are unsigned longs. So 2.6 is safe right now. I will add
the fix and check at least on x86 and sparc64 that I do not see any regression
nor warnings (I don't have 1TB to check larger partitions!).

Thanks,
Willy

