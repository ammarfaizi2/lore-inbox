Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWEIVl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWEIVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWEIVl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:41:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44481 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751167AbWEIVlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:41:55 -0400
From: Andi Kleen <ak@suse.de>
To: dzickus <dzickus@redhat.com>
Subject: Re: [patch 8/8] Add abilty to enable/disable nmi watchdog from sysfs
Date: Tue, 9 May 2006 23:37:53 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net
References: <20060509205035.446349000@drseuss.boston.redhat.com> <20060509205958.578466000@drseuss.boston.redhat.com>
In-Reply-To: <20060509205958.578466000@drseuss.boston.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605092337.53416.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 22:50, dzickus wrote:
> 
> Adds a new /proc/sys/kernel/nmi call that will enable/disable the nmi
> watchdog.

The subject is wrong i think - sysctl != sysfs.

And shouldn't that be called nmi_watchdog? 

> 
> Signed-off-by:  Don Zickus <dzickus@redhat.com>
> 
> Index: linux-don/arch/i386/kernel/nmi.c
> ===================================================================
> --- linux-don.orig/arch/i386/kernel/nmi.c
> +++ linux-don/arch/i386/kernel/nmi.c
> @@ -845,6 +845,56 @@ static int unknown_nmi_panic_callback(st
>  	return 0;
>  }
>  
> +/*
> + * proc handler for /proc/sys/kernel/nmi
> + */
> +int proc_nmi_enabled(struct ctl_table *table, int write, struct file *file,
> +			void __user *buffer, size_t *length, loff_t *ppos)
> +{
> +	int old_state;
> +
> +	nmi_watchdog_enabled = (atomic_read(&nmi_active) > 0) ? 1 : 0;
> +	old_state = nmi_watchdog_enabled;
> +	proc_dointvec(table, write, file, buffer, length, ppos);
> +	if (!!old_state == !!nmi_watchdog_enabled)
> +		return 0;
> +
> +	if (atomic_read(&nmi_active) < 0) {
> +		printk( KERN_WARNING "NMI watchdog is permanently disabled\n");
> +		return 0;
> +	}

The returns should be probably -EIO or similar. Same further down.

> +
> +	if (nmi_watchdog == NMI_DEFAULT) {
> +		if (nmi_known_cpu() > 0)
> +			nmi_watchdog = NMI_LOCAL_APIC;
> +		else
> +			nmi_watchdog = NMI_IO_APIC;
> +	}
> +
> +	if (nmi_watchdog == NMI_LOCAL_APIC)
> +	{

Move the { up

Anyways I fixed these up myself, no need to resubmit.

-Andi
