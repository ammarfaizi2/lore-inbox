Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUDAFDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 00:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUDAFDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 00:03:08 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10938 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262236AbUDAFDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 00:03:05 -0500
Date: Thu, 1 Apr 2004 10:34:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, hari@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, rddunlap@osdl.org,
       linux-kernel@vger.kernel.org, jamesclv@us.ibm.com
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <20040401050413.GA4056@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040330173620.6fa69482.akpm@osdl.org> <276260000.1080697873@flay> <109577502.1080783067@[192.168.0.89]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109577502.1080783067@[192.168.0.89]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 01:31:15AM +0000, Andy Whitcroft wrote:
> 	spin_lock(&tlbstate_lock);
> +
> +	/* Subtle, mask the request mask with the currently online cpu's.
> +	 * Sample this under the lock; cpus in the the middle of going
> +	 * offline will wait until there is noone in this critical section
> +	 * before disabling IPI handling. */
> +	cpus_and(tmp, cpumask, cpu_online_map);
> +	if(cpus_empty(tmp))
> +		return;

Hmm ..Doesn't it need to drop tlbstate_lock before returning?

> +	/* Subtle, IPI users assume that they will be able to get IPI's
> +	 * though to the cpus listed in cpu_online_map.  To ensure this
> +	 * we add the requirement that they check cpu_online_map within
> +	 * the IPI critical sections.  Here we remove ourselves from the
> +	 * map, then ensure that all other cpus have left the relevant
> +	 * critical sections since the change.  We do this by aquiring
> +	 * the relevant section locks, if we have them none else is in
> +	 * them.  Once this is done we can go offline. */
> +	spin_lock(&tlbstate_lock);
> +	spin_unlock(&tlbstate_lock);
> +	spin_lock(&tlbstate_lock);
> +	spin_unlock(&tlbstate_lock);

The second lock should be call_lock?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
