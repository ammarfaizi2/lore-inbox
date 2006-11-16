Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755483AbWKPWr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbWKPWr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755485AbWKPWr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:47:58 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55191 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1755483AbWKPWr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:47:57 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christian Hoffmann <chrmhoffmann@gmail.com>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Thu, 16 Nov 2006 23:44:40 +0100
User-Agent: KMail/1.9.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611151109.06956.rjw@sisk.pl> <200611162317.30880.chrmhoffmann@gmail.com>
In-Reply-To: <200611162317.30880.chrmhoffmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611162344.41622.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 16 November 2006 23:17, Christian Hoffmann wrote:
> 
> > >
> > > Well, if you acquire the console sem you need to release it too :-)
> >
> > Or the console semaphore is acquired too many times.
> >
> > Christian, could you please add release_console_sem() before 'return 0'
> > and see if that makes the code work again?  If not, could you add a
> > printk() in kernel/printk.c/acquire_console_sem() to see how many times it
> > is called?
> 
> Ok, I did that and the machine resumes OK. Now I have the impression that 
> accessing the rinfo struct here:
> 
> if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
>                 /* Wakeup chip. Check from config space if we were powered off
>                  * (todo: additionally, check CLK_PIN_CNTL too)
>                  */
>                 if ((rinfo->pm_mode & radeon_pm_off) &&
>                         radeon_restore_pci_cfg(rinfo)) {

I think the call to radeon_restore_pci_cfg(rinfo) causes the problem to happen.

>                         if (rinfo->reinit_func != NULL) {
>                                 rinfo->reinit_func(rinfo);
>                                 }
>                         else {
>                                 goto bail;
>                         }
>                 }
>                 /* If we support D2, try to resume... we should check what was 
> our
>                  * state though... (were we really in D2 state ?). Right now, 
> this code
>                  * is only enable on Macs so it's fine.
>                  */
>                 else if (rinfo->pm_mode & radeon_pm_d2){
>                         radeon_set_suspend(rinfo, 0);
>                 }
>                 rinfo->asleep = 0; ////makes it crash
>         } else {
>                 radeon_engine_idle();
>         }
> 
> makes the resume fail. The machine locks up. I started xorg without drm/dri 
> and then it goes a little further and locks up in the next steps:        
> 
> /* Restore display & engine */
> radeon_write_mode (rinfo, &rinfo->state, 1);
> 
> But it starts to get too complicated for me :(

Unfortunately for me too.  Someone who knows the radeonfb code is needed.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
