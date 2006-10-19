Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422906AbWJSLF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422906AbWJSLF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423080AbWJSLF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:05:27 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:27613 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422906AbWJSLF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:05:26 -0400
Subject: Re: [PATCH] lockdep: fix ide/proc interaction
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20061019084051.GB1872@ff.dom.local>
References: <20061019084051.GB1872@ff.dom.local>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 13:05:56 +0200
Message-Id: <1161255956.3036.84.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 10:40 +0200, Jarek Poplawski wrote:
> On 18-10-2006 20:49, Peter Zijlstra wrote:

> > Index: linux-2.6/drivers/ide/ide.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/ide/ide.c
> > +++ linux-2.6/drivers/ide/ide.c
> > @@ -973,8 +973,8 @@ ide_settings_t *ide_find_setting_by_name
> >   *	@drive: drive
> >   *
> >   *	Automatically remove all the driver specific settings for this
> > - *	drive. This function may sleep and must not be called from IRQ
> > - *	context. The caller must hold ide_setting_sem.
> > + *	drive. This function may not be called from IRQ context. The
> > + *	caller must hold ide_setting_sem.
> >   */
> >   
> >  static void auto_remove_settings (ide_drive_t *drive)
> > @@ -1874,11 +1874,22 @@ void ide_unregister_subdriver(ide_drive_
> >  {
> >  	unsigned long flags;
> >  	
> > -	down(&ide_setting_sem);
> > -	spin_lock_irqsave(&ide_lock, flags);
> >  #ifdef CONFIG_PROC_FS
> >  	ide_remove_proc_entries(drive->proc, driver->proc);
> 
> But now:
> >  (proc_subdir_lock){--..}, at: [<c04a33b0>] remove_proc_entry+0x40/0x191
> 
> is taken here with irqs and bhs enabled (btw. this: {--..} looks
> as if it wasn't called from here with spin_lock_irqsave?) 
> IMHO it is hard to believe this lock isn't anywhere used in
> hard or soft irq context so probably local_irq_disable/enable
> or local_bh_disable/enable is needed around this.

it really isnt, check fs/proc/{generic,proc_devtree}.c

> >  #endif
> > +	down(&ide_setting_sem);
> > +	spin_lock_irqsave(&ide_lock, flags);
> > +	/*
> > +	 * ide_setting_sem protects the settings list
> > +	 * ide_lock protects the use of settings
> > +	 *
> > +	 * so we need to hold both, ide_settings_sem because we want to
> > +	 * modify the settings list, and ide_lock because we cannot take
> > +	 * a setting out that is being used.
> > +	 *
> > +	 * OTOH both ide_{read,write}_setting are only ever used under
> > +	 * ide_setting_sem.
> > +	 */
> >  	auto_remove_settings(drive);
> 
> But why auto_remove_settings and __ide_remove_setting comments
> don't mention this ide_lock?

Because comments suck ;-) and it might not be needed, see the OTOH.
Feel free to send a patch updating the comments.

Peter

