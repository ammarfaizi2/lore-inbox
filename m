Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTB0WXo>; Thu, 27 Feb 2003 17:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTB0WXo>; Thu, 27 Feb 2003 17:23:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:46213 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267091AbTB0WSA>;
	Thu, 27 Feb 2003 17:18:00 -0500
Date: Thu, 27 Feb 2003 14:24:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Rising io_load results Re: 2.5.63-mm1
Message-Id: <20030227142450.1c6a6b72.akpm@digeo.com>
In-Reply-To: <118810000.1046383273@baldur.austin.ibm.com>
References: <20030227025900.1205425a.akpm@digeo.com>
	<200302280822.09409.kernel@kolivas.org>
	<20030227134403.776bf2e3.akpm@digeo.com>
	<118810000.1046383273@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Feb 2003 22:28:13.0745 (UTC) FILETIME=[8424EA10:01C2DEAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> --On Thursday, February 27, 2003 13:44:03 -0800 Andrew Morton
> <akpm@digeo.com> wrote:
> 
> >> ...
> >> Mapped:       4294923652 kB
> > 
> > Well that's gotta hurt.  This metric is used in making writeback
> > decisions.  Probably the objrmap patch.
> 
> Oops.  You're right.  Here's a patch to fix it.
> 

Thanks.

I'm just looking at page_mapped().  It is now implicitly assuming that the
architecture's representation of a zero-count atomic_t is all-bits-zero.

This is not true on sparc32 if some other CPU is in the middle of an
atomic_foo() against that counter.  Maybe the assumption is false on other
architectures too.

So page_mapped() really should be performing an atomic_read() if that is
appropriate to the particular page.  I guess this involves testing
page->mapping.  Which is stable only when the page is locked or
mapping->page_lock is held.

It appears that all page_mapped() callers are inside lock_page() at present,
so a quick audit and addition of a comment would be appropriate there please.


