Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVINWRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVINWRO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVINWRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:17:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5024 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030201AbVINWRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:17:13 -0400
Date: Wed, 14 Sep 2005 15:17:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: dada1@cosmosbay.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] reorder struct files_struct
Message-Id: <20050914151701.3841dd01.akpm@osdl.org>
In-Reply-To: <20050914220205.GC6237@in.ibm.com>
References: <20050914191842.GA6315@in.ibm.com>
	<20050914.125750.05416211.davem@davemloft.net>
	<20050914201550.GB6315@in.ibm.com>
	<20050914.132936.105214487.davem@davemloft.net>
	<43289376.7050205@cosmosbay.com>
	<20050914220205.GC6237@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> > --- linux-2.6.14-rc1/include/linux/file.h	2005-09-13 05:12:09.000000000 +0200
> > +++ linux-2.6.14-rc1-ed/include/linux/file.h	2005-09-15 01:09:13.000000000 +0200
> > @@ -34,12 +34,12 @@
> >   */
> >  struct files_struct {
> >          atomic_t count;
> > -        spinlock_t file_lock;     /* Protects all the below members.  Nests inside tsk->alloc_lock */
> >  	struct fdtable *fdt;
> >  	struct fdtable fdtab;
> >          fd_set close_on_exec_init;
> >          fd_set open_fds_init;
> >          struct file * fd_array[NR_OPEN_DEFAULT];
> > +	spinlock_t file_lock;     /* Protects concurrent writers.  Nests inside tsk->alloc_lock */
> >  };
> >  
> >  #define files_fdtable(files) (rcu_dereference((files)->fdt))
> 
> For most apps without too many open fds, the embedded fd_sets
> are going to be used. Wouldn't that mean that open()/close() will
> invalidate the cache line containing fdt, fdtab by updating
> the fd_sets ? If so, you optimization really doesn't help.

Guys, this is benchmarkable.  fget() is astonishingly high in some
profiles - it's worth investigating.
