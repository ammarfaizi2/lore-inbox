Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVIUVSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVIUVSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVIUVSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:18:48 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:48350 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964883AbVIUVSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:18:47 -0400
Subject: Re: [swsusp] Rework image freeing
From: Dave Hansen <haveblue@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050921205132.GA4249@elf.ucw.cz>
References: <20050921205132.GA4249@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 14:18:02 -0700
Message-Id: <1127337482.10664.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-21 at 22:51 +0200, Pavel Machek wrote:
> +static long alloc_image_page(void)
> +{
> +       long res = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
> +       if (res) {
> +               SetPageNosave(virt_to_page(res));
> +               SetPageNosaveFree(virt_to_page(res));
> +       }
> +       return res;
> +}

Please avoid using longs here.  "res" really is a virtual address, and
it would be polite to keep it in a pointer of some kind.  Returning
void* would also avoid the two casts in alloc_pagedir().  The same
probably goes for pbe->address and pbe->orig_address.

BTW, I think get_zeroed_page() returns a long to keep people from
confusing it with the allocator routines that return actual 'struct page
*', and not the page's virtual address.  So, you really should be
casting them to real pointers as soon as it comes back from
get_zeroed_page() and cousins.

-- Dave

