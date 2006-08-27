Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWH0Jmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWH0Jmc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWH0Jmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:42:32 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:19496 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751084AbWH0Jmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:42:31 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
cc: rusty@rustcorp.com.au, mingo@elte.hu
Subject: Is stopmachine() preempt safe?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 27 Aug 2006 19:42:32 +1000
Message-ID: <10990.1156671752@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot convince myself that stopmachine() is preempt safe.  What
prevents this race with CONFIG_PREEMPT=y?

cpu 0				cpu 1
stop_machine()
				Process <n> reads a global resource
do_stop()
kernel_thread(stopmachine, 1)
				Process <n> is preempted
				stopmachine() runs on cpu 1
				STOPMACHINE_PREPARE
				STOPMACHINE_DISABLE_IRQ
do_stop() calls smdata->fn
smdata->fn changes global data
restart_machine()
				STOPMACHINE_EXIT
				stopmachine() exits
				Scheduler resumes process <n>
				The global resource is out of sync

The stopmachine() threads on the other cpus are set to MAX_RT_PRIO-1 so
they will preempt any existing process.  The yield() in stopmachine()
only guarantees that these kernel threads get onto the other cpus, it
does not guarantee that all running tasks will proceed to a yield
themselves before stopmachine runs.  IOW, what guarantees that the
scheduler will only run stopmachine() on the target cpus when those
cpus are completely idle with no locally cached global resources?

