Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319197AbSHTRgH>; Tue, 20 Aug 2002 13:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319200AbSHTRgH>; Tue, 20 Aug 2002 13:36:07 -0400
Received: from host.greatconnect.com ([209.239.40.135]:38159 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S319197AbSHTRgG>; Tue, 20 Aug 2002 13:36:06 -0400
Subject: Re: 2.4.20-pre2-ac4 oops at boot
From: Samuel Flory <sflory@rackable.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1029800778.21212.8.camel@irongate.swansea.linux.org.uk>
References: <1029797620.5308.73.camel@flory.corp.rackablelabs.com> 
	<1029800778.21212.8.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 10:38:58 -0700
Message-Id: <1029865139.5308.80.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Thanks! That seems to fix it.


On Mon, 2002-08-19 at 16:46, Alan Cox wrote:
> On Mon, 2002-08-19 at 23:53, Samuel Flory wrote:
> >   I've been having problem with the ac kernels, and tyan 2720. (Dual
> > xeon E7500 chipset.) Under 2.4.20-pre2-ac4 it spews a bunch of "Trying
> > to free nonexistent resource" when initializing the ide interface, and
> 
> Those are on my fix list but harmless
> 
> > dies.  Under 2.4.19-ac4 the system netboots, but oops when I attempt to
> > create a filesystem on a 3ware controller.  Under 2.4.19 the system
> 
> 2.4.19-ac4 balancing oops is fixed (I turned it off)
> 
> 
> > ksymoops 2.4.4 on i686 2.4.20-pre2-ac3.  Options used
> >      -v /stuff/src/linux-2.4.20-pre2-ac4/vmlinux (specified)
> >      -K (specified)
> >      -L (specified)
> >      -O (specified)
> >      -m /boot/System.map-2.4.20-pre2-ac4 (specified)
> > 
> 
> Ok random crap code. You had no pci_host_proc_list and that rather upset
> things. This converts the failing code it into something resembling same
> programming I hope and should fix your boot
> 
> Please let me know if it fixes the bug
> 
> 
> ----
> 

> --- drivers/ide/ide-proc.c~	2002-08-20 00:48:53.000000000 +0100
> +++ drivers/ide/ide-proc.c	2002-08-20 00:48:53.000000000 +0100
> @@ -914,11 +914,14 @@
>  				proc_ide_read_drivers, NULL);
>  
>  #ifdef CONFIG_BLK_DEV_IDEPCI
> -	while ((p->name != NULL) && (p->set) && (p->get_info != NULL)) {
> -		p->parent = proc_ide_root;
> -		create_proc_info_entry(p->name, 0, p->parent, p->get_info);
> -		p->set = 2;
> -		if (p->next == NULL) return;
> +	while (p != NULL)
> +	{
> +		if (p->name != NULL && p->set && p->get_info != NULL) 
> +		{
> +			p->parent = proc_ide_root;
> +			create_proc_info_entry(p->name, 0, p->parent, p->get_info);
> +			p->set = 2;
> +		}
>  		p = p->next;
>  	}
>  #endif /* CONFIG_BLK_DEV_IDEPCI */


