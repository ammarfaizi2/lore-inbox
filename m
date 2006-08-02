Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWHBBJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWHBBJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 21:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWHBBJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 21:09:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42695 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750926AbWHBBJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 21:09:26 -0400
Date: Tue, 1 Aug 2006 21:09:15 -0400
From: Dave Jones <davej@redhat.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: arjan@infradead.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: deprecate and convert some sleep_on variants.
Message-ID: <20060802010915.GC22589@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nish Aravamudan <nish.aravamudan@gmail.com>, arjan@infradead.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20060801180643.GD22240@redhat.com> <29495f1d0608011120j8103c5bwd169367ee2d67bc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d0608011120j8103c5bwd169367ee2d67bc0@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 01:20:28PM -0500, Nish Aravamudan wrote:

 > >+  wait_queue_t __wait;
 > >+
 > >+  init_waitqueue_entry(&__wait, current);
 > >
 > >   spin_lock_irqsave(&Controller->queue_lock, flags);
 > >   while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
 > >@@ -6314,11 +6317,18 @@ static boolean DAC960_V2_ExecuteUserComm
 > >                                        .SegmentByteCount =
 > >            CommandMailbox->ControllerInfo.DataTransferSize;
 > >          DAC960_ExecuteCommand(Command);
 > >+         add_wait_queue(&Controller->CommandWaitQueue, &__wait);
 > >+         set_current_state(TASK_UNINTERRUPTIBLE);
 > 
 > Could this use prepare_to_wait()

Maybe, though I'd rather not do that conversion with the hardware to test it.
sidenote: prepare_to_wait() and friends could really use some kerneldoc explaining
their purpose rather than their internal workings.

 > >          while 
 > >          (Controller->V2.NewControllerInformation->PhysicalScanActive)
 > >            {
 > >              DAC960_ExecuteCommand(Command);
 > >-             sleep_on_timeout(&Controller->CommandWaitQueue, HZ);
 > >+             schedule_timeout(HZ);
 > >+             set_current_state(TASK_UNINTERRUPTIBLE);
 > 
 > and schedule_timeout_uninterruptible() (which is redundant for the
 > first invocation, I suppose)

Makes sense.

 > >+         current->state = TASK_RUNNING;
 > >+         remove_wait_queue(&Controller->CommandWaitQueue, &__wait);
 > 
 > and finish_wait()?
 > 
 > Same for ibmtr.c ?

Same comments as above.

 > Also, would these changes:
 > 
 > >diff -urNp --exclude-from=/home/davej/.exclude 
 > >linux-1060/include/linux/wait.h linux-1070/include/linux/wait.h
 > >--- linux-1060/include/linux/wait.h
 > >+++ linux-1070/include/linux/wait.h
 > 
 > Be better in a separate patch?

A split-up patchset would for sure make sense for committing upstream.
Though, at least each file touched here is a separate cset.

		Dave

-- 
http://www.codemonkey.org.uk
