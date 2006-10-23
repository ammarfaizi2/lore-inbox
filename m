Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWJWU4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWJWU4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWJWU4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:56:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:24864 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751429AbWJWU4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:56:46 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,343,1157353200"; 
   d="scan'208"; a="150877630:sNHT48147736"
Date: Mon, 23 Oct 2006 13:56:43 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Russ Anderson <rja@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Mixed Madison and Montecito system support
Message-ID: <20061023205643.GA13990@intel.com>
References: <200610130325.k9D3PwIo17962445@clink.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610130325.k9D3PwIo17962445@clink.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: linux-kernel for generic bit of this change.  Rest of patch was
posted to linux-ia64: http://marc.theaimsgroup.com/?l=linux-ia64&m=116070997529216&w=2

On Thu, Oct 12, 2006 at 10:25:58PM -0500, Russ Anderson wrote:
>  int sched_create_sysfs_power_savings_entries(struct sysdev_class *cls)
>  {
> -	int err = 0;
> +	int err = 0, c;
>  
>  #ifdef CONFIG_SCHED_SMT
> -	if (smt_capable())
> -		err = sysfs_create_file(&cls->kset.kobj,
> +	for_each_online_cpu(c)
> +		if (smt_capable(c)) {
> +			err = sysfs_create_file(&cls->kset.kobj,
>  					&attr_sched_smt_power_savings.attr);
> +			break;
> +		}
>  #endif

What if you booted an all-Madison system, and then hot-plugged some
Montecitos later?  Either we'd need the hotplug cpu code to run through
this routine again to re-test whether any cpu has multi-thread support
(it doesn't look like it does that now).

Or perhaps it would be simpler to dispense with this test and always
call sysfs_create_file() here (still inside CONFIG_SCHED_SMT) so that
the hook is always present to tune the scheduler (even if it may be
ineffective on a no-smt system)?

-Tony
