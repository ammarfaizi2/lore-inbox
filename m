Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031057AbWKUQ5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031057AbWKUQ5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031064AbWKUQ5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:57:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:32980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031057AbWKUQ5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:57:06 -0500
Date: Tue, 21 Nov 2006 08:55:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Krafft <krafft@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] fix call to alloc_bootmem after bootmem has been
 freed
Message-Id: <20061121085535.9c62b54f.akpm@osdl.org>
In-Reply-To: <20061115193238.4d23900c@localhost>
References: <20061115193049.3457b44c@localhost>
	<20061115193238.4d23900c@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 19:32:38 +0100
Christian Krafft <krafft@de.ibm.com> wrote:

> In some cases it might happen, that alloc_bootmem is beeing called
> after bootmem pages have been freed. This is, because the condition
> SYSTEM_BOOTING is still true after bootmem has been freed.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> 
> Index: linux/mm/page_alloc.c
> ===================================================================
> --- linux.orig/mm/page_alloc.c
> +++ linux/mm/page_alloc.c
> @@ -1931,7 +1931,7 @@ int zone_wait_table_init(struct zone *zo
>  	alloc_size = zone->wait_table_hash_nr_entries
>  					* sizeof(wait_queue_head_t);
>  
> - 	if (system_state == SYSTEM_BOOTING) {
> +	if (!slab_is_available()) {
>  		zone->wait_table = (wait_queue_head_t *)
>  			alloc_bootmem_node(pgdat, alloc_size);
>  	} else {

I don't think that slab_is_available() is an appropriate way of working out
if we can call vmalloc().

Also, a more complete description of the problem is needed, please.  Which
caller is incorrectly allocating bootmem?

