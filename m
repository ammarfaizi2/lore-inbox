Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbULDVCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbULDVCX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 16:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbULDVCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 16:02:23 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52096
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261160AbULDVCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 16:02:06 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Voluspa <lista4@comhem.se>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1102185205.13353.309.camel@tglx.tec.linutronix.de>
References: <200412041242.iB4CgsN07246@d1o408.telia.com>
	 <20041204164353.GE32635@dualathlon.random>
	 <1102185205.13353.309.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Sat, 04 Dec 2004 22:02:03 +0100
Message-Id: <1102194124.13353.331.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-04 at 19:33 +0100, Thomas Gleixner wrote:
>
> I added some debug output and it calls __alloc_pages a couple of times.
> All those calls get out from the first goto got_pg as expected.
> 
> I will try to add some more debug later
> 

Your assumption that reverting the 

-       might_sleep_if(wait);
+       if (wait)
+               cond_resched();

change does solve the problem is correct. Looking at the diffs its the
only change which can have any influence at this point.

Mats. I don't understand why this did not work for you. The change has
to be reverted to the original line "might_sleep_if(wait)" !

Scheduling in this init stage causes the breakage. 
might_sleep_if() is a nop and only does a state check when compiled with
CONFIG_DEBUG_SPINLOCK_SLEEP=y, but it does neither sleep nor schedule. 

It then works so far except that it kills the wrong process (sshd), but
I did expect that from the previous experience. 

There is no multi kill or other strange things happening. I tested it
with hackbench and the real application _after_ adding my "whom to kill
patch" on top.

Looks much better now. 

Can you agree to add the selection patch, which takes the multi child
forking process into account ? I don't explain again why it makes
sense :)

tglx


