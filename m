Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273029AbSISVGr>; Thu, 19 Sep 2002 17:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273057AbSISVGr>; Thu, 19 Sep 2002 17:06:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:62883 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S273029AbSISVGq>;
	Thu, 19 Sep 2002 17:06:46 -0400
Message-ID: <3D8A3D8E.4A93AD12@digeo.com>
Date: Thu, 19 Sep 2002 14:11:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mingming Cao <mcao@us.ibm.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, suparna@linux.ibm.com,
       badari@beaverton.ibm.com, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async--performance numbers
References: <OFA7076911.0B671E1D-ON87256C39.00691995@boulder.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 21:11:42.0893 (UTC) FILETIME=[2746BDD0:01C26021]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao wrote:
> 
> Hi Ben & Andrew,
> 
> I run sync raw I/O tests and Narasimha's async I/O tests on a 8 way PIII to
> measure the I/O performance before/after the dio async patch.  All the
> tests (sync and async) did 4000 * 256K I/O on 40 disks.
> 
> Basically, sync RAW read/write performance has no affect with the dio async
> patch. Async I/O seems to be slower than the sync I/O.  Async RAW I/O got
> better performance when the queue length for io_submit() is set to be 4.
> 
> I measured the time per test.  vmstat infos are also listed below.
> 

Thanks.  Note that the old code (which seems to be a tiny bit faster,
and used less CPU as well) has a significantly higher context switch
rate.  At a guess I'd say that it is more efficient at getting userspace
up and running in response to IO completion.

I'd say it's only likely to affect these huge linear IOs.  Once you get
into real workloads which are seeking and merging then a bit of latency
here or there would just be soaked up by other system activity.

Ah.  The current direct-io.c uses wake_up_process(), not waitqueues.
So the aio version has to wear the waitqueue cost.  If you're using the
-mm patch I'd suggest that you convert aio.c to prepare_to_wait/finish_wait.
The waitqueue/wakeup costs on your 8-ways seem to be very high.
