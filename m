Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUCCSiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 13:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUCCSiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 13:38:23 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12041
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262540AbUCCSiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 13:38:21 -0500
Date: Wed, 3 Mar 2004 19:39:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040303183901.GU4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random> <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]> <20040303165746.GO4922@dualathlon.random> <10500000.1078333658@[10.1.1.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10500000.1078333658@[10.1.1.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 11:07:39AM -0600, Dave McCracken wrote:
> 
> --On Wednesday, March 03, 2004 17:57:46 +0100 Andrea Arcangeli
> <andrea@suse.de> wrote:
> 
> >> There was talk at one point of moving the "unswappable" state down into 
> >> the struct page. Is that still realistic? It would seem rather more
> >> efficient, but I forget what problem we ran into with it.
> > 
> > that already exists and it's PG_reserved, but it's inefficient compared
> > to VM_RESERVED, since it forces the vm to check all ptes.
> 
> What we've actually discussed before was more along the lines of PG_locked
> to match VM_LOCKED, but the main idea was to be able to skip over
> ineligible pages without having ot look up their mappings during pageout.

I'm not very excited using PG_locked for that, that doesn't only mean
"unswappable", it means also that the page is under I/O (or uner some
other operation that needs serialization like unmapping the page) which
is quite a different concept from VM_LOCKED. a wait_on_page would
deadlock on such a PG_locked page, while wait_on_page on a page of a
mlocked vma doesn't normally deadlock.

But I see what you want to do here, and PG_reserved would be too much
for that since it changes the semantics for cow and free_pages, but
PG_locked doesn't look good enough either, the VM_LOCKED and PG_locked
concept is quite different, PG_reserved and VM_RESERVED is quite close
instead (except for the page->count accounting).
