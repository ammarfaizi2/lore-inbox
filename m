Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVINW5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVINW5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVINW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:57:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:65489 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965089AbVINW5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:57:43 -0400
Date: Thu, 15 Sep 2005 04:20:43 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] reorder struct files_struct
Message-ID: <20050914225043.GD6237@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050914191842.GA6315@in.ibm.com> <20050914.125750.05416211.davem@davemloft.net> <20050914201550.GB6315@in.ibm.com> <20050914.132936.105214487.davem@davemloft.net> <43289376.7050205@cosmosbay.com> <20050914220205.GC6237@in.ibm.com> <4328A73B.1080801@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4328A73B.1080801@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 12:42:03AM +0200, Eric Dumazet wrote:
> Dipankar Sarma a écrit :
> >On Wed, Sep 14, 2005 at 11:17:42PM +0200, Eric Dumazet wrote:
> >
> >>--- linux-2.6.14-rc1/include/linux/file.h	2005-09-13 
> >>05:12:09.000000000 +0200
> >>+++ linux-2.6.14-rc1-ed/include/linux/file.h	2005-09-15 
> >>01:09:13.000000000 +0200
> >>@@ -34,12 +34,12 @@
> >> */
> >>struct files_struct {
> >>        atomic_t count;
> >>-        spinlock_t file_lock;     /* Protects all the below members.  
> >>Nests inside tsk->alloc_lock */
> >>	struct fdtable *fdt;
> >>	struct fdtable fdtab;
> >>        fd_set close_on_exec_init;
> >>        fd_set open_fds_init;
> >>        struct file * fd_array[NR_OPEN_DEFAULT];
> >>+	spinlock_t file_lock;     /* Protects concurrent writers.  Nests 
> >>inside tsk->alloc_lock */
> >>};
> >>
> >>#define files_fdtable(files) (rcu_dereference((files)->fdt))
> >
> >
> >For most apps without too many open fds, the embedded fd_sets
> >are going to be used. Wouldn't that mean that open()/close() will
> >invalidate the cache line containing fdt, fdtab by updating
> >the fd_sets ? If so, you optimization really doesn't help.
> >
> 
> If the embedded struct fdtable is used, then the only touched field is 
> 'next_fd', so we could also move this field at the end of 'struct fdtable'
> 

Not just embedded fdtable, but also the embedded fdsets. I would expect
count, fdt, fdtab and the fdsets to fit into one cache line in 
some archs.


> But I wonder if 'next_fd' really has to be in 'struct fdtable', maybe it 
> could be moved to 'struct files_struct' close to file_lock ?

next_fd has to be in struct fdtable. It needs to be consistent
with whichever fdtable a lock-free reader sees.

> 
> If yes, the whole embedded struct fdtable is readonly.

But not close_on_exec_init or open_fds_init. We would update them
on open/close.

Some benchmarking would be useful here.

Thanks
Dipankar
