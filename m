Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWEUMLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWEUMLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 08:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWEUMLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 08:11:08 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:32161 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751534AbWEUMLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 08:11:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm2 (hard lockup after resume from disk on AMD64)
Date: Sun, 21 May 2006 14:07:32 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20060520054103.46a6edb5.akpm@osdl.org> <200605202322.40214.rjw@sisk.pl> <20060520143017.43a87c3a.akpm@osdl.org>
In-Reply-To: <20060520143017.43a87c3a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605211407.33124.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 May 2006 23:30, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Saturday 20 May 2006 14:41, Andrew Morton wrote:
> >  > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm2/
> > 
> >  My box (Asus L5D, x86_64 kernel) locks up hard after the resume from suspend
> >  to disk.  This happens right after the console has been restored and only if
> >  all modules are loaded before suspend (eg. it doesn't lock up when booted with
> >  init=/bin/bash).  Also it's caught by the softlockup watchdog which produces
> >  traces similar to the appended one.
> > 
> >  Greetings,
> >  Rafael
> > 
> > 
> >  BUG: soft lockup detected on CPU#0!
> > 
> >  Call Trace: <IRQ> <ffffffff8025b2f1>{softlockup_tick+193}
> >         <ffffffff802360a3>{run_local_timers+19} <ffffffff802362c7>{update_process_times+87}
> >         <ffffffff8020e174>{main_timer_handler+548} <ffffffff8020e3c5>{timer_interrupt+21}
> >         <ffffffff8025b4e3>{handle_IRQ_event+51} <ffffffff8025b5d2>{__do_IRQ+162}
> >         <ffffffff8020c3b1>{do_IRQ+65} <ffffffff80209d5e>{ret_from_intr+0}
> >         <ffffffff803cb8d0>{urb_destroy+0} <ffffffff803ca84a>{usb_hcd_poll_rh_status+250}
> >         <ffffffff880dafa2>{:ohci_hcd:ohci_irq+194} <ffffffff803c9ce2>{usb_hcd_irq+50}
> >         <ffffffff8025b4e3>{handle_IRQ_event+51} <ffffffff8025b5d2>{__do_IRQ+162}
> >         <ffffffff8020c3b1>{do_IRQ+65} <ffffffff80209d5e>{ret_from_intr+0}
> >         <ffffffff8025b4d4>{handle_IRQ_event+36} <ffffffff8025b5d2>{__do_IRQ+162}
> >         <ffffffff8020c3b1>{do_IRQ+65} <ffffffff80209d5e>{ret_from_intr+0}
> >         <ffffffff8025b4d4>{handle_IRQ_event+36} <ffffffff8025b5d2>{__do_IRQ+162}
> >         <ffffffff8020c3b1>{do_IRQ+65} <ffffffff80209d5e>{ret_from_intr+0} <EOI>
> >         <ffffffff803cb8d0>{urb_destroy+0} <ffffffff803cb788>{hcd_submit_urb+2072}
> >         <ffffffff80463d4d>{_spin_unlock_irqrestore+29} <ffffffff803cb9a5>{usb_free_urb+21}
> >         <ffffffff803ca0ab>{usb_hcd_giveback_urb+315} <ffffffff80463d4d>{_spin_unlock_irqrestore+29}
> >         <ffffffff803cbd2b>{usb_submit_urb+859} <ffffffff803cc66a>{usb_start_wait_urb+122}
> >         <ffffffff8027c58d>{dbg_redzone1+29} <ffffffff8027d804>{cache_alloc_debugcheck_after+532}
> >         <ffffffff8027c58d>{dbg_redzone1+29} <ffffffff803cca40>{usb_control_msg+240}
> >         <ffffffff803c5e74>{set_port_feature+68} <ffffffff803c61f9>{hub_port_reset+57}
> >         <ffffffff803c64d1>{hub_port_init+129} <ffffffff803c8b31>{hub_thread+2241}
> >         <ffffffff80242140>{autoremove_wake_function+0} <ffffffff803c8270>{hub_thread+0}
> >         <ffffffff80241f29>{kthread+217} <ffffffff80463d84>{_spin_unlock_irq+20}
> >         <ffffffff80228d99>{schedule_tail+73} <ffffffff8020a38a>{child_rip+8}
> >         <ffffffff80241e50>{kthread+0} <ffffffff8020a382>{child_rip+0}
> >  BUG: soft lockup detected on CPU#0!
> 
> What a revolting backtrace.  There were some x86_64 precise-backtrace
> patches floating around on the list this week.

They seem to reappear and get squashed by Andi on a regular basis. ;-)

> Still, it would appear that USB has become confused.  If you have the time
> to do a bisection search, I'd start in on gregkh-usb-*.patch.

Obviously it's this one:

gregkh-usb-usb-ohci-avoids-root-hub-timer-polling.patch

[Well, looks like it hasn't been tested properly before posting ... :-(]
