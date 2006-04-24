Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWDXRst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDXRst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWDXRss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:48:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:19859 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750930AbWDXRsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:48:47 -0400
Subject: Re: [PATCH 1/2] ext3 percpu counter fixes to suppport for more
	than 2**31 ext3 free blocks counter
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: kiran@scalex86.org, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060421150943.2fdc5c4a.akpm@osdl.org>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
	 <1145631546.4478.10.camel@localhost.localdomain>
	 <20060421150943.2fdc5c4a.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 24 Apr 2006 10:48:32 -0700
Message-Id: <1145900913.4820.14.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 15:09 -0700, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > The following patches are to fix the percpu counter issue support more
> > than 2**31 blocks for ext3, i.e. allow the ext3 free block accounting
> > works with more than 8TB storage.
> > 
> > [PATCH 1] - Generic perpcu longlong type counter support: global counter
> > type changed from long to long long. The local counter is still remains
> > 32 bit (long type), so we could avoid doing 64 bit update in most cases.
> > Fixed the percpu_counter_read_positive() to handle the  0 value counter
> > correctly;Add support to initialize the global counter to a value that
> > are greater than 2**32.
> 
> I think it would be saner to explicitly specify the size of the field. 
> That means using s32 and s64 throughout this code.
> 

Agree. Will use s64 in this code. As s32 has the same issue with what we
have(unsigned long) on 32 bit machine today: it is not enough for ext3
to support more than 2**31 free blocks, and also obviously not enough
for 64 bit ext3 that Laurent is working on.

> That'll actually save space on 64-bit machines, where we're presently doing
> alloc_percpu(long) when all we need is alloc_percpu(s32).
> 
> We'd need to review all users of this interface to make sure that they
> handle the changed sizes appropriately, too.

I looked at the all users of percpu counter that are currently in
mainline(2.6.17-rc1) and in mm tree(2.6.17-rc1-mm2), they are:

1. ext2 free blocks/inodes/dirs 
	(int type, to be changed to unsinged long)
2. ext3 free blocks/inodes/dirs 
	(int type, changing to unsigned long or unsigned long long)
3. nr_files 
	(currently int type)
4. decnet_memory allocated 
	(was atomic_t type in mainline, changed to percpu counter type in mm)
5. tcp_memory allocated 
	(was atomic_t type, changed to percpu counter type in mm tree)

I could be wrong, but I think there will be no effect to change the size
of the global counter from "long" to s64 for above percpu counter users,
except gives the counter more room to grow. Kiran, what do you think?
Did I miss any other users of the perpcu counters? 

Mingming

