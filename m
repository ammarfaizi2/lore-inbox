Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264780AbUDWL2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbUDWL2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 07:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUDWL2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 07:28:17 -0400
Received: from holomorphy.com ([207.189.100.168]:37288 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264780AbUDWL2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 07:28:16 -0400
Date: Fri, 23 Apr 2004 04:28:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, david@gibson.dropbear.id.au,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-ID: <20040423112812.GH743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, david@gibson.dropbear.id.au,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040423081856.GJ9243@zax> <20040423013437.1f2b8fc6.akpm@osdl.org> <20040423102824.GF743@holomorphy.com> <20040423033522.03ab14fc.akpm@osdl.org> <20040423104744.GG743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423104744.GG743@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 03:35:22AM -0700, Andrew Morton wrote:
>> Sure.
>> This of course duplicates huge_page_release(), which can be killed off.

On Fri, Apr 23, 2004 at 03:47:44AM -0700, William Lee Irwin III wrote:
> Ah, but mm/hugetlb.c is putting the destructor in head->lru.prev not
> head[1].mapping; fix below along with nuking  huge_page_release().

I just noticed a general problem where ->mapping is often referred to
naked and so either needs to be filled in for the base pages of the
superpage or the examiners need to be referred to the head of the superpage.
Likewise with ->index, which is apparently now used to hold the order.
In general, if they're superpage properties, either the examiners must
be referred to the head of the superpage, or (wastefully) the values must
be replicated across the base pages. The current scheme to prevent radix
tree deadlocks and other nastinesses with multiple insertions (e.g.
inserting an entry into the radix tree for each base page, which I've
seen naive abuses of shit themselves several times before) reduces the
resolution of the pagecache indices, which is problematic in various
ways with respect to finding the right base page without updating
excessive numbers of callers. The reason why this is less of a problem
than it sounds like is that the base page lookups usually go through
pagetables, which effectively act either as radix trees with an
insertion for each base page (normal cpus) or radix trees with low-
resolution indices with procedural API's to recover offsets into the
superpage and the proper base page (i386, ppc64).

I'll be off the net all weekend, so hopefully the interested parties can
use this info to resolve the remainder of the hugetlb put_page() issues.
The work here is just cleaning up self-inconsistencies so it's not hard.


-- wli
