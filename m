Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSGVFJJ>; Mon, 22 Jul 2002 01:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSGVFJI>; Mon, 22 Jul 2002 01:09:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24073 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316204AbSGVFJI>;
	Mon, 22 Jul 2002 01:09:08 -0400
Message-ID: <3D3B960C.C56D4FE2@zip.com.au>
Date: Sun, 21 Jul 2002 22:20:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] low-latency zap_page_range
References: <mailman.1027196701.28591.linux-kernel2news@redhat.com> <200207210247.g6L2lXE13782@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > The lock hold time in zap_page_range is horrid.  This patch breaks the
> > work up into chunks and relinquishes the lock after each iteration.
> > This drastically lowers latency by creating a preemption point, as well
> > as lowering lock contention.
> 
> >  void zap_page_range(struct vm_area_struct *vma, unsigned long address, unsigned long size)
> 
> Arjan sent me something similar, done by AKPM, only he did this a
> little differently. He added an argument to zap_page_range
> which allowed to work it in the old way, if set. Then, he set it so
> all places would use low latency EXCEPT a reading from /dev/zero.
> I assume it was some locking somewhere in devices/char/mem.c,
> though I was unable to figure which in particular.
> 

There are actually quite a few places in the ll patch which don't
pass ZPR_COND_RESCHED into zap_page_range.  Places which are
themselves called under locks, places where not enough pages
are being zapped to make it necessary, etc. vmtruncate_list,
some mremap code, others.

Plus some historical notes: there used to be a couple more
flags which could be passed into zap_page_range() to tell
it whether to run flush_cache_range and flush_tlb_range.  That
was an irrelevant cleanup.  But those calls were later unconditionally
sucked into zap_page_range() anyway.

-
