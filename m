Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269452AbUIZAd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269452AbUIZAd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269453AbUIZAd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:33:26 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:59553 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S269452AbUIZAbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:31:49 -0400
Date: Sun, 26 Sep 2004 02:31:20 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rik van Riel <riel@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte must be written in asm
Message-ID: <20040926003120.GQ3309@dualathlon.random>
References: <20040925155404.GL3309@dualathlon.random> <Pine.LNX.4.44.0409251941590.28582-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409251941590.28582-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 07:44:05PM -0400, Rik van Riel wrote:
> On Sat, 25 Sep 2004, Andrea Arcangeli wrote:
> 
> > set_pte), while something like this should be fine:
> > 
> > 	ptep_get_and_clear
> > 	set_pte
> > 	flush_tlb
> 
> Almost.  Think of software TLB refills, especially HPTE.
> The order needs to be:
> 
> 	ptep_get_and_clear
> 	flush_tlb
> 	set_pte

Interesting point. I sure agree it's saner to have the flush_tlb in
between ptep_get_and_clear and set_pte, I said the other version just
because I'm thinking hardware TLB and it shouldn't make any difference
on hardware TLB anyways, does it?

> Any page faults happening "in the middle" will end up as
> virtual no-ops once they grab the page_table_lock.

I'm not very fond on software TLBs and their internal locking, but
exactly because of what you said ("they grab the page_table_lock."), how
can the software TLB ever care about the flush_tlb in between
ptep_get_and_clear and set_pte?

ptep_establish is obviously always called with the page_table_lock hold.
Nobody is allowed to call ptep_establish without it. So a larger code
sequence of my version expands to:

	spin_lock(&page_table_lock)
	ptep_establish() {
		ptep_get_and_clear
		set_pte
		flush_tlb
	}
	spin_unlock(&page_table_lock)

How can a software TLB care about a tlb flush in between two pieces of
code that are anyways under the page_table_lock?
