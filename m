Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVGHPB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVGHPB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 11:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVGHPB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 11:01:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4794 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261451AbVGHPB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 11:01:26 -0400
Date: Fri, 8 Jul 2005 01:28:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Sizhao Yang <zaoyang@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ASPLOV miss ratio porting to planet labs kernel
Message-ID: <20050708042843.GB5793@dmt.cnet>
References: <f0655b9a0507071028209af86e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0655b9a0507071028209af86e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 12:28:09PM -0500, Sizhao Yang wrote:
> Hi all,
> 
> I was wondering if someone could help me with this.  I'm porting an
> ASPLOV paper miss ratio curve from 2.4.20 2.6.11.6 and eventually to
> Planet Labs kernel.  It's a novel idea for memory management.  In
> porting I at run time I'm consistently hitting kernel bugs at four
> different places bad_page, bad_range, in rmap.c
> BUG(page_mapcount(page)< 0), and failing at apm_do_idle.  All of these
> functions except apm_do_idle seem to be new functions from 2.4.20 to
> 2.6.11.6.  I'm pretty sure I'm forgetting to account for certain
> things when modifying the pages, but I'm not sure where.

Having the information which bad_page etc. dump out would definately help.

I can't figure out what is going on with the data you provide, probably
someone else can.

> What I'm doing in the port is resetting protection bits so that when
> it page faults.  It will calculate a miss ratio based on the number of
> accessed bits and other information.  After I gather the information I
> will reset the accessed bits.  Then based on previous miss ratios and
> current miss ratio it will give out memory to different processes
> based on that.  That's the general idea.  For more specifics:
> 
> http://carmen.cs.uiuc.edu/paper/ASPLOS04-Zhou.pdf
> 
> I've narrowed it down to primarily when I call the following functions:
> ptep_test_and_clear_young,
> static inline pte_t pte_mknominor(pte_t pte) { (pte).pte_low &=
> ~_PAGE_PROTNONE; return pte; }
> static inline pte_t pte_mkminor(pte_t pte) { (pte).pte_low |=
> _PAGE_PROTNONE; return pte; }
> static inline pte_t pte_mkpresent(pte_t pte) { (pte).pte_low |=
> _PAGE_PRESENT; return pte; }
> static inline pte_t pte_mkabsent(pte_t pte) { (pte).pte_low &=
> ~_PAGE_PRESENT; return pte; }
> 
> When I don't have those functions in my code the kernel doesn't crash,
> but when I do they crash.  So, my question is am I to page accounting
> aspects? I looked at rmap functions for incrementing the _mapcount but
> they seem to be only for when a pte is copied.  Should I be
> incrementing the pagecount at any point?

Nope - that should be internal to rmap.c (you shouldnt touch mapcount directly). 
But you dont seem to be doing that anyway. 

> rmap.c
> BUG(page_mapcount(page)< 0) is invoked when the accessed bits are
> cleared in zap_pte, but I don't know how the page is being corrupted. 

Why dont you post the code (in case its GPL)...
