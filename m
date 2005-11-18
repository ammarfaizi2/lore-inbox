Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbVKRToj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbVKRToj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbVKRToj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:44:39 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:24582 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1161124AbVKRToi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:44:38 -0500
Message-ID: <437E2F22.6000809@argo.co.il>
Date: Fri, 18 Nov 2005 21:44:34 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
References: <437E2C69.4000708@us.ibm.com>
In-Reply-To: <437E2C69.4000708@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2005 19:44:36.0793 (UTC) FILETIME=[81CE2A90:01C5EC78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:

>We have a clustering product that needs to be able to guarantee that the
>networking system won't stop functioning in the case of OOM/low memory
>condition.  The current mempool system is inadequate because to keep the
>whole networking stack functioning, we need more than 1 or 2 slab caches to
>be guaranteed.  We need to guarantee that any request made with a specific
>flag will succeed, assuming of course that you've made your "critical page
>pool" big enough.
>
>The following patch series implements such a critical page pool.  It
>creates 2 userspace triggers:
>
>/proc/sys/vm/critical_pages: write the number of pages you want to reserve
>for the critical pool into this file
>
>/proc/sys/vm/in_emergency: write a non-zero value to tell the kernel that
>the system is in an emergency state and authorize the kernel to dip into
>the critical pool to satisfy critical allocations.
>
>We mark critical allocations with the __GFP_CRITICAL flag, and when the
>system is in an emergency state, we are allowed to delve into this pool to
>satisfy __GFP_CRITICAL allocations that cannot be satisfied through the
>normal means.
>
>  
>
1. If you have two subsystems which allocate critical pages, how do you 
protect against the condition where one subsystem allocates all the 
critical memory, causing the second to oom?

2. There already exists a critical pool: ordinary allocations fail if 
free memory is below some limit, but special processes (kswapd) can 
allocate that memory by setting PF_MEMALLOC. Perhaps this should be 
extended, possibly with a per-process threshold.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

