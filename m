Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273463AbSISVdc>; Thu, 19 Sep 2002 17:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273221AbSISVdC>; Thu, 19 Sep 2002 17:33:02 -0400
Received: from packet.digeo.com ([12.110.80.53]:10661 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S273463AbSISVbV>;
	Thu, 19 Sep 2002 17:31:21 -0400
Message-ID: <3D8A4352.862A0B1A@digeo.com>
Date: Thu, 19 Sep 2002 14:36:18 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Mingming Cao <mcao@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       suparna@linux.ibm.com, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async--performance numbers
References: <3D8A3D8E.4A93AD12@digeo.com> from "Andrew Morton" at Sep 19, 2002 01:11:42 PM PST <200209192119.g8JLJwl17424@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 21:36:18.0312 (UTC) FILETIME=[96B1D080:01C26024]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> Andrew,
> 
> >
> > Thanks.  Note that the old code (which seems to be a tiny bit faster,
> > and used less CPU as well) has a significantly higher context switch
> > rate.  At a guess I'd say that it is more efficient at getting userspace
> > up and running in response to IO completion.
> >
> 
> I my patch, I removed bio_list. So, I do all the processing of "bio"
> in end_io() function, instead of postpone it to waiter. Do you think
> this matters ?

Ah.  Yes, it matters.

Running the completion in process context is nicer from an interrupt latency
point of view.  But the completion code also runs set_page_dirty(), which
takes locks which are not interrupt-safe.  Running set_page_dirty() from
interrupt context can deadlock.

So if it's convenient, yes, let's do the completion in process context.
If not convenient then we'll need to find some way of running
set_page_dirty() outside the interrupt handler.

The set_page_dirty() is there to cover the case of direct-io into a
mmapped region of another file.  We need to tell the VM that the page
has been changed, because the CPU's ptes don't know that.  And we do
have to run set_page_dirty() after the read IO has completed.

The other thing we've lost is the BIO-pruning and recycling effect: the
current direct-io code will reap BIOs while it is actually submitting
them, so the peak consumption is kept under control.  Plus there are
cache-warmness issues.  But without having a process there to do all this,
we obviously have to lose some things.

Maybe, that's not very important in real life.

> > I'd say it's only likely to affect these huge linear IOs.  Once you get
> > into real workloads which are seeking and merging then a bit of latency
> > here or there would just be soaked up by other system activity.
> >
> > Ah.  The current direct-io.c uses wake_up_process(), not waitqueues.
> > So the aio version has to wear the waitqueue cost.  If you're using the
> > -mm patch I'd suggest that you convert aio.c to prepare_to_wait/finish_wait.
> > The waitqueue/wakeup costs on your 8-ways seem to be very high.
> 
> Ok !! I still use wake_up_process() for the sync case.
> I will try to use waitqueues and see.
> 

Well, you're using waitqueues now - please try the fancy new ones.
As ever, profiles will tell us what's going on.
