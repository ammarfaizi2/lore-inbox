Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965359AbWHOKGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965359AbWHOKGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbWHOKGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:06:39 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:31651 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965356AbWHOKGi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:06:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: 2.6.18-rc4-mm1: eth0: trigger_send() called with the transmitter busy
Date: Tue, 15 Aug 2006 12:10:31 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <200608142325.59054.rjw@sisk.pl> <44E100B3.1060300@free.fr>
In-Reply-To: <44E100B3.1060300@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608151210.31440.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 01:01, Laurent Riffard wrote:
> Le 14.08.2006 23:25, Rafael J. Wysocki a écrit :
> > On Monday 14 August 2006 22:06, Laurent Riffard wrote:
> >> Le 14.08.2006 19:47, Laurent Riffard a écrit :
> >>> Le 14.08.2006 18:50, Andrew Morton a écrit :
> >>>> On Mon, 14 Aug 2006 16:38:47 +0200
> >>>> Laurent Riffard <laurent.riffard@free.fr> wrote:
> >>>>
> >>>>> Le 13.08.2006 10:24, Andrew Morton a __crit :
> >>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> >>>>> Hello,
> >>>>>
> >>>>> This morning, while trying to suspend to disk, my box started to loop 
> >>>>> displaying the following message:
> >>>>> eth0: trigger_send() called with the transmitter busy.
> >>>>>
> >>>>> Here is the scenario. I booted 2.6.18-rc4-mm1 with this command line:
> >>>>> root=/dev/vglinux1/lvroot video=vesafb:ywrap,mtrr splash=silent resume=/dev/hdb7 netconsole=@192.163.0.3/,@192.168.0.1/00:0E:9B:91:ED:72 init 1
> >>>>>
> >>>>> Then I issued:
> >>>>> # echo 6 > /proc/sys/kernel/printk
> >>>>> # echo disk > /sys/power/state
> >>>> ne2k isn't <ahem> the most actively-maintained driver.
> >>>>
> >>>> But most (I think all) net drivers have problems during suspend when
> >>>> netconsole is active.  Does disabling netconsole help?
> >>> Yes it does. 
> >>>  
> >>>> Did this operation work OK in earlier kernels, with netconsole enabled?
> >>> It's the first time I see such a message. I can't speak for 2.6.18-rc3-mm2 
> >>> because it could not suspend at all (did hang right after 
> >>> "echo disk > /sys/power/state"), but it worked in earlier kernels.
> >>>
> >>> I'll try with plain 2.6.18-rc4.
> >> Same problem with 2.6.18-rc4.
> > 
> > I think something like this will help (untested):
> 
> Well, sort of: it sometimes works, which is better than not. I tried
> about 10 times and it sometimes hangs after 'shrinking memory' or whilst 
> writing to the swap device.

Hm, suspicious ...

The swap partition is not on an LVM, is it?

> The message "eth0: trigger_send() called with the transmitter busy" didn't
> appear anymore. 

This is the one the patch was meant to get rid of.

> Note that I always have had a warning sowhere in acpi_pci_link_set during suspend:
>  BUG: sleeping function called from invalid context at include/asm/semaphore.h:99

Bad.  If that's 100% reproducible, could you please try to nail it down?
Please revert the "suspend_console" patch before doing this, because it turns
down all consoles altogether during the suspend.  You can also use the patch
and instructions at

http://marc.theaimsgroup.com/?l=linux-acpi&m=115506915023030&q=raw

to debug device drivers' suspend/resume without really suspending.

> I'm under the impression your patch is a workaround for my network problem. 
> Or must really netconsole be stopped during device_suspend ?

Yes, it must.  For now, the consoles are suspend-unfriendly, so to speak. ;-)

> >  kernel/power/disk.c |    7 +++++++
> >  1 files changed, 7 insertions(+)
> > 
> > Index: linux-2.6.18-rc4-mm1/kernel/power/disk.c
> > ===================================================================
> > --- linux-2.6.18-rc4-mm1.orig/kernel/power/disk.c
> > +++ linux-2.6.18-rc4-mm1/kernel/power/disk.c
> > @@ -119,8 +119,10 @@ int pm_suspend_disk(void)
> >  	if (error)
> >  		return error;
> >  
> > +	suspend_console();
> >  	error = device_suspend(PMSG_FREEZE);
> >  	if (error) {
> > +		resume_console();
> >  		printk("Some devices failed to suspend\n");
> >  		unprepare_processes();
> >  		return error;
> > @@ -133,6 +135,7 @@ int pm_suspend_disk(void)
> >  
> >  	if (in_suspend) {
> >  		device_resume();
> > +		resume_console();
> >  		pr_debug("PM: writing image.\n");
> >  		error = swsusp_write();
> >  		if (!error)
> > @@ -148,6 +151,7 @@ int pm_suspend_disk(void)
> >  	swsusp_free();
> >   Done:
> >  	device_resume();
> > +	resume_console();
> >  	unprepare_processes();
> >  	return error;
> >  }
> > @@ -212,7 +216,9 @@ static int software_resume(void)
> >  
> >  	pr_debug("PM: Preparing devices for restore.\n");
> >  
> > +	suspend_console();
> >  	if ((error = device_suspend(PMSG_PRETHAW))) {
> > +		resume_console();
> >  		printk("Some devices failed to suspend\n");
> >  		swsusp_free();
> >  		goto Thaw;
> > @@ -224,6 +230,7 @@ static int software_resume(void)
> >  	swsusp_resume();
> >  	pr_debug("PM: Restore failed, recovering.n");
> >  	device_resume();
> > +	resume_console();
> >   Thaw:
> >  	unprepare_processes();
> >   Done:
> 
> BTW, it doesn't apply cleanly:
> 
>   CC      kernel/power/disk.o
> kernel/power/disk.c: In function 'pm_suspend_disk':
> kernel/power/disk.c:122: warning: implicit declaration of function 'suspend_console'
> kernel/power/disk.c:125: warning: implicit declaration of function 'resume_console'

Thanks.  I think I'll prepare a bigger patch to add turning off the consoles
with a config switch to disable this.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
