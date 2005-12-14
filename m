Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbVLNDzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbVLNDzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbVLNDzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:55:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13979 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030428AbVLNDzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:55:16 -0500
Date: Tue, 13 Dec 2005 19:54:57 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: dada1@cosmosbay.com, clameter@engr.sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051213195457.4e2b31af.pj@sgi.com>
In-Reply-To: <20051213142346.ccd3081a.pj@sgi.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
	<20051212020211.1394bc17.pj@sgi.com>
	<20051212021247.388385da.akpm@osdl.org>
	<20051213075345.c39f335d.pj@sgi.com>
	<439EF75D.50206@cosmosbay.com>
	<Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
	<439F0B43.4080500@cosmosbay.com>
	<20051213130350.464a3054.pj@sgi.com>
	<439F3F6E.6010701@cosmosbay.com>
	<20051213142346.ccd3081a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
> Time for me to learn more about rcu.

Well, that was easy.

Directly using RCU to guard that task->cpuset pointer instead of
cheating via the RCU hooks in the slab cache was just a few lines of
code.

But, boy oh boy, that synchronize_rcu() call sure takes it time.

My cpuset torture test was creating, destroying and abusing about 2600
cpusets/sec before this change, and now it does about 144 cpusets/sec.

That cost 95% of the performance.  This only hits on the cost of
attaching a task to a different cpuset (by writing its <pid> to
some other cpuset 'tasks' file.)

Just commenting out the synchronize_cpu() restores the previous speed.

Nothing surprising here - this is just how rcu claims it behaves,
heavily favoring the read side performance.  These delays are waiting
for the other cpus doing rcu_read_lock() to go through a quite period
(reschedule, idle or return to user code).

Patches coming soon, to remove the cpuset_cache slab cache, and to
use RCU directly instead.

Thanks, Eric.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
