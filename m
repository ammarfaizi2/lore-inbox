Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVFGOVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVFGOVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVFGOVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:21:18 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:44186 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261876AbVFGOVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:21:05 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,179,1114984800"; 
   d="scan'208"; a="10543370:sNHT29722276"
Message-ID: <42A5AD4A.6080100@fujitsu-siemens.com>
Date: Tue, 07 Jun 2005 16:20:58 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC for 2.6: avoid OOM at bounce buffer storm
References: <42A07BAA.4050303@fujitsu-siemens.com> <20050603160629.2acc4558.akpm@osdl.org>
In-Reply-To: <20050603160629.2acc4558.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> It might be neater to do this at the mempool level: that way we're adding
> general-purpose infrastructure and then just using it, rather than
> special-casing the bounce code.
> 
> See below a (n untested) patch against the latest devel tree.  It won't be
> stunningly scalable on big SMP, but the overhead of bouncing will probably
> hide that.

I don't quite understand your patch. You introduce a "limit" field but 
you never actually use it. You also don't count the allocated pages.
Are you using the semaphore for slowing things down on purpose?

(Note that the problem is not in the mempool allocation itself but in 
the "normal" allocation path (page_pool_alloc() -> alloc_page()))

Anyway, I think could figure out your patch but with 2.6.12-rc5-mm2 I 
couldn't reproduce the problem any more. It appears to run much more 
smoothly now, perhaps because wakeup_bdflush() isn't called any more. 
Are you still interested in more data?

>>I couldn't get 2.6.12-rc5 to run on my system.
> 
> Ow.  Could you please investigate further?  Any boot messages for us to
> see?  it's quite possibly some missing config option..

It turned out to be a problem with Red Hat's nash that didn't check the 
returned pid in it's wait4() call and thus ended up insmod'ing mutliple 
modules simultaneously, leading to "Unkown symbol" errors. Yuck, it took 
me a day figure that out.

That bug is fixed in redhat's "mkinitrd" package 4.2.0.3-1 and later, 
but that package is currently only in Fedora's "Development" tree.

Thanks,
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
