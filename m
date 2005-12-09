Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVLICp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVLICp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 21:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVLICp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 21:45:58 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:45976 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751251AbVLICp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 21:45:58 -0500
Date: Fri, 9 Dec 2005 08:16:23 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
Message-ID: <20051209024623.GA14844@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <439889FA.BB08E5E1@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439889FA.BB08E5E1@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 10:31:06PM +0300, Oleg Nesterov wrote:
> I can't see how this change can prevent idle cpus to be included in
> ->cpumask, cpu can add itself to nohz_cpu_mask right after some other
> cpu started new grace period.

Yes that can happen, but if they check for rcu_pending right after that
it will prevent them from going tickless atleast (which will prevent grace
periods from being unnecessarily extended). Something like below:


	CPU0					CPU1



	rcp->cur++;	/* New GP */		

	smp_mb();

	rsp->cpumask = 0x3

						cpu_set(1, nohz_cpu_mask);

						rcu_pending()? 
						 - Yes,
						   cpu_clear(1, nohz_cpu_mask);
						   Abort going tickless


Ideally we would have needed a smp_mb() in CPU1 also between setting CPU1
in nohz_cpu_mask and checking for rcu_pending(), but I guess it is not needed
in s390 because of its strong ordering?

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
