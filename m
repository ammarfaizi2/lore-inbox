Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWATBa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWATBa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWATBa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:30:27 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33499 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030466AbWATBa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:30:26 -0500
Date: Thu, 19 Jan 2006 17:30:14 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_list: Use of && instead || leads to unintended
 writing of pages
In-Reply-To: <20060119172032.04bad017.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601191727210.13819@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601191602260.13428@schroedinger.engr.sgi.com>
 <20060119164341.0fb9c7e3.akpm@osdl.org> <Pine.LNX.4.62.0601191648440.13602@schroedinger.engr.sgi.com>
 <20060119172032.04bad017.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Andrew Morton wrote:

> laptop_mode=1: don't write out dirty pages if we're only performing light
> scanning.  But do write them out once page reclaim starts getting into
> difficulty.

Ahh. Now I see ..... Wrong field.

> I guess if zone reclaim wants to permanently disable writeback then it'll
> be needing a new scan_control flag for that.  Which means that we need to

We have such a flag and its called may_swap (was introduced by Martin 
Hicks). If we cannot swap then we should not write out pages.

Thus we need this fix instead:

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc1-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc1-mm1.orig/mm/vmscan.c	2006-01-19 15:50:19.000000000 -0800
+++ linux-2.6.16-rc1-mm1/mm/vmscan.c	2006-01-19 17:26:50.000000000 -0800
@@ -491,7 +491,7 @@ static int shrink_list(struct list_head 
 				goto keep_locked;
 			if (!may_enter_fs)
 				goto keep_locked;
-			if (laptop_mode && !sc->may_writepage)
+			if ((laptop_mode && !sc->may_writepage) || !sc->may_swap)
 				goto keep_locked;
 
 			/* Page is dirty, try to write it out here */
