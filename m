Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVCDAOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVCDAOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVCDANq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:13:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:25299 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262683AbVCDAJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:09:02 -0500
Date: Thu, 3 Mar 2005 16:08:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
       scalability@gelato.org
Subject: Re: [PATCH] Fixing address space lock contention in 2.6.11
Message-Id: <20050303160849.0b80be76.akpm@osdl.org>
In-Reply-To: <20050302184653.3ea8e29d.akpm@osdl.org>
References: <16934.28560.325928.858464@berry.gelato.unsw.EDU.AU>
	<20050302184653.3ea8e29d.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
> >
> > 
> > Hi,
> > 	As part of the Gelato scalability focus group, we've been running
> > OSDL's Re-AIM7 benchmark with an I/O intensive load with varying
> > numbers of processors.  The current kernel shows severe contention on
> > the tree_lock in the address space structure when running on tmpfs or
> > ext2 on a RAM disk.
> > 
> 
> Yup.
> 
> Problem is, an rwlock is a little bit slower than a spinlock on a P4 due to
> the buslocked unlock, and a lot of people have p4's.
> 
> Could you do some testing on a 2-way p4?

hm, turns out I did some P4 testing ages ago:

with:

dd if=/dev/zero of=foo bs=1 count=2M  0.80s user 4.15s system 99% cpu 4.961 total
dd if=/dev/zero of=foo bs=1 count=2M  0.73s user 4.26s system 100% cpu 4.987 total
dd if=/dev/zero of=foo bs=1 count=2M  0.79s user 4.25s system 100% cpu 5.034 total

dd if=foo of=/dev/null bs=1  0.80s user 3.12s system 99% cpu 3.928 total
dd if=foo of=/dev/null bs=1  0.77s user 3.15s system 100% cpu 3.914 total
dd if=foo of=/dev/null bs=1  0.92s user 3.02s system 100% cpu 3.935 total

(3.926: 1.87 usecs)

without:

dd if=/dev/zero of=foo bs=1 count=2M  0.85s user 3.92s system 99% cpu 4.780 total
dd if=/dev/zero of=foo bs=1 count=2M  0.78s user 4.02s system 100% cpu 4.789 total
dd if=/dev/zero of=foo bs=1 count=2M  0.82s user 3.94s system 99% cpu 4.763 total
dd if=/dev/zero of=foo bs=1 count=2M  0.71s user 4.10s system 99% cpu 4.810 tota

dd if=foo of=/dev/null bs=1  0.76s user 2.68s system 100% cpu 3.438 total
dd if=foo of=/dev/null bs=1  0.74s user 2.72s system 99% cpu 3.465 total
dd if=foo of=/dev/null bs=1  0.67s user 2.82s system 100% cpu 3.489 total
dd if=foo of=/dev/null bs=1  0.70s user 2.62s system 99% cpu 3.326 total

(3.430: 1.635 usecs)


So the spinlock->rwlock conversion costs us 240 nsecs on a one-byte-write.
