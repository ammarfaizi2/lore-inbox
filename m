Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVJMQeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVJMQeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 12:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVJMQeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 12:34:05 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:65259 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932087AbVJMQeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 12:34:04 -0400
Message-ID: <434E8C72.5000909@austin.ibm.com>
Date: Thu, 13 Oct 2005 11:33:54 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2/8] Fragmentation Avoidance V17: 002_usemap
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>  <20051011151231.16178.58396.sendpatchset@skynet.csn.ul.ie> <1129211783.7780.7.camel@localhost> <Pine.LNX.4.58.0510131500020.7570@skynet>
In-Reply-To: <Pine.LNX.4.58.0510131500020.7570@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>@@ -473,6 +491,15 @@ extern struct pglist_data contig_page_da
>>> #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
>>> #error Allocator MAX_ORDER exceeds SECTION_SIZE
>>> #endif
>>>+#if ((SECTION_SIZE_BITS - MAX_ORDER) * BITS_PER_RCLM_TYPE) > 64
>>>+#error free_area_usemap is not big enough
>>>+#endif
>>
>>Every time I look at these patches, I see this #if, and I don't remember
>>what that '64' means.  Can it please get a real name?
>>
> 
> 
> Joel, suggestions?

Oh yeah, blame it on me just because I wrote that bit of code.  How about
#define FREE_AREA_USEMAP_SIZE 64

> 
> 
>>>+/* Usemap initialisation */
>>>+#ifdef CONFIG_SPARSEMEM
>>>+static inline void setup_usemap(struct pglist_data *pgdat,
>>>+				struct zone *zone, unsigned long zonesize) {}
>>>+#endif /* CONFIG_SPARSEMEM */
>>>
>>> struct page;
>>> struct mem_section {
>>>@@ -485,6 +512,7 @@ struct mem_section {
>>> 	 * before using it wrong.
>>> 	 */
>>> 	unsigned long section_mem_map;
>>>+	DECLARE_BITMAP(free_area_usemap,64);
>>> };
>>
>>There's that '64' again!  You need a space after the comma, too.

Ditto.

>>>+ * RCLM_SHIFT is the number of bits that a gfp_mask has to be shifted right
>>>+ * to have just the __GFP_USER and __GFP_KERNRCLM bits. The static check is
>>>+ * made afterwards in case the GFP flags are not updated without updating
>>>+ * this number
>>>+ */
>>>+#define RCLM_SHIFT 19
>>>+#if (__GFP_USER >> RCLM_SHIFT) != RCLM_USER
>>>+#error __GFP_USER not mapping to RCLM_USER
>>>+#endif
>>>+#if (__GFP_KERNRCLM >> RCLM_SHIFT) != RCLM_KERN
>>>+#error __GFP_KERNRCLM not mapping to RCLM_KERN
>>>+#endif
>>
>>Should this really be in page_alloc.c, or should it be close to the
>>RCLM_* definitions?

I had the same first impression, but concluded this was the best place.  The 
compile time checks should keep things from getting out of sync.
