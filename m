Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161410AbWBUGbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161410AbWBUGbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161411AbWBUGbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:31:21 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:4693 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161410AbWBUGbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:31:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=RY5v+rSc49mQ8sBlVS2+j8r8n+POJrqmI20ixHjsJTckZoQT1apliT590bwV/zBKdbAuVDp3sKeGvOu5YdddVeLvlZj1FQ8uPR8YzaLvzNRlmOUT9DyZ5VwCd6JT7GbAIniciruirvGZbWdnAaP+cSd7xH4Ahtnmp0kVBZnLLxs=  ;
Message-ID: <43FA8938.70006@yahoo.com.au>
Date: Tue, 21 Feb 2006 14:30:00 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [patch] Cache align futex hash buckets
References: <20060220233242.GC3594@localhost.localdomain>
In-Reply-To: <20060220233242.GC3594@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> Following change places each element of the futex_queues hashtable on a 
> different cacheline.  Spinlocks of adjacent hash buckets lie on the same 
> cacheline otherwise.
> 

It does not make sense to add swaths of unused memory into a hashtable for
this purpose, does it?

For a minimal, naive solution you just increase the size of the hash table.
This will (given a decent hash function) provide the same reduction in
cacheline contention, while also reducing collisions.

A smarter solution might have a single lock per cacheline, and multiple hash
slots. This could make the indexing code a bit more awkward though.

> Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> Signed-off-by: Shai Fultheim <shai@scalex86.org>
> 
> Index: linux-2.6.16-rc2/kernel/futex.c
> ===================================================================
> --- linux-2.6.16-rc2.orig/kernel/futex.c	2006-02-07 23:14:04.000000000 -0800
> +++ linux-2.6.16-rc2/kernel/futex.c	2006-02-09 14:04:22.000000000 -0800
> @@ -100,9 +100,10 @@ struct futex_q {
>  struct futex_hash_bucket {
>         spinlock_t              lock;
>         struct list_head       chain;
> -};
> +} ____cacheline_internodealigned_in_smp;
>  
> -static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
> +static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS] 
> +				__cacheline_aligned_in_smp;
>  
>  /* Futex-fs vfsmount entry: */
>  static struct vfsmount *futex_mnt;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
