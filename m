Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbUJ2OiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUJ2OiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbUJ2Oel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:34:41 -0400
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:5872
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S263342AbUJ2O1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:27:19 -0400
From: "Andrew" <aathan-linux-kernel-1542@cloakmail.com>
To: "Andrew" <aathan-linux-kernel-1542@cloakmail.com>,
       <linux-kernel@vger.kernel.org>
Cc: <roland@topspin.com>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: Consistent lock up 2.6.10-rc1-bk7 (mutex/SCHED_RR bug?)
Date: Fri, 29 Oct 2004 10:26:56 -0400
Message-ID: <OMEGLKPBDPDHAGCIBHHJOELLFCAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <OMEGLKPBDPDHAGCIBHHJMEIDFCAA.aathan-linux-kernel-1542@cloakmail.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have reproduced this hang on 2.6.10-rc1-bk7, and have also installed the sysrq-n patch.  Even after "SysRq : Nice All RT Tasks",
the system is completely unresponsive as far as user mode is concerned, and will only react to SysRq.  It -does- respond to ICMP
pings.  Sysrq-e, -k, -i do not stop the offending tt1 process.

I do not have netdump available in 2.6.10-rc1-bk7, and so cannot provide a full sysrq-t output, but the visible section shows two
tt1 threads with identical stacks:

schedule_timeout+0xd0/0xd2
futex_wait+0x140/0x1a9
do_futex+0x33/0x78
sys_futex+0xcd/0xd9
sysenter_past_esp+0x52/0x71

I then tried running this task as non-root user, which should prevent SCHED_RR and PRIO changes of the threads/tasks.  Under these
conditions, the system does *not* hang.  I noticed that the app periodically ends up in a high-speed loop involving the
ACE_Semaphore class in ACE; having checked the compilation flags, it seems ACE is simulating semaphors using below calls.  It is
*not* using POSIX 1003.1b semaphores (sem_wait, etc.)

pthread_mutex_lock()
pthread_cond_wait()
pthread_cond_signal()

Although it appears I need to fix an applicaiton bug, is it normal/desirable for an application calling system mutex facilities to
starve the system so completely, and/or become "unkillable"?

A.


-----Original Message-----
From: Andrew [mailto:aathan-linux-kernel-1542@cloakmail.com]
Sent: Thursday, October 28, 2004 5:10 PM
To: linux-kernel@vger.kernel.org
Cc: roland@topspin.com; Andrew Morton
Subject: Consistent lock up 2.6.8-1.521 (and 2.6.8.1 w/
high-res-timers/skas/sysemu)



Caveat:  This may be an infinite loop in a SCHED_RR process.  See very bottom of email for sysrq-t sysrq-p output.

[LARGE EMAIL DELETED]


