Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVG0AZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVG0AZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVG0AZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:25:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262408AbVG0AYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:24:37 -0400
Date: Tue, 26 Jul 2005 17:23:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: tony.luck@intel.com
Cc: kaneshige.kenji@jp.fujitsu.com, ambx1@neo.rr.com, greg@kroah.org,
       pavel@ucw.cz, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
Message-Id: <20050726172328.1bb5c812.akpm@osdl.org>
In-Reply-To: <200507270014.j6R0EYMv005786@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03FCF24C@scsmsx401.amr.corp.intel.com>
	<200507270014.j6R0EYMv005786@agluck-lia64.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tony.luck@intel.com wrote:
>
> Andrew Morton wrote:
> > "Luck, Tony" <tony.luck@intel.com> wrote:
> > >
> > > I started on my OLS homework from Andrew ... and began looking
> > > into what is going on here.
> > > 
> > 
> > Thanks ;) I guess we'll end up with a better kernel, even though you appear
> > to be an innocent victim here.
> 
> The "Badness in iosapic_unregister_intr at arch/ia64/kernel/iosapic.c:851"
> messages are caused by a missing call to free_irq() in the mpt/fusion driver.
> I think that it should go here ... but someone with a clue should verify:
> 
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -1384,6 +1384,8 @@ mpt_suspend(struct pci_dev *pdev, pm_mes
>  	/* Clear any lingering interrupt */
>  	CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
>  
> +	free_irq(ioc->pci_irq, ioc);
> +
>  	pci_disable_device(pdev);
>  	pci_set_power_state(pdev, device_state);
>  

OK, great.  Pavel, can you check this over please?

> But even this doesn't fix the hang during shutdown :-(
> 
> The remaining problem is cause by the order of the calls in sys_reboot:
> 
>                 device_suspend(PMSG_SUSPEND);
>                 device_shutdown();
> 
> The call to device_suspend() shuts down the mpt/fusion driver.  But then
> device_shutdown() calls sd_shutdown() which prints:
> 
>   Synchronizing SCSI cache for disk sdb
> 
> and then calls sd_sync_cache().  Now since we suspended mpt/fusion, this is
> going to go nowhere.
> 
> I don't know how to fix this.  Re-ordering the suspend & shutdown just looks
> wrong.

Again, Pavel has been working on this code and might be able to suggest
something which is appropriate for 2.6.13...

