Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWCVP6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWCVP6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWCVP6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:58:10 -0500
Received: from mx.pathscale.com ([64.160.42.68]:30375 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750998AbWCVP6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:58:08 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603212316001.16342@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
	 <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	 <1142523201.25297.56.camel@camp4.serpentine.com>
	 <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
	 <1142538765.10950.16.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
	 <1142974347.29199.87.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.61.0603212316001.16342@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 22 Mar 2006 07:58:08 -0800
Message-Id: <1143043088.17406.17.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 23:20 +0000, Hugh Dickins wrote:

> Please mail me your source (I guess as a patch against 2.6.15),
> and tomorrow I'll try to see if I can work out the leak; probably
> won't work out the BUG until you can send us the messages - thanks.

Thank you for the kind offer.  Before I send you anything, though, I
have some interesting information to report.

First of all, it turns out that the BUG I mentioned was reported against
the SLES10 2.6.16-rc6 kernel.  I haven't had a chance to chase it down
yet, but I'm going to have to, because...

...the driver actually works just fine under 2.6.16-final.  No memory
leaks, no funnies with page counting being wrong.

Under 2.6.15, what seems to be actually happening is that vmops->nopage
is being called on each page of a 32K compound page, driving the page
count from 1 (prior to any nopage calls) to 9.  By the time I get to my
cleanup code, the page count has gone from 9 to 8 (whereas under 2.6.16,
the page count has gone from 9 back to 1, where it belongs).  From this,
it seems fairly clear that the kernel isn't decrementing the use counts
correctly on compound pages in 2.6.15.

I think my next step, rather than boring you to tears with an
interminable slog through unfamiliar source code, is to try Linus's
suggestion from last week of just shooting nopage in the head, and
instead use remap_pfn_range in fops->mmap.  If the stars are aligned,
perhaps this will give me something that works on a wide variety of
kernels.

Thanks again,

	<b

