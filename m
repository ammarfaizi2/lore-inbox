Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSHGI6j>; Wed, 7 Aug 2002 04:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSHGI6j>; Wed, 7 Aug 2002 04:58:39 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:35085 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317264AbSHGI6i>; Wed, 7 Aug 2002 04:58:38 -0400
Date: Wed, 7 Aug 2002 10:02:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [Lse-tech] [patch] Scalable statistics counters with /proc reporting
Message-ID: <20020807100216.A27321@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
	Andrew Morton <akpm@zip.com.au>,
	Rik van Riel <riel@conectiva.com.br>
References: <20020807142227.B12301@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020807142227.B12301@in.ibm.com>; from kiran@in.ibm.com on Wed, Aug 07, 2002 at 02:22:27PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 02:22:27PM +0530, Ravikiran G Thirumalai wrote:
> Here's the new statctr patch (2.5.29) on top of kmalloc_percpu dynamic 
> allocator.  This one passes GFP_ flags for statctr_init  as suggested by
> Andrew Morton and makes use of cpu_possible. Counters can be grouped into 
> one or multiple /proc files as per Rik's suggestion. 
> Here are the revised interfaces:
> 
> 1. struct statctr_proc_entry
>    *create_statctr_proc_entry(struct proc_dir_entry *parent, const char *name); 
>    To create a /proc file to group counters for automatic /proc reporting
> 
> 2. free_statctr_proc_entry(struct statctr_proc_entry *)
> 
>    To free up the proc entry
> 
> 3. int statctr_init(statctr_t *stctr, unsigned long val,
>                  struct statctr_proc_entry *pentry,
>                  const char *ctrname, int flags)
>    
>    Allocates memory to the counter , initialises it, and links the counter 
>    with statctr_proc_entry for automatic /proc reporting. ctrname is the
>    counter label as it appears in /proc, flags are the GFP_ hints.
>    /proc reporting can be turned off if pentry is NULL.

What about a general s/_proc//g for the API?

For statctr_init the flags argument would much better be named gfp_mask,
the val argument should be removed and the counter initialized to zero
by default - that's 90% of the uses..

Also the /proc-based implementation is really ugly.  It should be moved
over to the seq_file interface at least, a simple ramfs-style own
filesystem ("stats" filesystem type) would be the cleanest solution.

