Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVCIXy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVCIXy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVCIXOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:14:31 -0500
Received: from one.firstfloor.org ([213.235.205.2]:41383 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262431AbVCIW4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:56:16 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page Fault Scalability patch V19 [4/4]: Drop use of
 page_table_lock in do_anonymous_page
References: <20050309201324.29721.28956.sendpatchset@schroedinger.engr.sgi.com>
	<20050309201344.29721.26698.sendpatchset@schroedinger.engr.sgi.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 09 Mar 2005 23:56:14 +0100
In-Reply-To: <20050309201344.29721.26698.sendpatchset@schroedinger.engr.sgi.com> (Christoph
 Lameter's message of "Wed, 9 Mar 2005 12:13:44 -0800 (PST)")
Message-ID: <m13bv4whrl.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:

> Do not use the page_table_lock in do_anonymous_page. This will significantly
> increase the parallelism in the page fault handler in SMP systems. The patch
> also modifies the definitions of _mm_counter functions so that rss and anon_rss
> become atomic.

I still think it's a bad idea to add arbitary process size limits like this:

>  
> +#ifdef CONFIG_ATOMIC_TABLE_OPS
> +/*
> + * Atomic page table operations require that the counters are also
> + * incremented atomically
> +*/
> +#define set_mm_counter(mm, member, value) atomic_set(&(mm)->member, value)
> +#define get_mm_counter(mm, member) ((unsigned long)atomic_read(&(mm)->member))
> +#define update_mm_counter(mm, member, value) atomic_add(value, &(mm)->member)
> +#define MM_COUNTER_T atomic_t

Can you use atomic64_t on 64bit systems at least? 

-Andi
