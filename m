Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273711AbSISVsb>; Thu, 19 Sep 2002 17:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273712AbSISVsb>; Thu, 19 Sep 2002 17:48:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42233 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273711AbSISVsa>; Thu, 19 Sep 2002 17:48:30 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209192153.g8JLrNV23057@eng2.beaverton.ibm.com>
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async--performance numbers
To: akpm@digeo.com (Andrew Morton)
Date: Thu, 19 Sep 2002 14:53:22 -0700 (PDT)
Cc: pbadari@us.ibm.com (Badari Pulavarty), mcao@us.ibm.com (Mingming Cao),
       bcrl@redhat.com (Benjamin LaHaise), suparna@linux.ibm.com,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       lse-tech@lists.sourceforge.net
In-Reply-To: <3D8A4352.862A0B1A@digeo.com> from "Andrew Morton" at Sep 19, 2002 01:36:18 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Badari Pulavarty wrote:
> > 
> > Andrew,
> > 
> > >
> > > Thanks.  Note that the old code (which seems to be a tiny bit faster,
> > > and used less CPU as well) has a significantly higher context switch
> > > rate.  At a guess I'd say that it is more efficient at getting userspace
> > > up and running in response to IO completion.
> > >
> > 
> > I my patch, I removed bio_list. So, I do all the processing of "bio"
> > in end_io() function, instead of postpone it to waiter. Do you think
> > this matters ?
> 
> Ah.  Yes, it matters.
> 
> Running the completion in process context is nicer from an interrupt latency
> point of view.  But the completion code also runs set_page_dirty(), which
> takes locks which are not interrupt-safe.  Running set_page_dirty() from
> interrupt context can deadlock.
> 
> So if it's convenient, yes, let's do the completion in process context.
> If not convenient then we'll need to find some way of running
> set_page_dirty() outside the interrupt handler.
> 
> The set_page_dirty() is there to cover the case of direct-io into a
> mmapped region of another file.  We need to tell the VM that the page
> has been changed, because the CPU's ptes don't know that.  And we do
> have to run set_page_dirty() after the read IO has completed.

OK !! We have to find a way to do set_page_dirty() safely, I guess.

> 
> The other thing we've lost is the BIO-pruning and recycling effect: the
> current direct-io code will reap BIOs while it is actually submitting
> them, so the peak consumption is kept under control.  Plus there are
> cache-warmness issues.  But without having a process there to do all this,
> we obviously have to lose some things.
> 

I don't follow you. In original code, we only reap the BIO's on which IO 
is complete. How is it controlling peak consumption ? 

Now, I give back the BIO as and when IO is complete. So it should be better
for consumption. Isn't it ?

- Badari
