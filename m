Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264577AbSIQU2p>; Tue, 17 Sep 2002 16:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264581AbSIQU2p>; Tue, 17 Sep 2002 16:28:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:45329
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264577AbSIQU2o>; Tue, 17 Sep 2002 16:28:44 -0400
Subject: non-atomic test victim #1
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 16:33:33 -0400
Message-Id: <1032294813.4592.241.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current kernel with the non-atomic test I sent, SMP with preemption.

I only get two triggers, both during boot.  They are on migration_thread
and ksoftirqd startup.  The problem lies in set_cpus_allowed():

    Trace; c0116ac4 <schedule+a4/4b0>
    Trace; c011731a <wait_for_completion+11a/1d0>
    Trace; c0116f30 <default_wake_function+0/40>
    Trace; c0115d02 <try_to_wake_up+312/320>
    Trace; c0116f30 <default_wake_function+0/40>
    Trace; c0118f0f <set_cpus_allowed+22f/250>
    Trace; c0118f7d <migration_thread+4d/590>
    Trace; c0118f30 <migration_thread+0/590>
    Trace; c0118f30 <migration_thread+0/590>
    Trace; c010586d <kernel_thread_helper+5/18>

It is obviously the preempt_disable() which we hold past the wake_up().

The issue is that, without this preempt_disable() there have been
observed crashes, especially on large n-way machines.  Both Andrew
Morton and Anton Blanchard have reported the problem and that this fixes
it.

Question is, why does set_cpus_allowed() need it?  I do not see it... it
must be an issue with an early preemption and the resulting
migration_thread?

Ingo, ideas?

	Robert Love


