Return-Path: <linux-kernel-owner+w=401wt.eu-S932470AbXAIWpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbXAIWpV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbXAIWpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:45:21 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49785 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932470AbXAIWpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:45:20 -0500
Date: Tue, 9 Jan 2007 14:42:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tshighla@us.ibm.com, theotso@us.ibm.com
Subject: Re: [PATCH 3/3] eCryptfs: Encrypted passthrough
Message-Id: <20070109144203.ce1ed092.akpm@osdl.org>
In-Reply-To: <20070109222337.GF16578@us.ibm.com>
References: <20070109222107.GC16578@us.ibm.com>
	<20070109222337.GF16578@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 16:23:37 -0600
Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> +				page_virt = (char *)kmap(page);

Do we _have_ to use kmap here?  It's slow and theoretically deadlocky. 
kmap_atomic() is much preferred.

Can the other kmap() calls in ecryptfs be converted?

We'd actually like to remove kmap() one day.  Not much chance of that, but
it's an objective.

> +				if (!page_virt) {
> +					rc = -ENOMEM;
> +					printk(KERN_ERR "Error mapping page\n");
> +					goto out;
> +				}
> +				memset(page_virt, 0, PAGE_CACHE_SIZE);
> +				if (page->index == 0) {
> +					rc = ecryptfs_read_xattr_region(
> +						page_virt, file->f_path.dentry);

Are we assured that ecryptfs_read_xattr_region() cannot overrun the page?

> +					set_header_info(page_virt, crypt_stat);
> +				}

The kernel must always run flush_dcache_page() after modifying a pagecache
page by hand.  Please review all of ecryptfs for this.


> +				kunmap(page);
