Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVEHNbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVEHNbE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 09:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVEHNbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 09:31:04 -0400
Received: from one.firstfloor.org ([213.235.205.2]:15337 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262864AbVEHNbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 09:31:01 -0400
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050507182728.GA29592@in.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 08 May 2005 15:31:00 +0200
In-Reply-To: <20050507182728.GA29592@in.ibm.com> (Srivatsa Vaddagiri's
 message of "Sat, 7 May 2005 23:57:28 +0530")
Message-ID: <m1vf5tvo8b.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> writes:

> Hello,
> 	I need some inputs from the community (specifically from virtual
> machine and embedded/power-management folks) on something that I am working on.


I think the best way is to let other CPUs handle the load balancing
for idle CPUs. Basically when a CPU goes fully idle then you mark
this in some global data structure, and CPUs doing load balancing
after doing their own thing look for others that need to be balanced
too and handle them too. When no CPU is left non idle then nothing needs
to be load balanced anyways. When a idle CPU gets a task it just gets
an reschedule IPI as usual, that wakes it up. 

I call this the "scoreboard".

The trick is to evenly load balance the work over the remaining CPUs.
Something simple like never doing work for more than 1/idlecpus is
probably enough. In theory one could even use machine NUMA topology
information for this, but that would be probably overkill for the
first implementation.

With the scoreboard implementation CPus could be virtually idle
forever, which I think is best for virtualization.

BTW we need a very similar thing for RCU too.

-Andi
