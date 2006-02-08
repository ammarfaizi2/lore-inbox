Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbWBHWcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWBHWcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWBHWcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:32:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965208AbWBHWcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:32:11 -0500
Date: Wed, 8 Feb 2006 17:31:54 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Eric Dumazet <dada1@cosmosbay.com>, Linus Torvalds <torvalds@g5.osdl.org>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
In-Reply-To: <200602051959.k15JxoHK001630@hera.kernel.org>
Message-ID: <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2006, Linux Kernel Mailing List wrote:

> [PATCH] percpu data: only iterate over possible CPUs

This sched.c bit breaks Xen, and probably also other architectures
that have CPU hotplug.  I suspect the reason is that during early 
bootup only the boot CPU is online, so nothing initialises the
runqueues for CPUs that are brought up afterwards.

I suspect we can get rid of this problem quite easily by moving
runqueue initialisation to init_idle()...

> diff --git a/kernel/sched.c b/kernel/sched.c
> index f77f23f..839466f 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -6109,7 +6109,7 @@ void __init sched_init(void)
>  	runqueue_t *rq;
>  	int i, j, k;
>  
> -	for (i = 0; i < NR_CPUS; i++) {
> +	for_each_cpu(i) {
>  		prio_array_t *array;
>  
>  		rq = cpu_rq(i);

-- 
All Rights Reversed
