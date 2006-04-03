Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWDCCsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWDCCsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 22:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWDCCsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 22:48:24 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:12178 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750748AbWDCCsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 22:48:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: lowmem_reserve question
Date: Mon, 3 Apr 2006 12:48:13 +1000
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, Andrew Morton <akpm@osdl.org>,
       linux list <linux-kernel@vger.kernel.org>
References: <200604021401.13331.kernel@kolivas.org> <200604021939.21729.kernel@kolivas.org> <442F9E91.1020306@yahoo.com.au>
In-Reply-To: <442F9E91.1020306@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604031248.13532.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 April 2006 19:51, Nick Piggin wrote:
> That zone->lowmem_reserve[zone_idx(zone)] == 0 ?

I haven't figured out how to tackle the swap prefetch issue with lowmem 
reserve just yet. While trying to digest just what the lowmem_reserve does 
and how it's utilised I looked at some of the numbers

int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 };

lower_zone->lowmem_reserve[j] = present_pages / 
sysctl_lowmem_reserve_ratio[idx];

This is interesting because there are no bounds on this value and it seems 
possible to set the sysctl to have a lowmem_reserve that is larger than the 
zone size. Ok that's a sysctl so if a user is setting it wrongly that's their 
fault... or should there be some upper bound?

Furthermore, now that we have the option of up to 3GB lowmem split on 32bit we 
can have a default lowmem_reserve of almost 12MB (if I'm reading it right) 
which seems very tight with only 16MB of ZONE_DMA. 

On a basically idle 1GB lowmem box that I have it looks like this:

Node 0, zone      DMA
  pages free     1025
        min      15
        low      18
        high     22
        active   2185
        inactive 0
        scanned  555 (a: 21 i: 6)
        spanned  4096
        present  4096
        protection: (0, 0, 1007, 1007)

With 3GB lowmem the default settings seem too tight to me. The way I see it, 
there should be some upper bounds on the lowmem reserves. Or perhaps I'm just 
missing something again... I'm feeling even thicker than usual.

Cheers,
Con
