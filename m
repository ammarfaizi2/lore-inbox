Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312037AbSCTTNu>; Wed, 20 Mar 2002 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSCTTNl>; Wed, 20 Mar 2002 14:13:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13586 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312037AbSCTTNa>;
	Wed, 20 Mar 2002 14:13:30 -0500
Message-ID: <3C98DEDB.B1FFB116@zip.com.au>
Date: Wed, 20 Mar 2002 11:11:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-110-zone_accounting
In-Reply-To: <3C9808EE.B5C38E84@zip.com.au> <Pine.LNX.4.44L.0203201043250.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 19 Mar 2002, Andrew Morton wrote:
> 
> > 1: page_cache_size is no longer an atomic type - it's now just an
> >    unsigned long.  It's always altered under pagecache_lock.
> 
> Is this change worth it ?   This code will have to be changed
> back in any patch trying to fine-grain the pagecache lock...

Yes, it's the right change.  Changes to page_cache_size always
occur at the same time as changes to the per-zone accounting.
So the locking is shared and it all nestles nicely.

In the longer-term we don't want that atomic_t either.  We
need to avoid global and even per-zone atomic_t's and locks.

> Alternatively, maybe we should hide the page_cache_size behind
> magic macros too, so it's easier to change the underlying data
> structure(s).

I currently have:

+extern struct page_state {
+       unsigned long nr_dirty;
+       unsigned long nr_locked;
+       unsigned long nr_pagecache;
+} ____cacheline_aligned page_states[NR_CPUS];
+
+extern void get_page_state(struct page_state *ret);



-
