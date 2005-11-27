Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVK0Vm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVK0Vm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 16:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVK0Vm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 16:42:26 -0500
Received: from hera.kernel.org ([140.211.167.34]:661 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751098AbVK0VmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 16:42:25 -0500
Date: Sun, 27 Nov 2005 14:02:07 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, Bharata B Rao <bharata@in.ibm.com>
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051127160207.GE21383@logos.cnet>
References: <20051123010122.GA7573@fi.muni.cz> <4383D1CC.4050407@yahoo.com.au> <20051123051358.GB7573@fi.muni.cz> <20051123131417.GH24091@fi.muni.cz> <20051123110241.528a0b37.akpm@osdl.org> <20051123202438.GE28142@fi.muni.cz> <20051123123531.470fc804.akpm@osdl.org> <20051124083141.GJ28142@fi.muni.cz> <20051127084231.GC20701@logos.cnet> <20051127203924.GE27805@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051127203924.GE27805@fi.muni.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

> 	The task that probably triggers this problem is a cron job
> doing full-text indexing of mailing list archive, so it accesses lots
> of small files, and then recreates the inverted index, which is one big
> file. So maybe inode cache shrinking or something may be the problem there.
> However, the cron job does an incremental reindexing only, so I think it
> reads less than 100 files per each run.
> : 
> : Maybe you should also try profile/oprofile during the kswapd peeks?
> : 
> 	Do you have any details on it? I can of course RTFdocs of oprofile,
> but should I try to catch something special?

It does seem to scan SLABs intensively:

pgscan_kswapd_high 0
pgscan_kswapd_normal 940269891
pgscan_kswapd_dma 0
pgscan_direct_high 0
pgscan_direct_normal 13837131
pgscan_direct_dma 0
pginodesteal 11216563
slabs_scanned 160160350534400
kswapd_steal 909876526
kswapd_inodesteal 305039060
pageoutrun 30139677
allocstall 4067783

If you take the amont of scanned slabs and divide by the sum of
direct/kswapd pagescans:

160160350534400 / (940269891+13837131) = 167864

Which means that for each page scanned about 168000 slab entries are
scanned. Does not look very good.

Other than the profiling can you please also try Bharata's
shrinkable slab cache statistics patch?

http://lkml.org/lkml/2005/10/26/1


