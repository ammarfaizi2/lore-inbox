Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVBUJFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVBUJFA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 04:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVBUJE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 04:04:59 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:59559 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261927AbVBUJEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 04:04:41 -0500
Message-ID: <4219A422.5010809@yahoo.com.au>
Date: Mon, 21 Feb 2005 20:04:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andi Kleen <ak@suse.de>, davem@davemloft.net,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] page table iterators
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>	 <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>	 <20050217230342.GA3115@wotan.suse.de>	 <20050217153031.011f873f.davem@davemloft.net>	 <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>	 <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>	 <20050220224022.5b5c4a09.akpm@osdl.org> <1108969783.5411.6.camel@gaston> <42199727.2010309@yahoo.com.au>
In-Reply-To: <42199727.2010309@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Haven't yet pulled out a pre-4-level kernel to see how 3-level compares
> I guess I'll do that now.
> 

Close.
Before 4level: 119.5us, after folded walkers: 132.8us

I think most of this is now coming from clear_page_range, rather
than the actual traversing of the page tables (because they should
be completely folded by now):

before:
   4089 total                                      0.0017
    753 kmap_atomic                                4.7358
    682 do_wp_page                                 0.6713
    680 do_page_fault                              0.4561
    261 zap_pte_range                              0.3625
    176 copy_page_range                            0.2133
    159 pte_alloc_one                              1.5743
    145 clear_page_tables                          0.4866

after:
   4307 total                                      0.0018
    676 kmap_atomic                                4.2516
    665 do_page_fault                              0.4472
    615 do_wp_page                                 0.6225
    550 clear_page_range                           0.9982
    262 zap_pte_range                              0.4870

I think the additional work done by clear_page_range (versus
clear_page_tables) justifies the extra cost, even for 3-level
architectures.

