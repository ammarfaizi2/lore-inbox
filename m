Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268806AbTCCVFm>; Mon, 3 Mar 2003 16:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268807AbTCCVFm>; Mon, 3 Mar 2003 16:05:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:43765 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268806AbTCCVFl>;
	Mon, 3 Mar 2003 16:05:41 -0500
Date: Mon, 3 Mar 2003 13:12:10 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2.5.63] Teach page_mapped about the anon flag
Message-Id: <20030303131210.36645af6.akpm@digeo.com>
In-Reply-To: <103400000.1046725581@baldur.austin.ibm.com>
References: <20030227025900.1205425a.akpm@digeo.com>
	<200302280822.09409.kernel@kolivas.org>
	<20030227134403.776bf2e3.akpm@digeo.com>
	<118810000.1046383273@baldur.austin.ibm.com>
	<20030227142450.1c6a6b72.akpm@digeo.com>
	<103400000.1046725581@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2003 21:15:54.0733 (UTC) FILETIME=[138B39D0:01C2E1CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> --On Thursday, February 27, 2003 14:24:50 -0800 Andrew Morton
> <akpm@digeo.com> wrote:
> 
> > I'm just looking at page_mapped().  It is now implicitly assuming that the
> > architecture's representation of a zero-count atomic_t is all-bits-zero.
> > 
> > This is not true on sparc32 if some other CPU is in the middle of an
> > atomic_foo() against that counter.  Maybe the assumption is false on other
> > architectures too.
> > 
> > So page_mapped() really should be performing an atomic_read() if that is
> > appropriate to the particular page.  I guess this involves testing
> > page->mapping.  Which is stable only when the page is locked or
> > mapping->page_lock is held.
> > 
> > It appears that all page_mapped() callers are inside lock_page() at
> > present, so a quick audit and addition of a comment would be appropriate
> > there please.
> 
> I'm not at all confident that page_mapped() is adequately protected.

It is.  All callers which need to be 100% accurate are under
pte_chain_lock().

> Here's a patch that explicitly handles the atomic_t case.

OK..  But it increases dependency on PageAnon.  Wasn't the plan to remove
that at some time?

