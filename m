Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbVCJSlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVCJSlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVCJSgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:36:06 -0500
Received: from fmr21.intel.com ([143.183.121.13]:7319 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262883AbVCJSb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:31:28 -0500
Message-Id: <200503101831.j2AIV2g03286@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Thu, 10 Mar 2005 10:31:02 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUlJwozZgLgZ8X2TqK24ZIi3BahXwAGOCaw
In-Reply-To: <20050309200936.0b1bea9e.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, March 09, 2005 8:10 PM
> > 2.6.9 kernel is 6% slower compare to distributor's 2.4 kernel (RHEL3).  Roughly
> > 2% came from storage driver (I'm not allowed to say anything beyond that, there
> > is a fix though).
>
> The codepaths are indeed longer in 2.6.

Thank you for acknowledging this.


> > 2% came from DIO.
>
> hm, that's not a lot.
> ....
> 2% is pretty thin :(

This is the exact reason that I did not want to put these numbers out
in the first place. Because most people usually underestimate the
magnitude of these percentage point.

Now I have to give a speech on "performance optimization 101".  Take a
look at this page: http://www.suse.de/~aj/SPEC/CINT/d-permanent/index.html
This page tracks the development of gcc and measures the performance of
gcc with SPECint2000.  Study the last chart, take out your calculator
and calculate how much performance gain gcc made over the course of 3.5
years of development.  Also please factor in the kind of man power that
went into the compiler development.

Until people understand the kind of scale to expect when evaluating a
complex piece of software, then we can talk about database transaction
processing benchmark.  This benchmark goes one step further.  It bench
the entire software stack (kernel/library/application/compiler), it bench
the entire hardware platform (cpu/memory/IO/chipset) and on the grand
scale, it bench system integration: storage, network, interconnect, mid-
tier app server, front end clients, etc etc.  Any specific function/
component only represent a small portion of the entire system, essential
but small. For example, the hottest function in the kernel is 7.5%, out
of 20% kernel time. If we throw away that function entirely, there will
be only 1.5% direct impact on total cpu cycles.

So what's the point?  The point is when judging a number whether it is
thin or thick, it has to be judged against the complexity of SUT.  It
has to be judged against a relevant scale for that particular workload.
And the scale has to be laid out correctly that represents the weight
of each component.

Losing 6% just from Linux kernel is a huge deal for this type of benchmark.
People work for days to implement features which might give sub percentage
gain.  Making Software run faster is not easy, but making software run slower
apparently is a fairly easy task.



> Fine-grained alignment is probably too hard, and it should fall back to
> __blockdev_direct_IO().
>
> Does it do the right thing with a request which is non-page-aligned, but
> 512-byte aligned?
>
> readv and writev?
>

That's why direct_io_worker() is slower.  It does everything and handles
every possible usage scenarios out there.  I hope making the function fatter
is not in the plan.

- Ken


