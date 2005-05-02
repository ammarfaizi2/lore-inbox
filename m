Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVEBJoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVEBJoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 05:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVEBJoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 05:44:17 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:39042 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261174AbVEBJoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 05:44:13 -0400
Message-ID: <4275F665.1010101@yahoo.com.au>
Date: Mon, 02 May 2005 19:44:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: dino@in.ibm.com
CC: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
References: <20050501190947.GA5204@in.ibm.com>
In-Reply-To: <20050501190947.GA5204@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:

> +void rebuild_sched_domains(cpumask_t span1, cpumask_t span2)
> +{
> +	cpumask_t change_map;
> +
> +	cpus_or(change_map, span1, span2);
> +
> +	preempt_disable();

Oh, you can't do this here, attach_domains does a synchronize_kernel.
So take it out, it doesn't do anything anyway, does it?

I suggest you also use some sort of locking to prevent concurrent rebuilds
and rebuilds racing with cpu hotplug. You could probably have a static
semaphore around rebuild_sched_domains, and take lock_cpu_hotplug here too.

Or alternatively take the semaphore in the cpu hotplug notifier as well...
Maybe both - neither are performance critical code.

-- 
SUSE Labs, Novell Inc.

