Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTIHTk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTIHTk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:40:56 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:25249 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263564AbTIHTkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:40:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16220.56128.102839.316486@gargle.gargle.HOWL>
Date: Mon, 8 Sep 2003 21:40:48 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: send_sig_info() in __switch_to() Ok or not?
In-Reply-To: <m3d6euk9ce.fsf@averell.firstfloor.org>
References: <o9Yo.6Zf.7@gated-at.bofh.it>
	<m3d6euk9ce.fsf@averell.firstfloor.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Mikael Pettersson <mikpe@csd.uu.se> writes:
 > 
 > > I have a kernel extension (the x86 perfctr driver) that needs,
 > > in a specific but unlikely case(*), to send a SIGILL to current
 > > (next) in __switch_to(). Is this permitted or not?
 > >
 > > I suspect it might not be because send_sig_info() eventually does
 > > wake_up_process_kick(), and there's this warning in __switch_to()
 > > not to call printk() since it calls wake_up()...
 > 
 > > If I can't call send_sig_info() in __switch_to(), is there
 > > another way to post a SIGILL to current from __switch_to()?
 > 
 > You can just do it manually. Fill in the signal in the signal
 > mask of the process. The next time the process checks for signals it will 
 > kill itself. As it is already running or going to run it doesn't need
 > a wake up.

Sorry about the delay in responding to this.
Anyway, I started doing it manually, but gave up since it would
mean copying/duplicating quite a bit of code from signal.c.
Instead I now do:

	BUG_ON(current->state != TASK_RUNNING);
	send_sig(SIG_ILL, current, 1);

I've checked sched.c and done runtime testing, and this does seem to
be true and work Ok. (Fingers crossed, knock on wood, etc.)

/Mikael
