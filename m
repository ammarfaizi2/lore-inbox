Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbUKJXIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbUKJXIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUKJXIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:08:52 -0500
Received: from fmr03.intel.com ([143.183.121.5]:14781 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262137AbUKJXIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:08:41 -0500
Date: Wed, 10 Nov 2004 15:04:01 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Greg KH <greg@kroah.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Hotplug List <linux-hotplug-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kobject: fix double kobject_put in kobject_unregister()
Message-ID: <20041110150400.C13668@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20041110141923.A13668@unix-os.sc.intel.com> <20041110225421.GA16785@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041110225421.GA16785@kroah.com>; from greg@kroah.com on Wed, Nov 10, 2004 at 02:54:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 02:54:21PM -0800, Greg KH wrote:
> On Wed, Nov 10, 2004 at 02:19:23PM -0800, Keshavamurthy Anil S wrote:
> > Hi Greg,
> > 	
> > This patch fixes the problem where in kobject resources were getting
> > freed when those kobject were still in use due to double kobject_put()
> > getting called in the kobject_unregister() code path.
> > 
> > With out this patch kobject_unregister() will have some serious side effects.
> > 
> > Please apply.
> > 
> > signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > 
> > 
> >  linux-2.6.10-rc1-mm4-askeshav/lib/kobject.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff -puN lib/kobject.c~kobject_unregister_fix lib/kobject.c
> > --- linux-2.6.10-rc1-mm4/lib/kobject.c~kobject_unregister_fix	2004-11-10 13:43:42.243877455 -0800
> > +++ linux-2.6.10-rc1-mm4-askeshav/lib/kobject.c	2004-11-10 13:46:30.788797265 -0800
> > @@ -301,6 +301,8 @@ void kobject_del(struct kobject * kobj)
> >  {
> >  	kobject_hotplug(kobj, KOBJ_REMOVE);
> >  	sysfs_remove_dir(kobj);
> > +
> > +	/* unlink does kobject_put() for us */
> >  	unlink(kobj);
> >  }
> >  
> > @@ -313,7 +315,6 @@ void kobject_unregister(struct kobject *
> >  {
> >  	pr_debug("kobject %s: unregistering\n",kobject_name(kobj));
> >  	kobject_del(kobj);
> > -	kobject_put(kobj);
> >  }
> 
> No, this is wrong.  Count the add and put in the sequence of:
> 	kobject_register()
> 	kobject_unregister()
> 
> they are balanced.
> 
> You mention you are seeing problems.  Have a trace?  Example code?

Here is the call trace when I tried to do kobject_unregiser()
Call Trace:
 [<a000000100016de0>] show_stack+0x80/0xa0
                                sp=e00000000e3cf730 bsp=e00000000e3c9230
 [<a000000100017640>] show_regs+0x840/0x880
                                sp=e00000000e3cf900 bsp=e00000000e3c91c8
 [<a000000100023f10>] die+0x150/0x1c0
                                sp=e00000000e3cf910 bsp=e00000000e3c9188
 [<a000000100023fc0>] die_if_kernel+0x40/0x60
                                sp=e00000000e3cf910 bsp=e00000000e3c9158
 [<a0000001000240f0>] ia64_fault+0x110/0x1060
                                sp=e00000000e3cf910 bsp=e00000000e3c9100
 [<a00000010000dae0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000000e3cfb20 bsp=e00000000e3c9100
 [<a0000001002743e0>] strlen+0x20/0x140
                                sp=e00000000e3cfcf0 bsp=e00000000e3c90a8
 [<a00000010026a270>] kobject_get_path+0x150/0x1e0
                                sp=e00000000e3cfcf0 bsp=e00000000e3c9068
 [<a00000010026a770>] kobject_hotplug+0x350/0x6e0
                                sp=e00000000e3cfcf0 bsp=e00000000e3c9008
 [<a0000001002695b0>] kobject_del+0x30/0x80
                                sp=e00000000e3cfd10 bsp=e00000000e3c8fe0
 [<a000000100269620>] kobject_unregister+0x20/0x60
                                sp=e00000000e3cfd10 bsp=e00000000e3c8fc0
 [<a000000100302420>] acpi_device_unregister+0x320/0x340
                                sp=e00000000e3cfd10 bsp=e00000000e3c8fa0
 [<a000000100302b70>] acpi_bus_remove+0x2f0/0x340
                                sp=e00000000e3cfd10 bsp=e00000000e3c8f68
 [<a000000100302ec0>] acpi_bus_trim+0x300/0x440
                                sp=e00000000e3cfd30 bsp=e00000000e3c8f18
 [<a000000100303110>] acpi_eject_store+0x110/0x240
                                sp=e00000000e3cfde0 bsp=e00000000e3c8ee0
 [<a000000100301fb0>] acpi_device_attr_store+0x70/0xa0
                                sp=e00000000e3cfe20 bsp=e00000000e3c8ea8
 [<a0000001001864b0>] sysfs_write_file+0x270/0x300
                                sp=e00000000e3cfe20 bsp=e00000000e3c8e58
 [<a0000001001052e0>] vfs_write+0x200/0x2c0

I will try to explain the what is happening here.

I have a sysfs tree like this.
.../_SB/LSB0 
.../_SB/LSB0/CPU5
.../_SB/LSB0/MEM1
.../_SB/LSB0/MEM2

Say LSB0 is kobj1, CPU5 is kobj2, MEM1 is kobj3, MEM2 is kobj4

All I am trying to do is first I will do kobject_unregister(kobj2),then 
kobject_unregister(kobj3), then kobject_unregister(kobj4) and now
when I try to do kobject_unregister(kobj1) i.e when I am trying to remove
LSB0 directory, I am seeing the above stack trace.

The patch I posted fixed this problem.

Let me know if you need more data.

-Anil



> 
> thanks,
> 
> gre k-h
