Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWEEOeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWEEOeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWEEOeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:34:10 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:1971 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751560AbWEEOeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:34:09 -0400
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
From: Dave Hansen <haveblue@us.ibm.com>
To: Bob Picco <bob.picco@hp.com>
Cc: Andy Whitcroft <apw@shadowen.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <20060505135503.GA5708@localhost>
References: <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de>
	 <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au>
	 <20060504013239.GG19859@localhost>
	 <1146756066.22503.17.camel@localhost.localdomain>
	 <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu>
	 <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org>
	 <20060505135503.GA5708@localhost>
Content-Type: text/plain
Date: Fri, 05 May 2006 07:33:10 -0700
Message-Id: <1146839590.22503.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-05 at 09:55 -0400, Bob Picco wrote:
> -               if (!page_is_buddy(buddy, order))
> +               if (page_in_zone_hole(buddy))
> +                       break;
> +               else if (page_zonenum(buddy) != page_zonenum(page))
> +                       break;
> +               else if (!page_is_buddy(buddy, order))
>                         break;          /* Move the buddy up one level. */ 

The page_zonenum() checks look good, but I'm not sure I understand the
page_in_zone_hole() part.  If a page is in a hole in a zone, it will
still have a valid mem_map entry, right?  It should also never have been
put into the allocator, so it also won't ever be coalesced.  

I'm a bit confused. :(

BTW, I like the idea of just aligning HIGHMEM's start because it has no
runtime cost.  Buuuuut, it is still just a shift and compare of the two
page->flags, which should already be (or will soon anyway be) in the
cache.

-- Dave

