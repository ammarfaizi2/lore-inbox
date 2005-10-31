Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVJaVOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVJaVOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVJaVOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:14:00 -0500
Received: from fmr24.intel.com ([143.183.121.16]:39146 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932184AbVJaVN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:13:59 -0500
Subject: Re: [PATCH]: Clean up of __alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051029184728.100e3058.pj@sgi.com>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	 <20051029184728.100e3058.pj@sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Mon, 31 Oct 2005 13:20:54 -0800
Message-Id: <1130793655.4853.41.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2005 21:13:44.0396 (UTC) FILETIME=[F9CA20C0:01C5DE5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-29 at 18:47 -0700, Paul Jackson wrote:
> A couple more items:
>  1) Lets try for a consistent use of type "gfp_t" for gfp_mask.
>  2) The can_try_harder flag values were driving me nuts.

Not sure why?  Let me see if some new values could better articulate the
meaning.  Currently if value is < 0 then don't check the watermarks.
When we do check for watermarks, then the value of 1 indicates that it
could go below minimum value.

>  3) The "inline" you added to buffered_rmqueue() blew up my compile.

I will remove the inline based on your and Nick emails.  Though my patch
had inline before the struct....

-static struct page *
-buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags)
+static inline struct page *
+buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags, int
replenish)

...so that shouldn't have caused any problem.

>  4) The return from try_to_free_pages() was put in "i" for no evident reason.

Will be fixed.

>  5) I have no clue what the replenish flag you added to buffered_rmqueue does.
> 

A bit futuristic.  Will need it when pcp allocations gets checked first
(as Nick also mentioned).  Will remove it for now.

> You patch has:
> > can_try_harder can have following 
> >  * values:
> >  * -1 => No need to check for the watermarks.
> >  *  0 => Don't go too low down in deeps below the low watermark (GFP_HIGH)
> >  *  1 => Go far below the low watermark.  See zone_watermark_ok (RT TASK)
> 
> Later on, you have an inequality test on this value:
> 	if ((can_try_harder >= 0)
> and a non-zero test:
> 	if (can_try_harder)

The last line is from zone_watermark_ok.  The first check is in
get_page_from_freelist.  There is no (can_try_harder) check for this
flag in that function.

> 
> That's three magic values, not even in increasing order of "how hard
> one should try", tested a couple of different ways that requires
> absorbing the complete details of the three values and their ordering
> before one can read the code.
> 



