Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTIMDbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 23:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTIMDbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 23:31:53 -0400
Received: from mail.webmaster.com ([216.152.64.131]:59884 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261869AbTIMDbv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 23:31:51 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Iker" <iker@computer.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [lkml] RE: self piping and context switching
Date: Fri, 12 Sep 2003 20:31:48 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMECLGIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <03f501c379a2$b14b49b0$3203a8c0@duke>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> More specifically, I was wondering if the write to the pipe or
> the call back
> into poll involved anything that might prompt the scheduler to replace the
> thread in this scenario.

	Sure, it could, but there's no particular reason to expect it to. The one
exception would be if another thread was already blocked waiting for that
particular pipe. In this case, your sending data on the pipe would unblock
that thread, which could trigger a pre-emption.

> > It's reasonable to expect that this will be the most common case and the
> > one to optimize. It is unreasonable to fail if this doesn't
> > happen, since
> > it's not guaranteed to happen. Note that if by "without a
> > context switch"
> > you really mean without another thread getting a chance to run,
> > then it is
> > totally unreasonable.

> Are you referring to transitions to/from kernel space? If so, wouldn't the
> write
> on the pipe and the call to poll both result in transitions?

	Yes, but there's no reason that transition should cause the kernel to want
to change processes. The kernel generally tries to let processes complete
their timeslice. An exception could certainly be if the write to the pipe
causes a new thread to unblock and that that thread has a higher dynamic
priority (which it well might, since it was waiting).

	Personally, I don't think the kernel should ever pre-empt threads/processes
with equivalent static priorities, but that's another whole argument. ;)

	DS


