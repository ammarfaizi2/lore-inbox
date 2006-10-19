Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWJSIfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWJSIfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWJSIfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:35:48 -0400
Received: from mx.go2.pl ([193.17.41.41]:51682 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1030320AbWJSIfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:35:47 -0400
Date: Thu, 19 Oct 2006 10:40:51 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] lockdep: fix ide/proc interaction
Message-ID: <20061019084051.GB1872@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161197380.3036.73.camel@taijtu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-2006 20:49, Peter Zijlstra wrote:
> rmmod/3080 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>  (proc_subdir_lock){--..}, at: [<c04a33b0>] remove_proc_entry+0x40/0x191
> 
> and this task is already holding:
>  (ide_lock){++..}, at: [<c05651a2>] ide_unregister_subdriver+0x39/0xc8
> which would create a new lock dependency:
>  (ide_lock){++..} -> (proc_subdir_lock){--..}
> 
> but this new dependency connects a hard-irq-safe lock:
>  (ide_lock){++..}
> ... which became hard-irq-safe at:
>   [<c043c458>] lock_acquire+0x4b/0x6b
>   [<c06129d7>] _spin_lock_irqsave+0x22/0x32
>   [<c0567870>] ide_intr+0x17/0x1a9
>   [<c044eb31>] handle_IRQ_event+0x20/0x4d
>   [<c044ebf2>] __do_IRQ+0x94/0xef
>   [<c0406771>] do_IRQ+0x9e/0xbd
> 
> to a hard-irq-unsafe lock:
>  (proc_subdir_lock){--..}
> ... which became hard-irq-unsafe at:
> ...  [<c043c458>] lock_acquire+0x4b/0x6b
>   [<c06126ab>] _spin_lock+0x19/0x28
>   [<c04a32f2>] xlate_proc_name+0x1b/0x99
>   [<c04a3547>] proc_create+0x46/0xdf
>   [<c04a3642>] create_proc_entry+0x62/0xa5
>   [<c07c1972>] proc_misc_init+0x1c/0x1d2
>   [<c07c1844>] proc_root_init+0x4c/0xe9
>   [<c07ad703>] start_kernel+0x294/0x3b3
>   [<00000000>] 0x0
> 
> Move ide_remove_proc_entries() out from under ide_lock; there is nothing
> that indicates that this is needed.
> 
> In specific, the call to ide_add_proc_entries() is unprotected, and there
> is nothing else in the file using the respective ->proc fields. Also the
> lock order around destroy_proc_ide_interface() suggests this.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  drivers/ide/ide.c |   19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/ide/ide.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide.c
> +++ linux-2.6/drivers/ide/ide.c
> @@ -973,8 +973,8 @@ ide_settings_t *ide_find_setting_by_name
>   *	@drive: drive
>   *
>   *	Automatically remove all the driver specific settings for this
> - *	drive. This function may sleep and must not be called from IRQ
> - *	context. The caller must hold ide_setting_sem.
> + *	drive. This function may not be called from IRQ context. The
> + *	caller must hold ide_setting_sem.
>   */
>   
>  static void auto_remove_settings (ide_drive_t *drive)
> @@ -1874,11 +1874,22 @@ void ide_unregister_subdriver(ide_drive_
>  {
>  	unsigned long flags;
>  	
> -	down(&ide_setting_sem);
> -	spin_lock_irqsave(&ide_lock, flags);
>  #ifdef CONFIG_PROC_FS
>  	ide_remove_proc_entries(drive->proc, driver->proc);

But now:
>  (proc_subdir_lock){--..}, at: [<c04a33b0>] remove_proc_entry+0x40/0x191

is taken here with irqs and bhs enabled (btw. this: {--..} looks
as if it wasn't called from here with spin_lock_irqsave?) 
IMHO it is hard to believe this lock isn't anywhere used in
hard or soft irq context so probably local_irq_disable/enable
or local_bh_disable/enable is needed around this.

>  #endif
> +	down(&ide_setting_sem);
> +	spin_lock_irqsave(&ide_lock, flags);
> +	/*
> +	 * ide_setting_sem protects the settings list
> +	 * ide_lock protects the use of settings
> +	 *
> +	 * so we need to hold both, ide_settings_sem because we want to
> +	 * modify the settings list, and ide_lock because we cannot take
> +	 * a setting out that is being used.
> +	 *
> +	 * OTOH both ide_{read,write}_setting are only ever used under
> +	 * ide_setting_sem.
> +	 */
>  	auto_remove_settings(drive);

But why auto_remove_settings and __ide_remove_setting comments
don't mention this ide_lock?

>  	spin_unlock_irqrestore(&ide_lock, flags);
>  	up(&ide_setting_sem);
> 

Regards,
Jarek P.
