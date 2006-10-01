Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWJALhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWJALhR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWJALhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:37:17 -0400
Received: from mx03.stofanet.dk ([212.10.10.13]:19145 "EHLO mx03.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751773AbWJALhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:37:14 -0400
Date: Sun, 1 Oct 2006 13:36:31 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 0/5] Fix timeout bug in rtmutex in 2.6.18-rt
Message-ID: <Pine.LNX.4.64.0610011336040.29459@frodo.shire>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I finally got around to merge my patches into a newer -rt kernel and repost 
them.

To refresh:
pthread_mutex_timedlock() for PI-futexes doesn't work on a UP machine:
Task A tries to take a lock with a timeout of say 1 ms. This lock is owned by B
which is boosted to task A's priority. The timeout interrupt wakes up A, but
since B is already running at A's priority, A will not get any CPU before B
unlocks the lock anyway.

This series of patches does the following:

1) It adds an interface to the scheduler such that task A is woken up LIFO
instead of FIFO. That means that A is now preempting B even though they have
the same priority. Thus A can de-boost B and exit the pthread_mutex_timedlock()
before B is done with the lock.

2) This is a smaller update to the rt-mutex-tester scripts. Probably not
needed, I'll post it anyway.

3) This patch makes sure that A will not loose it's priority while boosting B.
In case of other PI-mutex operations touches A's priority or explicit 
setscheduler() calls, A will not actually loose it's priority. That is
postponed until A leaves the lock operation (successfully or not). Thus A will
always be able to de-boost B.

4) Is a documentation update.

5) Is a fix to the PI-futex: There is (still) lacking a protection for
the rtmutex's internal state because. It might not be the cleanest way to do
this.

Esben

--
