Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317997AbSGZSpa>; Fri, 26 Jul 2002 14:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317999AbSGZSpa>; Fri, 26 Jul 2002 14:45:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4370 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317997AbSGZSp2>;
	Fri, 26 Jul 2002 14:45:28 -0400
Message-ID: <3D41990A.EDC1A530@zip.com.au>
Date: Fri, 26 Jul 2002 11:46:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
References: <20020726204033.D18570@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> 
> Here is a Scalable statistics counter implementation which works on top
> of the kmalloc_percpu dynamic allocator published by Dipankar.
> This patch is against 2.5.27.
> 
> ...
> +static inline int __statctr_init(statctr_t *stctr)
> +{
> +       stctr->ctr = kmalloc_percpu(sizeof(*(stctr->ctr)), GFP_ATOMIC);
> +       if(!stctr->ctr)
> +               return -1;
> +       return 0;
> +}

Minor nit: please force the caller to pass in the gfp_flags when
designing an API like this.  The fact that you were forced to use
GFP_ATOMIC here shows why...

> +       for( i=0; i < NR_CPUS; i++ )
> +               res += *per_cpu_ptr(stctr->ctr, i);
> +       return res;
> +}

Oh dear.  Most people only have two CPUs.

Rusty, can we *please* fix this?  Really soon?


General comment:  we need to clean up the kernel_stat stuff.  We
cannot just make it per-cpu because it is 32k in size already.  I
would suggest that we should break out the disk accounting and
make the rest of kernel_stat per CPU.

That would be a great application of your interface, and a good
way to get your interface merged ;)  Is that something which you
have time to do?

Thanks.
