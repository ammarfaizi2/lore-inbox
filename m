Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVHYE0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVHYE0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVHYE0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:26:24 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:9102 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S964784AbVHYE0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:26:23 -0400
X-ORBL: [69.107.75.50]
Date: Wed, 24 Aug 2005 21:26:16 -0700
From: David Brownell <david-b@pacbell.net>
To: William.Morrow@amd.com
Subject: Re: [PATCH] for acpi S1 power cycle resume problems
Cc: linux-kernel@vger.kernel.org
References: <4305EF1D.6020502@amd.com>
In-Reply-To: <4305EF1D.6020502@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050825042616.1D64EC16B2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 19 Aug 2005 08:39:25 -0600
> From: "William Morrow" <William.Morrow@amd.com>
> Subject: [PATCH] for acpi S1 power cycle resume problems
>
>
> Hi
> I was told that if I had a patch to submit for a baseline change that 
> this was the place to do it.

In this case that works fine.  Normally they should go to linux-usb-devel
for me (and others) to read there.

Thanks, these need a bit of cleaning up, finishing, and splitting out;
they should be in 2.6.14 though.  Comments below.  Were these patches
written by you, or by Jordan?

- Dave



> If not, please let me know...
>
> thanks,
> morrow
>
> Patched against 2.6.11 baseline
> problems fixed:
> 1) OHCI_INTR_RD not being cleared in ohci interrupt handler
>  results in interrupt storm and system hang on RD status.
>  ohci spec indicates this should be done.

Yeah, I noticed that one but didn't fix it yet.  It's not that
it was _never_ cleared ... only certain code paths missed it.
The systems I test with were clearly using those working paths!

Having this fixed should help get rid of the 1/4 second timer
this driver normally ties up.  That'll help make the dynamic
tick stuff work better, reducing power even when something like
"ACPI S1" doesn't exist (like say, on that one Zaurus).


> 2) PORT_CSC not being cleared in ehci_hub_status_data
>  code attempts to clear bit, but bit is write to clear.
>  there are other errant clears, since the PORTSCn regs
>  have 3 RWC bits, and the rest are RW. All stmts of the form:
>    writel (v, &ehci->regs->port_status[i])
>  should clear RWC bits if they do not intend to clear status,
>  and should set the bits which should be cleared (this case).

Yeah, whoever did that RWC patch for UHCI ports certainly should
have checked other HCDs for the same bug.  (Kicks self.)

In fact you didn't fix this issue comprehensively.  There are
other places that register is written; they need to change too.

This is clearly wrong, but did you notice any effects more
serious than "lsusb -v" output for EHCI root hubs looking
a bit strange?


> 3) loop control and subsequent port resume/reset not correct.
>  unsigned index made detecting port1 active impossible,

Odd, I've done that with some regularity.  Is that maybe
some kind of compiler bug?  (I heard even 4.1 isn't quite
there yet for kernels.)

The looping doesn't look incorrect to me; ports are numbered
from 1..N, and C code in the body must index them from 0..(N-1).


> and OWNER/POWER status was being ignored on ports assigned
>  to companion controller.

Well, in that one resume case anyway!

But OWNER and POWER are very different status bits ... if POWER
ever goes off, that port is by definition not resumable.  But
if a port's owned by the companion (OHCI or UHCI) controller,
then it surely ought not to be reset (even if the companion's
own SUSPEND bit doesn't show through EHCI).

