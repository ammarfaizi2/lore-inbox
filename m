Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbULWUIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbULWUIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 15:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbULWUIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 15:08:05 -0500
Received: from quark.didntduck.org ([69.55.226.66]:25778 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261304AbULWUH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 15:07:56 -0500
Message-ID: <41CB25AE.6010109@didntduck.org>
Date: Thu, 23 Dec 2004 15:08:14 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [1/4]: __GFP_ZERO / clear_page() removal
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com> <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> This patch introduces __GFP_ZERO as an additional gfp_mask element to allow
> to request zeroed pages from the page allocator.
> 
> o Modifies the page allocator so that it zeroes memory if __GFP_ZERO is set
> 
> o Replace all page zeroing after allocating pages by request for
>   zeroed pages.
> 
> o requires arch updates to clear_page in order to function properly.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 

> @@ -125,22 +125,19 @@
>  	int i;
>  	struct packet_data *pkt;
> 
> -	pkt = kmalloc(sizeof(struct packet_data), GFP_KERNEL);
> +	pkt = kmalloc(sizeof(struct packet_data), GFP_KERNEL|__GFP_ZERO);
>  	if (!pkt)
>  		goto no_pkt;
> -	memset(pkt, 0, sizeof(struct packet_data));
> 
>  	pkt->w_bio = pkt_bio_alloc(PACKET_MAX_SIZE);
>  	if (!pkt->w_bio)

This part is wrong.  kmalloc() uses the slab allocator instead of 
getting a full page.

--
				Brian Gerst
