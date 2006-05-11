Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWEKRP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWEKRP0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWEKRPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:15:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13205 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030377AbWEKRPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:15:24 -0400
Date: Thu, 11 May 2006 10:12:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH -mm] BusLogic gcc 4.1 warning fixes
Message-Id: <20060511101231.1ef72659.akpm@osdl.org>
In-Reply-To: <200605101728.k4AHSTIM004411@dwalker1.mvista.com>
References: <200605101728.k4AHSTIM004411@dwalker1.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker <dwalker@mvista.com> wrote:
>
> This at least makes the used away of the failure .
> ---
> 
> 
> I just commented out BusLogic_AbortCommand because the code that uses it is 
> commented out the same way .. It could just be removed .
> 
> Fixes the following warnings,
> 
> drivers/scsi/BusLogic.c: In function 'BusLogic_init':
> drivers/scsi/BusLogic.c:2302: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
> drivers/scsi/BusLogic.c: At top level:
> drivers/scsi/BusLogic.c:2963: warning: 'BusLogic_AbortCommand' defined but not used
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.16/drivers/scsi/BusLogic.c
> ===================================================================
> --- linux-2.6.16.orig/drivers/scsi/BusLogic.c
> +++ linux-2.6.16/drivers/scsi/BusLogic.c
> @@ -2299,7 +2299,8 @@ static int __init BusLogic_init(void)
>  				scsi_host_put(Host);
>  			} else {
>  				BusLogic_InitializeHostStructure(HostAdapter, Host);
> -				scsi_add_host(Host, HostAdapter->PCI_Device ? &HostAdapter->PCI_Device->dev : NULL);
> +				if (scsi_add_host(Host, HostAdapter->PCI_Device ? &HostAdapter->PCI_Device->dev : NULL))
> +					printk(KERN_WARNING "BusLogic: scsi_add_host() failed!\n");
>  				scsi_scan_host(Host);
>  				BusLogicHostAdapterCount++;
>  			}
> @@ -2955,6 +2956,7 @@ static int BusLogic_QueueCommand(struct 
>  }

Methinks that if scsi_add_host() fails we'll need to do more serious things
here - we cannot just go ahead and pretend that it worked.

So it's best to leave the warning there for now.

The appropriate recovery code is just a few lines up from here - reusing
that might be appropriate.  And while you're there, this function should
return -Esomething if it failed, rather than pretending to work.

