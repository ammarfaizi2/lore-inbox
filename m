Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWARBaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWARBaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWARBaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:30:05 -0500
Received: from ns1.siteground.net ([207.218.208.2]:43696 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932468AbWARBaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:30:03 -0500
Date: Tue, 17 Jan 2006 17:29:53 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] mm: Convert global dirty_exceeded flag to per-node node_dirty_exceeded
Message-ID: <20060118012953.GC5289@localhost.localdomain>
References: <20060117020352.GB5313@localhost.localdomain> <20060116181323.7a5f0ac7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116181323.7a5f0ac7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 06:13:23PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > Convert global dirty_exceeded flag to per-node node_dirty_exceeded.
> > 
> > dirty_exceeded ping pongs between nodes in order to force all cpus in
> > the system to increase the frequency of calls to balance_dirty_pages.
> > 
> > Currently dirty_exceeded is used by balance_dirty_pages_ratelimited to
> > force all CPUs in the system call balance_dirty_pages often, in order to
> > reduce the amount of dirty pages in the entire system (based on
> > dirty_thresh and one CPU exceeding thee ratelimits).  As dirty_exceeded
> > is a global variable, it will ping-pong between nodes of a NUMA system
> > which is not good.
> 
> Did you not test this obvious little optimisation?

We ran the test we encountered this problem on with your patch.
At first it looked like it did not help.  But later we found that there was
false sharing on this variable.  So padding dirty_exceeded to cacheline
along with your patch helps.

Thanks,
Kiran


Avoid false sharing on dirty_exceeded.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: build-2.6.15/mm/page-writeback.c
===================================================================
--- build-2.6.15.orig/mm/page-writeback.c	2006-01-17 12:46:00.000000000 -0800
+++ build-2.6.15/mm/page-writeback.c	2006-01-17 16:21:47.000000000 -0800
@@ -46,7 +46,7 @@
 static long ratelimit_pages = 32;
 
 static long total_pages;	/* The total number of pages in the machine. */
-static int dirty_exceeded;	/* Dirty mem may be over limit */
+static int dirty_exceeded __cacheline_aligned_in_smp;	/* Dirty mem may be over limit */
 
 /*
  * When balance_dirty_pages decides that the caller needs to perform some
