Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSDKTAF>; Thu, 11 Apr 2002 15:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312797AbSDKTAE>; Thu, 11 Apr 2002 15:00:04 -0400
Received: from zero.tech9.net ([209.61.188.187]:6666 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312790AbSDKTAE>;
	Thu, 11 Apr 2002 15:00:04 -0400
Subject: Re: [PATCH] 2.5: task cpu affinity syscalls
From: Robert Love <rml@tech9.net>
To: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1018535032.19511.75.camel@satan.xko.dec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 11 Apr 2002 15:00:03 -0400
Message-Id: <1018551604.6524.215.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-11 at 10:23, Aneesh Kumar K.V wrote:

>  Now that we have API that allow a process to say I would like to go to
> these  CPU, Are there any API's available that will allow a CPU to say I
> will take only these process. ( Resource Affinity domains ? )

First, the Linux scheduler is not really designed to do this.  It's cpu
affinity works on a per-process basis and in fact needs to explicitly
move CPUs from each CPU.  Second, we could probably do this in userspace
using the exported sched_setaffinity syscall (just loop over all tasks,
setting the affinity as-needed).

There is a problem, though.  In 2.5 with the O(1) scheduler, if the
process is not currently running on an allowed CPU when it is affined,
it must be forced off to a legal CPU via the migration threads.  This is
expensive and complex and _not_ something we want to do to every process
on the system.

For this reason, and because I honestly favor the simple interfaces I
wrote, I think we should stick with just the exported interfaces we
currently have.

This isn't to say we could not do this in userspace - it would not be
hard (but still gross to move mass processes around).  We could also
have a version of init that affines itself on boot, thereby having every
other process likewise affined.  Then explicitly move away those
processes we want elsewhere.  This is cheap and easy.

	Robert Love

