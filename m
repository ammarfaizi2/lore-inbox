Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130101AbRBZBV1>; Sun, 25 Feb 2001 20:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130100AbRBZBVR>; Sun, 25 Feb 2001 20:21:17 -0500
Received: from pc7.prs.nunet.net ([199.249.167.77]:39184 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S130099AbRBZBVP>;
	Sun, 25 Feb 2001 20:21:15 -0500
Date: 26 Feb 2001 01:21:12 -0000
Message-ID: <20010226012112.9698.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico@patrec.com>
To: linux-kernel@vger.kernel.org
Subject: 64GB option broken in 2.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: 64GB option broken in 2.4.2

Problem:
	The 64GB option causes processes to spin in the kernel.

Setup:
	Linux 2.4.2
	Slack current 20-feb-2001
	ServerWorks III HE
	4GB main memory
	dual 933 Piii: SL47Q (stepping 3), SL4KK (stepping 6)
	gcc 2.95.2 19991024 (release)

Test procedure:
	On /dev/tty1, type

		cat /dev/sda >/dev/null		# or any fast disk

	On /dev/tty2, type

		while sleep 0; do date; done

	On /dev/tty3, type

		top

	The purpose of the disk read is to provide some nondeterminism,
	which triggers the bug.  `top' lets you watch the debacle.

Observation:
	After a short time, dates will appear with increasing
	irregularity.  `top' will show `sleep' and `date' processes
	racking up many seconds of CPU time.  At this point, terminate
	the disk read, and one of these processes will go completely
	CPU-bound, and uninterruptible.  In this state, the system is
	unusable, since any exec'd process has a good chance of being
	bushwhacked in the kernel.

Variations:
	noapic		problem remains
	mem=1200m	problem remains
	nosmp noapic	problem fixed
	mem=800m	problem fixed
	4GB option	problem fixed

Hypothesis:
	Code to handle PAE has buggy spinlock management.
