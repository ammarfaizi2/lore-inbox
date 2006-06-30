Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWF3GP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWF3GP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWF3GP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:15:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45000 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751140AbWF3GP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:15:56 -0400
Date: Thu, 29 Jun 2006 23:15:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ZVC: Increase threshold for larger processor configurationss
In-Reply-To: <Pine.LNX.4.64.0606291116500.27926@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606292314580.31091@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606281038530.22262@schroedinger.engr.sgi.com>
 <20060628154911.6e035153.akpm@osdl.org> <Pine.LNX.4.64.0606291116500.27926@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006, Christoph Lameter wrote:

> > Did you consider my earlier suggestion about these counters?  That, over the
> > short-term, they tend to count in only one direction?  So we can do
> Uhh... We are overcompensating right? Pretty funky idea that is new to me 
> and that would require some thought.
> 
> This would basically increase the stepping by 50% if we are only going in 
> one direction.

A patch that does this:


ZVC: overcompensate while incrementing ZVC counters

Overcompensate by a balance factor when incrementing or decrementing
ZVC counters anticipating continual increase in the same direction.

Note that I have not been able to see any effect off this approach on
an 8p system where I tested this.
I probably will have a chance to test it on larger systems (160p) tomorrow.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm4/mm/vmstat.c
===================================================================
--- linux-2.6.17-mm4.orig/mm/vmstat.c	2006-06-29 13:35:16.959161608 -0700
+++ linux-2.6.17-mm4/mm/vmstat.c	2006-06-29 13:54:46.361438715 -0700
@@ -167,6 +167,9 @@ EXPORT_SYMBOL(mod_zone_page_state);
  * in between and therefore the atomicity vs. interrupt cannot be exploited
  * in a useful way here.
  */
+
+#define balance_factor(x) (x->stat_threshold / 2)
+
 static void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 {
 	struct per_cpu_pageset *pcp = zone_pcp(zone, smp_processor_id());
@@ -175,8 +178,8 @@ static void __inc_zone_state(struct zone
 	(*p)++;
 
 	if (unlikely(*p > pcp->stat_threshold)) {
-		zone_page_state_add(*p, zone, item);
-		*p = 0;
+		zone_page_state_add(*p + balance_factor(pcp), zone, item);
+		*p = -balance_factor(pcp);
 	}
 }
 
@@ -195,8 +198,8 @@ void __dec_zone_page_state(struct page *
 	(*p)--;
 
 	if (unlikely(*p < -pcp->stat_threshold)) {
-		zone_page_state_add(*p, zone, item);
-		*p = 0;
+		zone_page_state_add(*p - balance_factor(pcp), zone, item);
+		*p = balance_factor(pcp);
 	}
 }
 EXPORT_SYMBOL(__dec_zone_page_state);
