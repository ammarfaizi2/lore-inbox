Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVJCPeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVJCPeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVJCPeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:34:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8082 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932296AbVJCPeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:34:15 -0400
Date: Mon, 3 Oct 2005 08:34:08 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Seth, Rohit" <rohit.seth@intel.com>
cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
In-Reply-To: <20051001120023.A10250@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0510030828400.7812@schroedinger.engr.sgi.com>
References: <20051001120023.A10250@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2005, Seth, Rohit wrote:

> -				goto zone_reclaim_retry;
> -			}
> +	if (order == 0) {
> +		for (i = 0; (z = zones[i]) != NULL; i++) {
> +			page = buffered_rmqueue(z, 0, gfp_mask, 0);
> +			if (page) 
> +				goto got_pg;
>  		}
> -

This is checking all zones for pages on the pcp before going the more 
expensive route?

Seems that this removes the logic intended to prefer local 
allocations over remote pages present in the existing alloc_pages? There 
is the danger that this modification will lead to the allocation of remote 
pages even if local pages are available. Thus reducing performance.

I would suggest to just check the first zone's pcp instead of all zones.

