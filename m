Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269387AbUI3SSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269387AbUI3SSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269396AbUI3SSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:18:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:24974 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269390AbUI3SQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:16:06 -0400
Subject: Re: Consistent kernel hang during heavy TCP connection handling
	load
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>, aathan-linux-kernel-1542@cloakmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cjhc2d$5na$1@gatekeeper.tmr.com>
References: <20040926174217.GB18172@atrey.karlin.mff.cuni.cz>
	 <NFBBICMEBHKIKEFBPLMCGEHFIJAA.aathan-linux-kernel-1542@cloakmail.com>
	 <cjhc2d$5na$1@gatekeeper.tmr.com>
Content-Type: text/plain
Message-Id: <1096568294.2515.47.camel@DYN319619.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Sep 2004 11:18:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 09:34, Bill Davidsen wrote:
> Andrew A. wrote:
> > Jan,
> > 
> > Thanks for responding.  When I got no responses, I searched for ways to get more data out of the kernel--I must say that it has been
> > quite a journey to identify what is working, where to get it, and how to install it when it comes to kernel
> > debugging/crash-data-gathering tools.  LKCD for example, is not available at the location you'll eventually arrive at if you search
> > for it in google ... it's not obvious what it's state is (current/defunct/superceded), there's KDB, KGDB, netdump, netconsol,
> > netlog, diskdump (conusingly known as lkdump) etc. etc.  And then, even if you do figure out what tools are current, you then have
> > to match the tool to the particular kernel version you are running -- which can be a task and a half unto itself.
> > 
> > Is diskdump available for 2.4?  Can anyone comment on the choice of tools below?
> > 
> > Anyway, I have also done all of the following:
> > 
> > (1) Enabled netdump/netconsole on 2.6.8.1-521 Fedora Core kernel, after first fixing the startup scripts.  Fixes can be found at
> > www.memeplex.com/Linux.html  Note that after I also fixed crash.c to be a 2.6 compliant kernel module, and loading it to test
> > netdump, I always end up with a vmcore-incomplete image approx 45k in size, on the netdump-server.  Can anyone tell me if this is
> > absurdly small, and if so, what might be the solution?  The client box always reboots so I suspect too-small timeouts are the issue.
> 
> My experience is 100% with RH kernels, but the dump should be about 
> memory size, in my case 2.5G or 4G and it is. But I did see hangs which 
> resulted in the size you mention, a few k and hang.


Yep, the vmcore should be around the size of the memory on the dumping
system. The size is too small and vmcore-incomplete wasn't made into
vmcore, so it's incomplete.

Do you have access to making a new kernel? Here's a fix that I think
will help. This will speed things up and help with the timeout issues.

drivers/net/netdump.c :

1) Initialize jiffy_cyles to 1000 * (1000000/HZ) -

-static unsigned long long t0, jiffy_cycles;
+static unsigned long long t0, jiffy_cycles = 1000 * (1000000/HZ);

2) Change prev_jiffies from an "int" to an "unsigned long" in
print_status() function -

-       static int prev_jiffies = 0;
+       static unsigned long prev_jiffies = 0;


Let me know if this helps,

Thanks,

Dan

