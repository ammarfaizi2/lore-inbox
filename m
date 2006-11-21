Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031106AbWKUR4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031106AbWKUR4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031223AbWKUR4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:56:24 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:12450 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1031106AbWKUR4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:56:23 -0500
Date: Tue, 21 Nov 2006 12:56:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061119214315.GI4427@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0611211244200.6140-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another potential problem with the fast path approach.  It's not 
very serious, but you might want to keep it in mind.

The idea is that a reader can start up on one CPU and finish on another, 
and a writer might see the finish event but not the start event.  For 
example:

	Reader A enters the critical section on CPU 0 and starts
	accessing the old data area.

	Writer B updates the data pointer and starts executing
	srcu_readers_active_idx() to check if the fast path can be
	used.  It sees per_cpu_ptr(0)->c[idx] == 1 because of
	Reader A.

	Reader C runs srcu_read_lock() on CPU 0, setting 
	per_cpu_ptr[0]->c[idx] to 2.

	Reader C migrates to CPU 1 and leaves the critical section;
	srcu_read_unlock() sets per_cpu_ptr(1)->c[idx] to -1.

	Writer B finishes the cpu loop in srcu_readers_active_idx(),
	seeing per_cpu_ptr(1)->c[idx] == -1.  It computes sum =
	1 + -1 == 0, takes the fast path, and exits immediately
	from synchronize_srcu().

	Writer B deallocates the old data area while Reader A is still
	using it.

This requires two context switches to take place while the cpu loop in
srcu_readers_active_idx() runs, so perhaps it isn't realistic.  Is it
worth worrying about?

Alan

