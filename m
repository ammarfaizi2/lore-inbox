Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263121AbTCWRRZ>; Sun, 23 Mar 2003 12:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263123AbTCWRRZ>; Sun, 23 Mar 2003 12:17:25 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:61064 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263121AbTCWRRZ>;
	Sun, 23 Mar 2003 12:17:25 -0500
Date: Sun, 23 Mar 2003 18:28:22 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: linux-kernel@vger.kernel.org
Subject: Deadlock between tasklist_lock and dcache_lock
Message-ID: <Pine.LNX.4.44.0303231818530.3908-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__unhash_process acquires the dcache_lock while holding the tasklist_lock 
for writing. AFAICS this can deadlock:

CPU1:
	[ in release_task() ]
	write_lock_irq(&tasklist_lock);
	__unhash_process()
	
CPU2:
	spin_lock(&dcache_lock);
	<interrupt>
	read_lock(&tasklist_lock);, // e.g. for signal delivery
	** spins, lock held by cpu 1 for writing.

CPU1:
	[ within __unhash_process() ]
	spin_lock(&dcache_lock);
	** spins, lock held by CPU2

Probably the callers of __unhash_process must acquire the dcache_lock 
before write_lock_irq(&tasklist_lock).

Any other ideas how to fix the deadlock?
--
	Manfred

