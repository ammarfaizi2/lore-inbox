Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWFBU77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWFBU77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWFBU77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:59:59 -0400
Received: from mga03.intel.com ([143.182.124.21]:10379 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030257AbWFBU76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:59:58 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="45249206:sNHT6771377319"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>, "'Chris Mason'" <mason@suse.com>,
       "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 13:59:21 -0700
Message-ID: <000101c68687$6d0f8b40$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGLg/XNlAJSbIOREKZ+znq+SIBEAAWJ3Ng
In-Reply-To: <200606022019.29023.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Friday, June 02, 2006 3:19 AM
> On Friday 02 June 2006 18:28, Nick Piggin wrote:
> > Con Kolivas wrote:
> > > On Friday 02 June 2006 17:53, Nick Piggin wrote:
> > >>This is a small micro-optimisation / cleanup we can do after
> > >>smtnice gets converted to use trylocks. Might result in a little
> > >>less cacheline footprint in some cases.
> > >
> > > It's only dependent_sleeper that is being converted in these patches. The
> > > wake_sleeping_dependent component still locks all runqueues and needs to
> >
> > Oh I missed that.
> >
> > > succeed in order to ensure a task doesn't keep sleeping indefinitely.
> > > That
> >
> > Let's make it use trylocks as well. wake_priority_sleeper should ensure
> > things don't sleep forever I think? We should be optimising for the most
> > common case, and in many workloads, the runqueue does go idle frequently.
> 
> wake_priority_sleeper is only called per tick which can be 10ms at 100HZ. I 
> don't think that's fast enough. It could even be possible for a lower 
> priority task to always just miss the wakeup if it's (very) unlucky.


I see inconsistency here: in dependent_sleeper() function, you argued dearly
that it is important to be bully for the high priority task to kick off low
priority task on the sibling CPU.  Here you are arguing dearly to put the
delayed low priority sleeper back onto the CPU as early as possible (and it
would possibly competing with the other high priority task).  Having such
biased opposite treatment in different path doesn't look correct to me.

