Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWGZGDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWGZGDI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWGZGDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:03:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030259AbWGZGDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:03:06 -0400
Date: Tue, 25 Jul 2006 23:02:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/2] CPU hotplug compatible alloc_percpu
Message-Id: <20060725230259.f5a27306.akpm@osdl.org>
In-Reply-To: <1153761414.2986.136.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1153761414.2986.136.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 19:16:54 +0200
Martin Peschke <mp3@de.ibm.com> wrote:

> This patch splits alloc_percpu() up into two phases. Likewise for
> free_percpu(). This allows clients to limit initial allocations to
> online cpu's, and to populate or depopulate per-cpu data at run time as
> needed:
> 
>   struct my_struct *obj;
> 
>   /* initial allocation for online cpu's */
>   obj = percpu_alloc(sizeof(struct my_struct), GFP_KERNEL);
> 
>   ...
> 
>   /* populate per-cpu data for cpu coming online */
>   ptr = percpu_populate(obj, sizeof(struct my_struct), GFP_KERNEL, cpu);
> 
>   ...
> 
>   /* access per-cpu object */
>   ptr = percpu_ptr(obj, smp_processor_id());
> 
>   ...
> 
>   /* depopulate per-cpu data for cpu going offline */
>   percpu_depopulate(obj, cpu);
> 
>   ...
> 
>   /* final removal */
>   percpu_free(obj);

That looks pretty thorough.

The one little nit I'd have is that the code passes cpumasks by value.  See
the tricks in <linux/cpumask.h> which pretend to take the caller's cpumask
by value but which instead pass it via const reference to the callee.

CONFIG_NR_CPUS=1024 leads to a 128-byte cpumask_t.  It's worth doing.
