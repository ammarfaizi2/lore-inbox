Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268651AbTCCWIt>; Mon, 3 Mar 2003 17:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268642AbTCCWIt>; Mon, 3 Mar 2003 17:08:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:50168 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268651AbTCCWIq>;
	Mon, 3 Mar 2003 17:08:46 -0500
Date: Mon, 3 Mar 2003 14:15:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2.5.63] Teach page_mapped about the anon flag
Message-Id: <20030303141518.12d9ccd8.akpm@digeo.com>
In-Reply-To: <117290000.1046728362@baldur.austin.ibm.com>
References: <20030227025900.1205425a.akpm@digeo.com>
	<200302280822.09409.kernel@kolivas.org>
	<20030227134403.776bf2e3.akpm@digeo.com>
	<118810000.1046383273@baldur.austin.ibm.com>
	<20030227142450.1c6a6b72.akpm@digeo.com>
	<103400000.1046725581@baldur.austin.ibm.com>
	<20030303131210.36645af6.akpm@digeo.com>
	<107610000.1046726685@baldur.austin.ibm.com>
	<20030303133539.6594e0b6.akpm@digeo.com>
	<117290000.1046728362@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2003 22:19:03.0380 (UTC) FILETIME=[E5C0E140:01C2E1D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> --On Monday, March 03, 2003 13:35:39 -0800 Andrew Morton <akpm@digeo.com>
> wrote:
> 
> > We do need a patch I think.  page_mapped() is still assuming that an
> > all-bits-zero atomic_t corresponds to a zero-value atomic_t.
> > 
> > This does appear to be true for all supported architectures, but it's a
> > bit grubby.
> 
> If that's ever not true then we need extra code to initialize/rezero that
> field, since we assume it's zero on alloc, and the pte_chain code also
> assumes it's zero for a new page.

Well why not make mapcount an "int" and move the places where it is modified
inside pte_chain_lock()?

That does not increase the number of atomic operations, and it makes me stop
wondering if this:

                if (atomic_read(&page->pte.mapcount) == 0)
                        inc_page_state(nr_mapped);

is racy ;)

