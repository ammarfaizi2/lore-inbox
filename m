Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTDWVYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264230AbTDWVYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:24:33 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:35232 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264190AbTDWVYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:24:32 -0400
Message-ID: <3EA70761.5090306@google.com>
Date: Wed, 23 Apr 2003 14:36:33 -0700
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG 2.4.18-2.4.21-pre5 at least]: MM vmscan doesn't free buffer
 heads under memory pressure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I reproduced this problem in 2.4.18 and visually verified it in 
2.4.21-pre5.  I haven't look at any other kernels.

Buffer Heads tend to be allocated in low memory (SLAB_NOFS) but point to 
pages in high memory.  If low memory is under heavy pressure, but high 
memory is not, then buffer heads in low memory that point to buffers in 
high memory are never freed.  This can cause OOM errors when there is 
still plenty of memory and plenty of buffer heads that could be easily 
freed.

Addint the following while loop to 
try_to_free_pages/try_to_free_pages_zone and trying to free pages again 
seems to alleviate the problem.

    Ross



                /* Problem, we couldn't free up the memory we want.
                   Currently buffer heads all end up in lowmem, so
                   we may be able to free up some low mem by freeing
                   up some highmem.  Try to do that. */
                while (pgdat) {
                        for (zone = pgdat->node_zones + MAX_NR_ZONES-1;
                             zone > classzone &&
                             zone >= pgdat->node_zones ;
                             zone--) {
                                shrink_caches(zone, priority, gfp_mask,
                                              nr_pages *
                                              (PAGE_SIZE /
                                               sizeof(struct 
buffer_head) + 1)
                                              * 8);
                        }
                        pgdat = pgdat->node_next;
                }


