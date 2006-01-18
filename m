Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWARTJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWARTJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWARTJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:09:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49329 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030369AbWARTJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:09:43 -0500
Date: Wed, 18 Jan 2006 14:09:27 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, arjan@infradead.org
Subject: Re: 2.6.16-rc1-mm1
Message-ID: <20060118190926.GB316@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Reuben Farrelly <reuben-lkml@reub.net>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	arjan@infradead.org
References: <20060118005053.118f1abc.akpm@osdl.org> <43CE2210.60509@reub.net> <20060118032716.7f0d9b6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118032716.7f0d9b6a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 03:27:16AM -0800, Andrew Morton wrote:

 > Well yes, that code is kfree()ing a locked mutex.  It's somewhat weird to
 > take a lock on a still-private object but whatever.  The code's legal
 > enough.
 > 
 > 
 > --- devel/drivers/cpufreq/cpufreq.c~cpufreq-mutex-locking-fix	2006-01-18 03:25:33.000000000 -0800
 > +++ devel-akpm/drivers/cpufreq/cpufreq.c	2006-01-18 03:25:55.000000000 -0800
 > @@ -674,6 +674,7 @@ err_out_driver_exit:
 >  		cpufreq_driver->exit(policy);
 >  
 >  err_out:
 > +	mutex_unlock(&policy->lock);
 >  	kfree(policy);
 >  

This looks odd, because we do this..

    mutex_unlock(&policy->lock);

    /* set default policy */

    ret = cpufreq_set_policy(&new_policy);
    if (ret) {
        dprintk("setting policy failed\n");
        goto err_out_unregister;
    }

	...

err_out_unregister:
    spin_lock_irqsave(&cpufreq_driver_lock, flags);
    for_each_cpu_mask(j, policy->cpus)
        cpufreq_cpu_data[j] = NULL;
    spin_unlock_irqrestore(&cpufreq_driver_lock, flags);

    kobject_unregister(&policy->kobj);
    wait_for_completion(&policy->kobj_unregister);

err_out_driver_exit:
    if (cpufreq_driver->exit)
        cpufreq_driver->exit(policy);

err_out:
    kfree(policy);


With the patch above we'll mutex_unlock twice.
Is that allowed ? It sounds wrong to me.

		Dave

