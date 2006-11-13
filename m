Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754731AbWKMPg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbWKMPg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755139AbWKMPg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:36:59 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:15315 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1754731AbWKMPg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:36:59 -0500
Date: Mon, 13 Nov 2006 21:07:08 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Srinivasa Ds <srinivasa@in.ibm.com>, anton@au1.ibm.com, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
Message-ID: <20061113153708.GA27695@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <45586EB5.40409@in.ibm.com> <20061113130926.GD7085@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113130926.GD7085@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 02:09:26PM +0100, Heiko Carstens wrote:
> > Since we are not supported by hardware for cpu hotplug. I have developed
> > the patch which will disable cpu hotplug on IBM bladecentre JS20. Please
> > let me know your comments on this please.
> 
> > +extern  int cpu_hotplug_disabled;
> > +extern  struct mutex cpu_add_remove_lock;
> [...]
> > +	if(rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE) {
> > +		mutex_lock(&cpu_add_remove_lock);
> > +		cpu_hotplug_disabled = 1;
> > +		mutex_unlock(&cpu_add_remove_lock);
> > +	}
> > +
> >  #endif /* CONFIG_HOTPLUG_CPU */
> >  #ifdef CONFIG_RTAS_ERROR_LOGGING
> >  	rtas_last_error_token = rtas_token("rtas-last-error");
> 
> You should add a function to kernel/cpu.c which you can call in order to
> disable cpu hotplug instead of exporting its private data structures.

Yup. Also, considering the fact that enable_nonboot_cpus() can reset
the cpu_hotplug_disabled flag, I would suggest the following:

a) create one additional state for cpu_hotplug_disabled, something
like

#define PERMANENTLY_DISABLED -1 

b) Define a function kernel/cpu.c

void disable_cpu_hotplug_perm()
{
	cpu_hotplug_disabled = PERMANENTLY_DISABLED;
}

and call it in rtas.c

c) Check for status of cpu_hotplug_disabled in functions cpu_up, 
   cpu_down, enable_nonboot_cpus and disable_nonboot_cpus and 
   if cpu_hotplug_disabled == PERMANENTLY_DISABLED, 
   return bypassing further code.

Thoughts?

Regards,
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
