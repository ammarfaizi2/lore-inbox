Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVIOJlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVIOJlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVIOJlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:41:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12501 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932390AbVIOJlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:41:02 -0400
Date: Thu, 15 Sep 2005 15:05:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] reorder struct files_struct
Message-ID: <20050915093518.GB5168@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050914.125750.05416211.davem@davemloft.net> <20050914201550.GB6315@in.ibm.com> <20050914.132936.105214487.davem@davemloft.net> <43289376.7050205@cosmosbay.com> <20050914220205.GC6237@in.ibm.com> <4328A73B.1080801@cosmosbay.com> <20050914225043.GD6237@in.ibm.com> <4328B013.1010400@cosmosbay.com> <20050915045440.GE6237@in.ibm.com> <43291204.9060208@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43291204.9060208@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 08:17:40AM +0200, Eric Dumazet wrote:
> Dipankar Sarma a écrit :
> >On Thu, Sep 15, 2005 at 01:19:47AM +0200, Eric Dumazet wrote:
> >
> >Those fdsets would share a cache line with fdt, fdtable which would
> >be invalidated on open/close. So, what is the point in moving
> >file_lock ?
> >
> 
> The point is that we gain nothing in this case for 32 bits platforms, but 
> we gain something on 64 bits platform. And for apps using more than 

I am not sure about that. IIRC, x86_64 has a 128-byte L1 cacheline.
So, count, fdt, fdtab, close_on_exec_init and open_fds_init would
all fit into one cache line. And close_on_exec_init will get updated
on open(). Also, most apps will not likely have more than the
default # of fds, it might not be a good idea to optimize for
that case.


> struct files_struct {
> 
> /* mostly read */
> 	atomic_t count; /* offset 0x00 */
> 	struct fdtable *fdt; /* offset 0x04 (0x08 on 64 bits) */
> 	struct fdtable fdtab; /* offset 0x08 (0x10 on 64 bits)*/
> 
> /* read/written for apps using small number of files */
> 	fd_set close_on_exec_init; /* offset 0x30 (0x58 on 64 bits) */
> 	fd_set open_fds_init; /* offset 0x34 (0x60 on 64 bits) */
> 	struct file * fd_array[NR_OPEN_DEFAULT]; /* offset 0x38 (0x68 on 64 
> 	bits */
> 	spinlock_t file_lock; /* 0xB8 (0x268 on 64 bits) */
> 	}; /* size = 0xBC (0x270 on 64 bits) */
> 
> Moving next_fd from 'struct fdtable' to 'struct files_struct' is also a win 
> for 64bits platforms since sizeof(struct fdtable) become 64 : a nice power 
> of two, so 64 bytes are allocated instead of 128.

Can you benchmark this on a higher end SMP/NUMA system ?

Thanks
Dipankar
