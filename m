Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUCDVSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 16:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUCDVSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 16:18:31 -0500
Received: from mail.inter-page.com ([12.5.23.93]:23057 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261816AbUCDVS2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 16:18:28 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Peter Williams'" <peterw@aurema.com>,
       "'Timothy Miller'" <miller@techsource.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH] O(1) Entitlement Based Scheduler
Date: Thu, 4 Mar 2004 13:18:09 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA0luffW31DkqMtZfFQTaQsgEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <403D576A.6030900@aurema.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At a previous employer (so code not available) I used a simple expedient to
solve this very problem.  I had a custom program "shim.c" that tweaked
priorities and environment variables.  Basically a fistful of lines that
would take argv[0], look for the file named ".shim_"+basename(argv[0]) {in a
well-defined location} to load some simple environment and path and priority
overrides, apply these changes and then setuid itself back to the real user
and exec() the real program with the received args.

It had some few degenerate cases (shmming out from under a setuid program
was the primary one) but it worked out rather well and had little-to-no
meaningful overhead.

You set up a /usr/local/bin (or equivalent) directory, link shim into that
directory named as the various programs that need to be boosted (e.g. xmms
etc) and put that directory earlier on the path than the real executable.
{If this directory only contains shims, it is useful to code shim.c to
remove that directory from the PATH.)

This technique lets the administrator have fine-grained control of a
reasonable list of priority promotions and permissions overrides without
having to move anything into kernel space or running status daemons.

====

I would think that while fork() should keep the heuristics of its parent,
exec() would probably need to do some normalizing.

====

Has this scheduler been tried for applications like CD burning?

Rob.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Peter Williams
Sent: Wednesday, February 25, 2004 6:18 PM
To: Timothy Miller
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler

Timothy Miller wrote:
 > <snip>
> In fact, that may be the only "flaw" in your design.  It sounds like 
> your scheduler does an excellent job at fairness with very low overhead. 
>  The only problem with it is that it doesn't determine priority 
> dynamically.

This (i.e. automatic renicing of specified programs) is a good idea but 
is not really a function that should be undertaken by the scheduler 
itself.  Two possible solutions spring to mind:

1. modify the do_execve() in fs/exec.c to renice tasks when they execute 
specified binaries
2. have a user space daemon poll running tasks periodically and renice 
them if they are running specified binaries

Both of these solutions have their advantages and disadvantages, are 
(obviously) complicated than I've made them sound and would require a 
great deal of care to be taken during their implementation.  However, I 
think that they are both doable.  My personal preference would be for 
the in kernel solution on the grounds of efficiency.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



