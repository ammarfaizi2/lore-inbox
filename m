Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVFATpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVFATpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVFATo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:44:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43242 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261211AbVFASrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:47:17 -0400
Subject: Re: [PATCH] Periodically drain non local pagesets
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       ia64 list <linux-ia64@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0506011047060.9277@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0506011047060.9277@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 11:46:58 -0700
Message-Id: <1117651618.13600.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 10:48 -0700, Christoph Lameter wrote:
> +               struct per_cpu_pageset *pset;
> +
> +               /* Do not drain local pagesets */
> +               if (zone == zone_table[numa_node_id()])
> +                       continue;
> +

It's best to avoid using NUMA-specific data structures, even in #ifdef
NUMA code.  This particular use is incorrect, as the zone_table[] is not
indexed by numa_node_id(), but rather by a combination of the node
number and the zone number (see NODEZONE()).

I'd suggest using something like this:

	if (zone->zone_pgdat->node_id == numa_node_id())

It might be nice to have a zone_node_id() macro that hides this as well.
With a macro like that that #defines to 0 when !CONFIG_NUMA, the #ifdef
around that function could probably go away.  

Also, are you sure that you need the local_irq_en/disable()?  

-- Dave

