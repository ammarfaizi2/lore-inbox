Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbUKMMbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbUKMMbW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 07:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUKMMbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 07:31:22 -0500
Received: from main.gmane.org ([80.91.229.2]:56519 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262666AbUKMMbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 07:31:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: ptb@lab.it.uc3m.es (Peter T. Breuer)
Subject: Re: kernel analyser to detect sleep under spinlock
Date: Sat, 13 Nov 2004 12:09:29 +0100
Message-ID: <9k6h62-a1v.ln1@news.it.uc3m.es>
References: <200411122345.iACNjqt09561@inv.it.uc3m.es>
X-Complaints-To: usenet@sea.gmane.org
Cc: linux-kernel@vger.kernel.org, ptb@lab.it.uc3m.es
X-Gmane-NNTP-Posting-Host: triangulo.it.uc3m.es
User-Agent: tin/1.7.4-20031226 ("Taransay") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter T. Breuer <ptb@inv.it.uc3m.es> wrote:
> I'll undertake a survey of the current kernel.

Just for kicks, I started with the DAC960.c driver (alphabet ..), and
it registered 6 alarms!

   Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers

     Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>

*  function                     line    calls (locks)
* - /usr/local/src/linux-2.6.3/drivers/block/DAC960.c
!! DAC960_BA_InterruptHandler   5219 DAC960_V2_ProcessCompletedCommand (1)
!! DAC960_LP_InterruptHandler   5262 DAC960_V2_ProcessCompletedCommand (1)
!! DAC960_V1_ExecuteUserCommand 5869    DAC960_WaitForCommand (1)
!! DAC960_V2_ExecuteUserCommand 6132    DAC960_WaitForCommand (1)
!! DAC960_gam_ioctl             6663    DAC960_WaitForCommand (1)
!! DAC960_gam_ioctl             6688    DAC960_WaitForCommand (1)

The ProcessCompletedCommand thing really is called under spinlock, but
it appears to be detected as sleepy because it calls kmalloc (and
kfree), however it calls kmalloc with GFP_ATOMIC, so it's not sleepy
and that's a false alarm. Ho hum ... I'll have to detect that.

The WaitForCommand is also definitely called under spinlock ... and is
thought to be sleepy because it calls schedule! Well, it calls
__wait_event(Controller->CommandWaitQueue, Controller->FreeCommands);
Is that going to schedule?  I suppose logically it should.

Anyway, that looks a legitimate complaint:

  spin_lock_irqsave(&Controller->queue_lock, flags);
  while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
    DAC960_WaitForCommand(Controller);
  spin_unlock_irqrestore(&Controller->queue_lock, flags);

Looks like it waits under spinlock to me!

I'll go write the generic inference engine required to make this a bit
more accurate still.



Peter

