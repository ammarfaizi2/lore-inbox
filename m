Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUDHPNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUDHPNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:13:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7334
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261867AbUDHPMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:12:54 -0400
Date: Thu, 8 Apr 2004 17:12:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rmap: page_mapping barrier
Message-ID: <20040408151245.GA31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081409240.7010-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404081409240.7010-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 02:22:29PM +0100, Hugh Dickins wrote:
> My page_mapping(page) says PageAnon(page)? NULL: page->mapping;
> I've just realized, looking again at sync_page but it goes way
> beyond it, that we need smp barriers of some kind somewhere,
> don't we?  That is, we cannot just write the address of one of
> our non-address_space structures into page->mapping, without
> being very careful that others will see the PageAnon and treat
> it as NULL.  There are places all over using page_mapping(page)
> while another cpu might be right in page_add_rmap.  I go very
> mushy when it comes to barriers, you understand them better
> than most, any idea what we need to do in page_mapping(page),
> and when setting and clearing PageAnon?

could you elaborate those many places that execute page_mapping while
the other cpu does page_add_rmap or page_remove_rmap?

If the VM does a page_mapping in the pagecache layer in my tree, that
means we already executed page_add_rmap long before calling
__add_to_page_cache, the __add_to_page_cache/__remove_from_page_cache
spinlocks are enough to serialize PageAnon. That covers sync_page and
the rest of the pagecache layer.

There's just one place that I'm wondering about and it's page_mapping in
memory.c but it only changes a mark_page_accessed so I don't see any
trouble whatever happens there (mark_page_accessed can be run on any
random page anytime and it cannot do any harm). I believe we can live
with that race just fine, it's controlled by mark_page_accessed
internally by checking PageLru inside the zone->lru_lock.

Please elaborate which is the place that can run at the same time of
page_add_rmap/page_remove_rmap (I mean of the _first_ or _last_
page_add_rmap/page_remove_rmap, the ones that are allowed toggle the
PageAnon bitflag, all the nested ones are harmless).
