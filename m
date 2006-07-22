Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWGVJj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWGVJj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 05:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWGVJj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 05:39:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49131 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751305AbWGVJj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 05:39:59 -0400
Date: Sat, 22 Jul 2006 02:39:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Komal Shah" <komal_shah802003@yahoo.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, dtor_core@ameritech.net,
       tony@atomide.com, ext-timo.teras@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OMAP: Keypad driver
Message-Id: <20060722023935.aab52bd2.akpm@osdl.org>
In-Reply-To: <1153556774.4920.266617704@webmail.messagingengine.com>
References: <1153556774.4920.266617704@webmail.messagingengine.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006 01:26:14 -0700
"Komal Shah" <komal_shah802003@yahoo.com> wrote:

> Please review the attached TI OMAP Keypad driver patch
> and consider it for -mm submission.

The code looks clean.

- Could use setup_timer().

- Check the return value from device_create_file() (and any and all such
  similar functions), handle failure appropriately.

- I don't think the tasklet stopping code is correct.  tasklet_disable()
  will prevent the callback from being called.  The del_timer_sync() will
  kill off the timer.  But the just-killed timer handler might have left
  the tasklet scheduled, and although it will not call the handler, the
  high-level tasklet code can still execute, and will then start playing
  with now-freed data.  A final tasklet_kill() should fix that up.

- Perhaps the probe function is requesting the IRQ too early?  The IRQ
  handler can perhaps be called while the hardware is still being set up. 

- Use INTF_TRIGGER_FALLING (etc), not the now-deprecated SA_TRIGGER_FALLING.

- The changelog needs work.  What's an OMAP? ;)

- Finally, by what authority does random_person@yahoo.com submit Nokia
  and TI's code??  Please review Section 11 of
  Documentation/SubmittingPatches, seek and obtain signoffs from the other
  authors and then add your own, thanks.

