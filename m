Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268326AbUHQQRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268326AbUHQQRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268329AbUHQQRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:17:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23776 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268326AbUHQQRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:17:02 -0400
Subject: Re: [PATCH][3/6]Interface for copying the dump pages
From: Dave Hansen <haveblue@us.ibm.com>
To: "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org, Andrew Morton <akpm@osdl.org>,
       "Suparna Bhattacharya [imap]" <suparna@in.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, litke@us.ibm.com,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20040817120809.GD3916@in.ibm.com>
References: <20040817120239.GA3916@in.ibm.com>
	 <20040817120531.GB3916@in.ibm.com> <20040817120717.GC3916@in.ibm.com>
	 <20040817120809.GD3916@in.ibm.com>
Content-Type: text/plain
Message-Id: <1092759421.5415.66.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 09:17:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 05:08, Hariprasad Nellitheertha wrote:
> Regards, Hari
> +/* This is the same as kmap_atomic but takes in a pfn instead of a
> + * struct page.
> + */

How about:

/* 
 * This is the same as kmap_atomic() but can map memory that doesn't 
 * necessarily have struct page associated with it.
 */

> +ssize_t copy_hmem_page(unsigned long pfn, char *buf, size_t csize,
> int userbuf)
...
> +       if (pfn == -1) {
> +               /* Give them a zeroed page */
> +               if (userbuf) {
> +                       if (clear_user(buf, csize))
> +                               return -EFAULT;
> +               } else
> +                       memset(buf, 0, csize);
> +       } else {

This is really hackish.  If you want to zero a userspace page, just zero
it in the caller's code, or call a different function.  Zeroing a
userspace page has nothing to do with copying a highmem page, and it
really shouldn't be here.  Just changing it from taking a 0 to a -1 from
the last time you posted it doesn't really make it any better.

Also, that function might belong in the same area as copy_highpage(),
not in some driver.  In any case, it certainly needs a big fat comment
explaining why it is special, and different from copy_highpage().

If it shouldn't be moved and really is isolated to the mem.c driver, it
needs to be declared static.

-- Dave

