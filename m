Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWJLVky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWJLVky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWJLVky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:40:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750719AbWJLVkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:40:53 -0400
Date: Thu, 12 Oct 2006 14:40:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>
Subject: Re: [patch 4/7] fault-injection capability for alloc_pages()
Message-Id: <20061012144042.b6d43c01.akpm@osdl.org>
In-Reply-To: <452df22a.6ff794a4.60eb.4092@mx.google.com>
References: <20061012074305.047696736@gmail.com>
	<452df22a.6ff794a4.60eb.4092@mx.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 16:43:09 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> @@ -1058,6 +1097,9 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
>  
>  	might_sleep_if(wait);
>  
> +	if (should_fail_alloc_page(gfp_mask, order))
> +		return NULL;

In previous work I've done on this I've found that allowing
application-initiated allocations to fail is a right pain: all of userspace
gets all unreliable and applications die all the time.

I realise that it's possible to limit the failures to a particular process,
but it's also possible to let the allocations fail for _all_ processes, in
which case this problem will hurt.

What I found was a reasonable fix for this problem was to limit the
failures to those requests which did not have __GFP_HIGHMEM set.  That way,
userspace allocations work, but kernel-internal allocations are subject to
failures.

That might be worth adding as an additional tunable?
