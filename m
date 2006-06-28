Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWF1Vw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWF1Vw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWF1Vw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:52:29 -0400
Received: from gw.goop.org ([64.81.55.164]:50340 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751563AbWF1Vw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:52:28 -0400
Message-ID: <44A2FA20.3020809@goop.org>
Date: Wed, 28 Jun 2006 14:52:32 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm3: swsusp fails when process is debugged by ptrace
References: <44A2B9AF.50803@goop.org> <20060628212616.GB30373@elf.ucw.cz>
In-Reply-To: <20060628212616.GB30373@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Does it also happen when you do strace? ...I remember trying to solve
> that, but 2.6.17-mm3 is very recent...?

I could suspend while running "strace sleep 100" without any problem.

I think the issue is when the process is blocked in T state,
freeze_process() tries to kick the process with signal_wake_up(p, /*
resume=0 */ 0), but with resume=0 it will only wake processes in
TASK_INTERRUPTIBLE state.  With resume=1, it will also kick STOPPED and
TRACED processes.  I also tried suspending while I had a process in T
state caused by kill -STOP, and that worked, so some part of the puzzle
is still missing.

I noticed that when I ran sleep 100 under strace over the suspend/resume
cycle, its nanosleep() syscall was interrupted and not restarted.

    J
