Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbUKNPBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbUKNPBj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 10:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUKNPBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 10:01:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28808 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261312AbUKNPBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 10:01:36 -0500
Date: Sun, 14 Nov 2004 16:01:31 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@lab.it.uc3m.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel analyser to detect sleep under spinlock
Message-ID: <20041114150131.GE19525@suse.de>
References: <200411122345.iACNjqt09561@inv.it.uc3m.es> <9k6h62-a1v.ln1@news.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9k6h62-a1v.ln1@news.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13 2004, Peter T. Breuer wrote:
> Peter T. Breuer <ptb@inv.it.uc3m.es> wrote:
> > I'll undertake a survey of the current kernel.
> 
> Just for kicks, I started with the DAC960.c driver (alphabet ..), and
> it registered 6 alarms!
> 
>    Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
> 
>      Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
> 
> *  function                     line    calls (locks)
> * - /usr/local/src/linux-2.6.3/drivers/block/DAC960.c
> !! DAC960_BA_InterruptHandler   5219 DAC960_V2_ProcessCompletedCommand (1)
> !! DAC960_LP_InterruptHandler   5262 DAC960_V2_ProcessCompletedCommand (1)
> !! DAC960_V1_ExecuteUserCommand 5869    DAC960_WaitForCommand (1)
> !! DAC960_V2_ExecuteUserCommand 6132    DAC960_WaitForCommand (1)
> !! DAC960_gam_ioctl             6663    DAC960_WaitForCommand (1)
> !! DAC960_gam_ioctl             6688    DAC960_WaitForCommand (1)
> 
> The ProcessCompletedCommand thing really is called under spinlock, but
> it appears to be detected as sleepy because it calls kmalloc (and
> kfree), however it calls kmalloc with GFP_ATOMIC, so it's not sleepy
> and that's a false alarm. Ho hum ... I'll have to detect that.
> 
> The WaitForCommand is also definitely called under spinlock ... and is
> thought to be sleepy because it calls schedule! Well, it calls
> __wait_event(Controller->CommandWaitQueue, Controller->FreeCommands);
> Is that going to schedule?  I suppose logically it should.
> 
> Anyway, that looks a legitimate complaint:
> 
>   spin_lock_irqsave(&Controller->queue_lock, flags);
>   while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
>     DAC960_WaitForCommand(Controller);
>   spin_unlock_irqrestore(&Controller->queue_lock, flags);
> 
> Looks like it waits under spinlock to me!

static void DAC960_WaitForCommand(DAC960_Controller_T *Controller)
{
  spin_unlock_irq(&Controller->queue_lock);
  __wait_event(Controller->CommandWaitQueue, Controller->FreeCommands);
  spin_lock_irq(&Controller->queue_lock);
}

Looks alright to me, I don't understand your confusion. One thing you
could say is that either the path to DAC960_WaitForCommand should not
save interrupt flags, _or_ it's a bug to use spin_unlock_irq() if
interrutps could already be disabled at that point.

-- 
Jens Axboe

