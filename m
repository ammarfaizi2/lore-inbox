Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWGZPwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWGZPwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWGZPwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:52:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27834 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750762AbWGZPwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:52:37 -0400
Date: Wed, 26 Jul 2006 11:51:14 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
Message-ID: <20060726155114.GA28945@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Ashok Raj <ashok.raj@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu> <1153855844.8932.56.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org> <1153921207.3381.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153921207.3381.21.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 03:40:07PM +0200, Arjan van de Ven wrote:

 > Subject: Reorganize the cpufreq cpu hotplug locking to not be totally bizare
 > From: Arjan van de Ven <arjan@linux.intel.com>
 > 
 > The patch below moves the cpu hotplugging higher up in the cpufreq
 > layering; this is needed to avoid recursive taking of the cpu hotplug
 > lock and to otherwise detangle the mess.
 > 
 > The new rules are:
 > 1. you must do lock_cpu_hotplug() around the following functions:
 >    __cpufreq_driver_target
 >    __cpufreq_governor (for CPUFREQ_GOV_LIMITS operation only)
 >    __cpufreq_set_policy
 > 2. governer methods (.governer) must NOT take the lock_cpu_hotplug()
 >    lock in any way; they are called with the lock taken already
 > 3. if your governer spawns a thread that does things, like calling
 >    __cpufreq_driver_target, your thread must honor rule #1.
 > 4. the policy lock and other cpufreq internal locks nest within 
 >    the lock_cpu_hotplug() lock. 
 > 
 > I'm not entirely happy about how the __cpufreq_governor rule ended up
 > (conditional locking rule depending on the argument) but basically all
 > callers pass this as a constant so it's not too horrible.
 > 
 > The patch also removes the cpufreq_governor() function since during the
 > locking audit it turned out to be entirely unused (so no need to fix it)
 > 
 > The patch works on my testbox, but it could use more testing 
 > (otoh... it can't be much worse than the current code)
 > 
 > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Looks sensible to me.   Assuming it passes testing..

Signed-off-by: Dave Jones <davej@redhat.com>

Linus ?

		Dave

-- 
http://www.codemonkey.org.uk
