Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRBRWYr>; Sun, 18 Feb 2001 17:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129176AbRBRWYh>; Sun, 18 Feb 2001 17:24:37 -0500
Received: from mail2.mail.iol.ie ([194.125.2.193]:27411 "EHLO mail.iol.ie")
	by vger.kernel.org with ESMTP id <S129172AbRBRWYY>;
	Sun, 18 Feb 2001 17:24:24 -0500
Date: Sun, 18 Feb 2001 22:24:16 +0000
From: Kenn Humborg <kenn@linux.ie>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: kernel_thread() & thread starting
Message-ID: <20010218222416.D22176@excalibur.research.wombat.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In init/main.c, do_basic_setup() we have:

	start_context_thread();
	do_initcalls();

start_context_thread() calls kernel_thread() to start the keventd
thread.  Then do_initcalls() calls all the init functions and
finishes by calling flush_scheduled_tasks().  This function ends
up calling schedule_task() which checks if keventd is running.

With a very stripped down kernel, it seems possible that do_initcalls()
can complete without context_thread() having had a chance to run (and
set the flag that keventd is running).

Right now, in the Linux/VAX project, I'm working with a very stripped
down kernel and I'm seeing this behaviour.  Depending on what I enable
in the .config, I can get schedule_task() to fail with:

   schedule_task(): keventd has not started

When starting bdflush and kupdated, bdflush_init() uses a semaphore to
make sure that the threads have run before continuing.  Shouldn't
start_context_thread() do something similar?

Or am I missing something?

Thanks,
Kenn

