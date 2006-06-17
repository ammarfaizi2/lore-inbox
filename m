Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWFQRFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWFQRFN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 13:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWFQRFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 13:05:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750723AbWFQRFK (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 13:05:10 -0400
Date: Sat, 17 Jun 2006 10:04:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: hch@infradead.org, Reiserfs-Dev@namesys.com, Linux-Kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: batched write
Message-Id: <20060617100458.0be18073.akpm@osdl.org>
In-Reply-To: <1150322912.6322.129.camel@tribesman.namesys.com>
References: <44736D3E.8090808@namesys.com>
	<20060524175312.GA3579@zero>
	<44749E24.40203@namesys.com>
	<20060608110044.GA5207@suse.de>
	<1149766000.6336.29.camel@tribesman.namesys.com>
	<20060608121006.GA8474@infradead.org>
	<1150322912.6322.129.camel@tribesman.namesys.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006 02:08:32 +0400
"Vladimir V. Saveliev" <vs@namesys.com> wrote:

> The core of generic_file_buffered_write is 
> do {
> 	grab_cache_page();
> 	a_ops->prepare_write();
> 	copy_from_user();
> 	a_ops->commit_write();
> 	
> 	filemap_set_next_iovec();
> 	balance_dirty_pages_ratelimited();
> } while (count);
> 
> 
> Would it make sence to rework this code with adding new address_space
> operation - fill_pages so that looks like:
> 
> do {
> 	a_ops->fill_pages();
> 	filemap_set_next_iovec();
> 	balance_dirty_pages_ratelimited();
> } while (count);
> 
> generic implementation of fill_pages would look like:
> 
> generic_fill_pages()
> {
> 	grab_cache_page();
> 	a_ops->prepare_write();
> 	copy_from_user();
> 	a_ops->commit_write();
> }
> 

There's nothing which leaps out and says "wrong" in this.  But there's
nothing which leaps out and says "right", either.  It seems somewhat
arbitrary, that's all.

We have one filesystem which wants such a refactoring (although I don't
think you've adequately spelled out _why_ reiser4 wants this).

To be able to say "yes, we want this" I think we'd need to understand which
other filesystems would benefit from exploiting it, and with what results?
