Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUFARD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUFARD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUFARD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:03:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52231 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265041AbUFARDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:03:44 -0400
Date: Tue, 1 Jun 2004 18:03:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Dave Miller <davem@redhat.com>
Subject: [PATCH] Fix loop device cache handling
Message-ID: <20040601180336.C31301@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Dave Miller <davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in the distant LKML past, davem hinted that the loop block device
driver was missing some cache handling for aliasing caches:

	http://lkml.org/lkml/2003/5/29/19

It appears the loop driver has had one flush_dcache_page() call
added for the case where it writes to the backing device page
cache pages.

However, it seems to be missing the call where it writes to its
own page cache pages.  This patch allows us to clearly demonstrate
the problem on ARM:

> @@ -85,9 +85,10 @@ static int transfer_none(struct loop_dev
>  	char *raw_buf = kmap_atomic(raw_page, KM_USER0) + raw_off;
>  	char *loop_buf = kmap_atomic(loop_page, KM_USER1) + loop_off;
>  
> -	if (cmd == READ)
> +	if (cmd == READ) {
> +int i; for (i = 0; i < PAGE_SIZE; i+=32) ((volatile unsigned char *)loop_buf)[i];
>  		memcpy(loop_buf, raw_buf, size);
> -	else
> +	} else
>  		memcpy(raw_buf, loop_buf, size);
>  
>  	kunmap_atomic(raw_buf, KM_USER0);

The effect of this is that we pull the loop device page into cache
to exhasibate the problem, since newly allocated pages are _not_
guaranteed to be completely clean of cache lines in their kernel
space mapping.

Note that other drivers need to be audited to ensure that any CPU
writes to page cache pages have a flush_dcache_page() call.

This patch adds the necessary missing flush:

--- orig/drivers/block/loop.c	Sun May 30 10:32:32 2004
+++ linux/drivers/block/loop.c	Tue Jun  1 17:46:47 2004
@@ -308,7 +308,9 @@ lo_read_actor(read_descriptor_t *desc, s
 		       page->index);
 		desc->error = -EINVAL;
 	}
-	
+
+	flush_dcache_page(p->page);
+
 	desc->count = count - size;
 	desc->written += size;
 	p->offset += size;


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
