Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270861AbTHATrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270865AbTHATqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:46:31 -0400
Received: from w197.z066088144.sjc-ca.dsl.cnc.net ([66.88.144.197]:50678 "EHLO
	kali.zeta-soft.com") by vger.kernel.org with ESMTP id S274960AbTHATom
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:44:42 -0400
From: "Scott L. Burson" <gyro@zeta-soft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri,  1 Aug 2003 12:44:35 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Spinlock performance on Athlon MP (2.4)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Mathieu.Malaterre@creatis.insa-lyon.fr
In-Reply-To: <1059605940.10447.16.camel@dhcp22.swansea.linux.org.uk>
References: <16168.12542.850631.294911@kali.zeta-soft.com>
	<1059605940.10447.16.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16168.30492.825111.621520@kali.zeta-soft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 30 Jul 2003 23:59:00 +0100

   On Mer, 2003-07-30 at 22:50, Scott L. Burson wrote:
   > First, and probably the reason you haven't heard more complaints about the
   > problem, its severity is evidently dependent on the size of main memory.  At
   > 512MB it doesn't seem to be much of a problem (right, Mathieu?).  At 2.5GB,
   > which is what I have, it can be quite serious.  For instance, if I start two
   > `find' processes at the roots of different filesystems, the system can spend
   > (according to `top') 95% - 98% of its time in the kernel.  It even gets
   > worse than that, but `top' stops updating -- in fact, the system can seem
   > completely frozen, but it does recover eventually.  Stopping or killing one
   > of the `find' processes brings it back fairly quickly, though it can take a
   > while to accomplish that.

   Thats the well understood DMA bounce buffers problem.

It's definitely not the bounce buffers problem.  I installed the patch and
it doesn't help (well, maybe it helps a little; it's hard to tell).

However, I have pretty strong evidence that it's not the spinlock handoff
time either.  I wrote a small benchmark that starts two threads that do
nothing but hand two spinlocks back and forth.  The Athlon runs it an order
of magnitude _faster_ than the P4 (5ns vs. 50ns, roughly, per handoff).

I'm fairly certain that lock contention is involved somehow, though.
Lockmeter reports that lock waiting is consuming about 35% of the CPU cycles
when the problem is happening.  This isn't the 90% - 95% number I expected
-- the latter being the percentage of time spent in the kernel, as reported
by `top' -- but it's high enough to wonder about, and it may be artificially
low.  Lockmeter has a spinlock that protects its data structures, and the
profile says 36% of the time is being spent in the routine that acquires
that lock.  This suggests that lockmeter isn't counting that time.

One oddity pointed up by lockmeter is that `pagemap_lru_lock' is held by
`shrink_cache' some 85% of the time.  This seems way too high, and I am
looking into it.

-- Scott
