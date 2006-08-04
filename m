Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWHDN1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWHDN1S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWHDN1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:27:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59801 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161114AbWHDN1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:27:17 -0400
Message-ID: <44D34AE5.502@sgi.com>
Date: Fri, 04 Aug 2006 15:25:57 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       tytso@mit.edu, rdunlap@xenotime.net, davej@redhat.com,
       chuckw@quantumlinux.com, reviews@ml.cw.f00f.org,
       alan@lxorguk.ukuu.org.uk, jes@trained-monkey.org
Subject: Re: [patch 12/23] invalidate_bdev() speedup
References: <20060804053258.391158155@quad.kroah.org>	 <20060804053942.GM769@kroah.com> <20060804085012.GA20026@infradead.org>	 <20060804020422.09b32164.akpm@osdl.org> <1154696949.2996.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1154696949.2996.25.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2006-08-04 at 02:04 -0700, Andrew Morton wrote:
>> Apparently that regular IPI storm is causing the SGI machines some
>> significant problems. 
> 
> a tiny performance drop :) If that meets the stable policy.. open
> question :)

It's visible on any SMP machine, but the more CPUs the worse it gets,
this isn't an SGI only problem. Whether the performance degredation
warrants putting it into stable is another question ....

>> It's not the biggest problem we've ever had, but if this patch is wrong,
>> the pagecache/buffer_head layer is utterly busted.  And it isn't.
> 
> are you sure?
> 
> +       struct address_space *mapping = bdev->bd_inode->i_mapping;
> +
> +       if (mapping->nrpages == 0)
> +               return;
> +
>         invalidate_bh_lrus();
> 
> what happens if a bdev used to have pagecache and at some point stops
> having that due to page reclaim... will that page reclaim call
> invalidate_bh_lrus() ? If not, who will ? If the answer is "nobody", is
> that really the right answer?

Well what happens if the pagecache doesn't remove the page from the lru
on reclaim and we do a lookup for it later? I'm not an expert in the LRU
usage or page reclaim, but it seems to me we could end up with a stable
reference if that was the case.

Cheers,
Jes

