Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVKQQIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVKQQIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVKQQIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:08:30 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31726 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932338AbVKQQIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:08:30 -0500
Subject: Re: [patch -rt] make gendev_rel_sem a compat_semaphore
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1132155299.6266.8.camel@localhost.localdomain>
References: <1132155092.6266.6.camel@localhost.localdomain>
	 <1132155299.6266.8.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 17 Nov 2005 08:08:29 -0800
Message-Id: <1132243709.6744.10.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How would you feel if we move this lock to a completion() . It's such a
small lock, and completions are faster anyway .. It might be a good test
bed for some other compat locks .

Daniel  


On Wed, 2005-11-16 at 10:34 -0500, Steven Rostedt wrote:
> Crap! I sent this with my kihontech email.  Please respond to this
> instead.  I'm still in the process of moving to my new machine, and the
> email was messed up.
> 
> Thanks,
> 
> -- Steve
> 
> 
> On Wed, 2005-11-16 at 10:31 -0500, Steven Rostedt wrote:
> > Hi Ingo,
> > 
> > I was getting the following:
> > 
> > BUG: nonzero lock count 10 at exit time?
> >         modprobe: 2972 [ffff81007e1aaf70, 116]
> > 
> > Call Trace:<ffffffff8014e2db>{printk_task+43} <ffffffff8015040f>{check_no_held_locks+111}
> >        <ffffffff80136d3c>{do_exit+3036} <ffffffff80136f5c>{do_group_exit+268}
> >        <ffffffff80136f72>{sys_exit_group+18} <ffffffff8011e471>{ia32_sysret+0}
> > 
> > ---------------------------
> > | preempt count: 00000000 ]
> > | 0-level deep critical section nesting:
> > ----------------------------------------
> > hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> > Uniform CD-ROM driver Revision: 3.20
> > 
> > BUG: modprobe/2972, lock held at task exit time!
> >  [ffffffff8809fd00] {(struct semaphore *)(&hwif->gendev_rel_sem)}
> > .. held by:          modprobe: 2972 [ffff81007e1aaf70, 116]
> > ... acquired at:               init_hwif_data+0xaf/0x1a0 [ide_core]
> > 
> > [snipped to not be so annoying]
> > 
> > Looking into this I see that gendev_rel_sem, which is only used when the
> > device is unregistered, is defined as a semaphore.  This patch changes
> > this to be a compat_semaphore.
> > 
> > -- Steve
> > 
> > Index: linux-2.6.14-rt13/include/linux/ide.h
> > ===================================================================
> > --- linux-2.6.14-rt13.orig/include/linux/ide.h	2005-11-15 11:12:37.000000000 -0500
> > +++ linux-2.6.14-rt13/include/linux/ide.h	2005-11-16 10:09:10.000000000 -0500
> > @@ -910,7 +910,7 @@
> >  	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
> >  
> >  	struct device	gendev;
> > -	struct semaphore gendev_rel_sem; /* To deal with device release() */
> > +	struct compat_semaphore gendev_rel_sem; /* To deal with device release() */
> >  
> >  	void		*hwif_data;	/* extra hwif data */
> >  
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

