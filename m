Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSJAV1L>; Tue, 1 Oct 2002 17:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbSJAV1K>; Tue, 1 Oct 2002 17:27:10 -0400
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:62730 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S262875AbSJAV1J>; Tue, 1 Oct 2002 17:27:09 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
References: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain>
From: Kristian Hogsberg <hogsberg@users.sf.net>
Date: 01 Oct 2002 23:32:30 +0200
In-Reply-To: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain>
Message-ID: <m37kh1vo9d.fsf@DK300KRH.bang-olufsen.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.9 |November
 16, 2001) at 01-10-2002 23:32:33,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.9 |November 16, 2001) at
 01-10-2002 23:32:37,
	Serialize complete at 01-10-2002 23:32:37
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> the attached (compressed) patch is the next iteration of the workqueue
> abstraction. There are two major categories of changes:
> 
>   - a much improved (i hope) core framework
> 
>   - (almost) complete conversion of existing drivers to the new framework.
> 
> 1) The framework improvements include:
> 
>  - per-CPU queueing support.
> 
> on SMP there is a per-CPU worker thread (bound to its CPU) and per-CPU
> work queues - this feature is completely transparent to workqueue-users.  
> keventd automatically uses this feature. XFS can now update to work-queues
> and have the same per-CPU performance as it had with its per-CPU worker
> threads.

Hi Ingo,

I read through your patch and I think it looks great.  I'm one of the
ieee1394 maintainers, and we also a have a worker thread mechanism in
the ieee1394 subsystem, which could (and will, I'm going to look into
this) be replaced by your work queue stuff.  We use the thread for
reading configuration information from ieee1394 devices.  This work
isn't very performance critical, but the reason we dont just use
keventd is that we don't want to stall keventd while reading this
information.  So, my point is, that in this case (I'm sure there are
more situations like this, usb has a similar worker thread, khubd),
the per-cpu worker thread is overkill, and it would be sufficient with
just one thread, running on all cpus.  So maybe this could be an
option to create_workqueue()?  Either create a cpu-bound thread for
each cpu, or create one thread that can run on all cpus.

Another minor comment: why do you kmalloc() the workqueue_t?  Wouldn't
it be more flexible to allow the user to provide a pointer to a
pre-allocated workqueue_t structure, e.g.:

        static workqueue_t aio_wq;

        [...]

               	create_workqueue(&aio_wq, "aio");

Kristian

