Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUJNUXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUJNUXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUJNTpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:45:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267254AbUJNTo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:44:26 -0400
Date: Thu, 14 Oct 2004 20:44:21 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RESEND][PATCH 5/6] Provide a filesystem-specific sync'able page bit
Message-ID: <20041014194421.GU16153@parcelfarce.linux.theplanet.co.uk>
References: <24461.1097780707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24461.1097780707@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 08:05:07PM +0100, David Howells wrote:
>  #define PG_highmem		 8
> +#define PG_fs_misc		 9	/* Filesystem specific bit */
>  #define PG_checked		 9	/* kill me in 2.5.<early>. */
>  #define PG_arch_1		10
>  #define PG_reserved		11
> @@ -315,4 +316,13 @@ static inline void set_page_writeback(st
>  	test_set_page_writeback(page);
>  }
>  
> +/*
> + * Filesystem-specific page bit testing
> + */
> +#define PageFsMisc(page)		test_bit(PG_fs_misc, &(page)->flags)
> +#define SetPageFsMisc(page)		set_bit(PG_fs_misc, &(page)->flags)
> +#define TestSetPageFsMisc(page)		test_and_set_bit(PG_fs_misc, &(page)->flags)
> +#define ClearPageFsMisc(page)		clear_bit(PG_fs_misc, &(page)->flags)
> +#define TestClearPageFsMisc(page)	test_and_clear_bit(PG_fs_misc, &(page)->flags)
> +
>  #endif	/* PAGE_FLAGS_H */

That's not really enough documentation.  Who sets this flag?  Who clears this
flag?  Currently, mm/page_alloc.c clears this flag:

./mm/page_alloc.c:                      1 << PG_checked | 1 << PG_mappedtodisk);

which probably wouldn't be noticed by someone grepping for uses.
If you're going to not kill this flag, at least rename it so we don't
have two defines for the same bit.

The other 'misc bit' has documentation of the form:

 * PG_arch_1 is an architecture specific page state bit.  The generic code
 * guarantees that this bit is cleared for a page when it first is entered into
 * the page cache.

which really ought to at least mention Documentation/cachetlb.txt

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
