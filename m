Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbVINWHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVINWHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVINWHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:07:37 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42150 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965058AbVINWHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:07:36 -0400
Date: Thu, 15 Sep 2005 03:32:05 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] reorder struct files_struct
Message-ID: <20050914220205.GC6237@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050914191842.GA6315@in.ibm.com> <20050914.125750.05416211.davem@davemloft.net> <20050914201550.GB6315@in.ibm.com> <20050914.132936.105214487.davem@davemloft.net> <43289376.7050205@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43289376.7050205@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 11:17:42PM +0200, Eric Dumazet wrote:
> In SMP (and NUMA) environnements, each time a thread wants to open or close 
> a file, it has to acquire the spinlock, thus invalidating the cache line 
> containing this spinlock on other CPUS. So other threads doing 
> read()/write()/... calls that use RCU to access the file table are going to 
> ask further memory (possibly NUMA) transactions to read again this memory 
> line.
> 
> Please consider applying this patch. It moves the spinlock to another cache 
> line, so that concurrent threads can share the cache line containing 
> 'count' and 'fdt' fields.
> 
> --- linux-2.6.14-rc1/include/linux/file.h	2005-09-13 05:12:09.000000000 +0200
> +++ linux-2.6.14-rc1-ed/include/linux/file.h	2005-09-15 01:09:13.000000000 +0200
> @@ -34,12 +34,12 @@
>   */
>  struct files_struct {
>          atomic_t count;
> -        spinlock_t file_lock;     /* Protects all the below members.  Nests inside tsk->alloc_lock */
>  	struct fdtable *fdt;
>  	struct fdtable fdtab;
>          fd_set close_on_exec_init;
>          fd_set open_fds_init;
>          struct file * fd_array[NR_OPEN_DEFAULT];
> +	spinlock_t file_lock;     /* Protects concurrent writers.  Nests inside tsk->alloc_lock */
>  };
>  
>  #define files_fdtable(files) (rcu_dereference((files)->fdt))

For most apps without too many open fds, the embedded fd_sets
are going to be used. Wouldn't that mean that open()/close() will
invalidate the cache line containing fdt, fdtab by updating
the fd_sets ? If so, you optimization really doesn't help.


Thanks
Dipankar

