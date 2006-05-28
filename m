Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWE1HQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWE1HQf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 03:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWE1HQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 03:16:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30994 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751732AbWE1HQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 03:16:34 -0400
Date: Sun, 28 May 2006 07:16:22 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Rafa Bilski <rafalbilski@interia.pl>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [PATCH] Longhaul - call suspend(PMSG_FREEZE) before and resume() after
Message-ID: <20060528071622.GA4108@ucw.cz>
References: <4478D319.2030707@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4478D319.2030707@interia.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I posted this to Dave Jones, but:
> > This really should also get posted to linux-kernel, though I don't
> > think people are going to be particularly enthusiastic about exposing
> > these innards to modules.
> So I'm posting this patch here too. I'm not subscribed to this list.
> If You wish email me.
> Minor change: preempt_disabled() goto_sleep_pci() and wakeup_pci() 
> causes "sheduling while atomic". So in this patch below it isn't
> preempt_disabled(). But I think that this should be protected
> in some way. 

Well, suspend/resume is normally called during system suspend/resume,
so it has 'interesting' locking requirements.

> How it works:
> 1. Call suspend(PMSG_FREEZE) for each block device.
> 2. Call suspend(PMSG_FREEZE) for each PCI device.
> 3. Change CPU frequency.
> 4. Call resume() for each PCI device.
> 5. Call resume() for each block device.
> 
> Result: No more broken DMA transfers caused by frequency change.

Result: system hang if userspace tries to do request at the same time
-- PCI drivers probably were not designed for _that_... but we
probably want to fix them, anyway, so this is probably ok (but expect
to do some driver debugging).

But you should really add that preempt_disable and not try this on smp
system...
						Pavel

-- 
Thanks for all the (sleeping) penguins.
