Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUDBShU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 13:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbUDBShU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 13:37:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:23275 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264147AbUDBShL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 13:37:11 -0500
Date: Fri, 2 Apr 2004 10:33:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: vatsa@in.ibm.com, mbligh@aracnet.com, hari@in.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jamesclv@us.ibm.com
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-Id: <20040402103327.5ebc1956.rddunlap@osdl.org>
In-Reply-To: <7621629.1080823120@42.150.104.212.access.eclipse.net.uk>
References: <20040330173620.6fa69482.akpm@osdl.org>
	<276260000.1080697873@flay>
	<109577502.1080783067@[192.168.0.89]>
	<20040401050413.GA4056@in.ibm.com>
	<7621629.1080823120@42.150.104.212.access.eclipse.net.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Apr 2004 12:38:40 +0100 Andy Whitcroft wrote:

| --On 01 April 2004 10:34 +0530 Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
| 
| > Hmm ..Doesn't it need to drop tlbstate_lock before returning?
| > The second lock should be call_lock?
| 
| Yes and Yes.  I don't know how Andrew copes with 300 odd patches. 
| I don't seem to be able to keep track of the versions on 3 of them?
| Seems I sent out an old version.  Doh.  Explicit version numbers
| from now on.
| 
| Below is tested version of the patch.  If anyone can reproduce the
| issue I would be interested in knowing if this passes a reboot on
| that system.
| 
| Apologies for the confusion.  And thanks for reviewing!


This version works well, thank you.  Without it I still see the
BUG_ON() in smp.c (line 359).


I noted a few comments corrections and style changes below.
Want a patch for them instead?


| @@ -367,16 +365,24 @@ static void flush_tlb_others(cpumask_t c
|  	 * detected by the NMI watchdog.
|  	 */
|  	spin_lock(&tlbstate_lock);
| +
| +	/* Subtle, mask the request mask with the currently online cpu's.
| +	 * Sample this under the lock; cpus in the the middle of going
                                                   x.x
| +	 * offline will wait until there is noone in this critical section
| +	 * before disabling IPI handling. */
| +	cpus_and(tmp, cpumask, cpu_online_map);
| +	if(cpus_empty(tmp))
        if (cpus_empty(tmp))
| +		goto out_unlock;


| @@ -527,6 +531,15 @@ int smp_call_function (void (*func) (voi
|  		atomic_set(&data.finished, 0);
|  
|  	spin_lock(&call_lock);
| +
| +	/* Subtle, get the current number of online cpus.
| +	 * Sample this under the lock; cpus in the the middle of going
                                                   x.x
| +	 * offline will wait until there is noone in this critical section
| +	 * before disabling IPI handling. */


| @@ -551,6 +565,20 @@ static void stop_this_cpu (void * dummy)
|  	 * Remove this CPU:
|  	 */
|  	cpu_clear(smp_processor_id(), cpu_online_map);
| +
| +	/* Subtle, IPI users assume that they will be able to get IPI's
| +	 * though to the cpus listed in cpu_online_map.  To ensure this
           through
| +	 * we add the requirement that they check cpu_online_map within
| +	 * the IPI critical sections.  Here we remove ourselves from the
| +	 * map, then ensure that all other cpus have left the relevant
| +	 * critical sections since the change.  We do this by aquiring
                                                              acquiring
| +	 * the relevant section locks, if we have them none else is in 
                                                       noone
| +	 * them.  Once this is done we can go offline. */


--
~Randy
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
