Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTKJV6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 16:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTKJV6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 16:58:48 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:52177 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264129AbTKJV6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 16:58:46 -0500
Date: Mon, 10 Nov 2003 15:58:44 -0600
From: Jack Steiner <steiner@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: hot cache line due to note_interrupt()
Message-ID: <20031110215844.GC21632@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I dont know the background on note_interrupt() in arch/ia64/kernel/irq.c, 
but I had to disable the function on our large systems (IA64).

The function updates a counter in the irq_desc_t table. An entry in this table
is shared by all cpus that take a specific interrupt #. For most interrupt #'s,
this is a problem but it is prohibitive for the timer tick on big systems.

Updating the counter causes a cache line to be bounced between
cpus at a rate of at least HZ*active_cpus. (The number of bus transactions
is at least 2X higher because the line is first obtained for
shared usage, then upgraded to modified. In addition, multiple references
are made to the line for each interrupt. On a big system, it is unlikely that
a cpu can hold the line for entire time that the interrupt is being
serviced).

On a 500p system, the system was VERY slowly making forward progres during boot,
but I didnt have the patience to wait for it finish. After I disabled
note_interrupt(), I had no problem booting.

Certainly, the problem is much less severe on smaller systems. However, even
moderate sized systems may see some degradation due to this hot cache line.



I also verified on a system simulator that the counter in note_interrupt() is the
only line that is bounced between cpus at a HZ rate on an idle system.

The IPI & reschedule interrupts have a similar problem but at a lower rate.


(initialially sent to linux-ia64@vger.kernel.org)

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


