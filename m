Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbUKDQHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbUKDQHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUKDQHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:07:07 -0500
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:58707 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S262268AbUKDQGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:06:53 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Date: Thu, 4 Nov 2004 10:04:39 -0600
Message-ID: <OFBDA242F0.2AF7EADB-ON86256F42.00585112-86256F42.0058514C@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/04/2004 10:04:47 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>does the ping phenomenon go away if you chrt both the networking IRQ
>thread and both ksoftirqd's to above the RT task's priority?

For the most part, yes. I reran the test with -V0.7.7 and had continuous
ping responses until the system locked up with yet another deadlock. This
did NOT fix the display / mouse movement lockups. All IRQ and ksoftirqd
tasks were RT 99 priority for this test. latencytest ran at RT 30 priority.

The response time while RT was active looked like this...

# ping dws77
PING dws77 (192.52.216.87) from 192.52.215.17 : 56(84) bytes of data.
64 bytes from dws77 (192.52.216.87): icmp_seq=1 ttl=63 time=0.590 ms
64 bytes from dws77 (192.52.216.87): icmp_seq=2 ttl=63 time=0.468 ms
64 bytes from dws77 (192.52.216.87): icmp_seq=3 ttl=63 time=0.542 ms
64 bytes from dws77 (192.52.216.87): icmp_seq=4 ttl=63 time=0.492 ms

Note the response times are about 2x what I saw with the other kernels.
The max delay was about 200 msec.

The deadlock was between the two ksoftirqd tasks...

===============================================
BUG: circular semaphore deadlock detected!
-----------------------------------------------
ksoftirqd/1/6 is deadlocking current task ksoftirqd/0/3


1) ksoftirqd/0/3 is trying to acquire this lock:
 [cb4640c0] {r:0,a:-1,&((sk)->sk_lock.slock)}
.. held by:       ksoftirqd/1/    6 [dff866f0,   0]
... acquired at:  tcp_delack_timer+0x22/0x220
... trying at:   tcp_v4_rcv+0x69b/0xb00

2) ksoftirqd/1/6 is blocked on this lock:
 [c03c8900] {r:2,a:-1,ptype_lock}
.. held by:       ksoftirqd/0/    3 [dffe8020,   0]
... acquired at:  net_rx_action+0x8e/0x200

------------------------------
| showing all locks held by: |  (ksoftirqd/0/3 [dffe8020,   0]):
------------------------------

#001:             [d84a7c30] {r:0,a:-1,&tp->rx_lock}
... acquired at:  rtl8139_poll+0x48/0x180 [8139too]

------------------------------
| showing all locks held by: |  (ksoftirqd/1/6 [dff866f0,   0]):
------------------------------

#001:             [cb4640c0] {r:0,a:-1,&((sk)->sk_lock.slock)}
... acquired at:  tcp_delack_timer+0x22/0x220

Appears that both were working on network operations concurrently.
Will send the full serial console log separately.

  --Mark

