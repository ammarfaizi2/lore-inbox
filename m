Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318304AbSHKOsW>; Sun, 11 Aug 2002 10:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318308AbSHKOsW>; Sun, 11 Aug 2002 10:48:22 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:49866 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318304AbSHKOsW>; Sun, 11 Aug 2002 10:48:22 -0400
Date: Sun, 11 Aug 2002 15:51:22 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 15/21] multiple pte pointers per pte_chain
Message-ID: <20020811155122.B2513@kushida.apsleyroad.org>
References: <3D5614BC.EB0629B6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D5614BC.EB0629B6@zip.com.au>; from akpm@zip.com.au on Sun, Aug 11, 2002 at 12:39:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Pages which are mapped by only a single process continue to not have a
> pte_chain.  The pointer in struct page points directly at the mapping
> pte (a "PageDirect" pte pointer).  Once the page is shared a pte_chain
> is allocated and both the new and old pte pointers are moved into it.

May I suggest that the final pte in the list of ptes for a page is
_always_ pointed to directly?

In other words, a pte_chain looks like this:

      struct page -> pte_chain -> pte_chain -> pte_chain -> pte
                          |           |            |
                          v           v            v
                          pte         pte          pte

pte_chain vs. pte would be distinguished by the least significant bit of
the pointer, or something similar.

This adds a special case in the list walker -- on the other hand, it
also removes two special cases ("PageDirect" is no longer required, and
there is no 0 to indicate end-of-list).  But the best part is: it saves
more memory, has no cache line cost, and reduces the amount of work
needed to share a page :-)

-- Jamie

