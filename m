Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTDWVgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTDWVgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:36:52 -0400
Received: from [12.47.58.232] ([12.47.58.232]:40863 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264233AbTDWVgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:36:51 -0400
Date: Wed, 23 Apr 2003 14:46:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-Id: <20030423144648.5ce68d11.akpm@digeo.com>
In-Reply-To: <18400000.1051109459@[10.10.2.4]>
References: <20030423012046.0535e4fd.akpm@digeo.com>
	<18400000.1051109459@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2003 21:48:51.0721 (UTC) FILETIME=[20FCE790:01C309E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > . I got tired of the objrmap code going BUG under stress, so it is now in
> >   disgrace in the experimental/ directory.
> 
> Any chance of some more info on that? BUG at what point in the code,
> and with what test to reproduce?

A bash-shared-mapping (from ext3 CVS) will quickly knock it over.  It gets
its PageAnon/page->mapping state tangled up.

Must confess that I have trouble getting excited over objrmap.  It introduces

- inconsistency (pte_chains versus vma-list scanning)

- code complexity

- a quadratic search

- nasty, nasty problems with remap_file_pages().  I'd rather not have to
  nobble remap_file_pages() functionality for this reason.

and what do we gain from it all?  The small fork/exec boost isn't very
significant.  What we gain is more lowmem space on
going-away-real-soon-now-we-sincerely-hope highmem boxes.

Ingo-rmap seems a better solution to me.  It would be a fairly large change
though - we'd have to hold the four atomic kmaps across an entire pte page
in copy_page_range(), for example.  But it will then have good locality of
reference between adjacent pages and may well be quicker than pte_chains.


