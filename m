Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265168AbUELSu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUELSu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbUELSuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:50:44 -0400
Received: from web80508.mail.yahoo.com ([66.218.79.78]:4732 "HELO
	web80508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265168AbUELSu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:50:26 -0400
Message-ID: <20040512185026.28373.qmail@web80508.mail.yahoo.com>
Date: Wed, 12 May 2004 11:50:26 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: Why pass pt_regs throughout the input system?
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, vojtech@suze.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

First off sorry for breaking the thread but I am insteresed in the
topic and writing this mail via a web-based interface.

> On Wed, 12 May 2004 10:40:56 +0200
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > Ask David S. Miller for details - I think the problem was with
> > simultaneous invocation of multiple pt_regs printouts.
> 
> That's correct, if i'm using multiple keyboards (say one i8042 based
> and one USB based) in order to get fancy debugging dumps, any scheme
> that saves away info at interrupt time simply will be inaccurate and
> not work.

I understand that but is the keyboard interrupt data is the most
interesting? I thought that the "middle" part of the call trace is
much more important as it shows what is happening to the system.
Or am I missing something?

As far as multiple keyboards issue going - SysRq is a debug tool and
I relly do not see you hitting SysRq on the two keyboards at the very
same time to mess up the call traces.

Anyway, my "problem" is the following: SysRq register dump and call
trace require keyboard.c event handler to be caled from hard interrupt
context which is not always feasible. If it is called from a tasklet
even if I save registers I will not be able to reconstruct the call
trace. I wonder if the following change is acceptable:

- SysRq posts a request for registers and call trace to be printed
- When next interrupt comes in (any interrupt) do_IRQ will check the
  flag and print registes and the trace. The check can be made pretty
  cheap as we can coarsely check if it is set without any locks and
  only if it is set do the fine-grained locking stuff so it processed
  only one. If we miss the flag in one interrupt it is not a big deal
  as it will be noticed when the next interrupt arrives.

This is assuming that we are actually interested in what system was
doing _besides_ processing keyboard interrupt.

Dmitry



