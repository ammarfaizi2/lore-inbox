Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbULGNdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbULGNdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbULGNdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:33:17 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:27155 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261810AbULGNdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:33:00 -0500
To: Hendrik Wiese <7.e.Q@syncro-community.de>
Cc: LKLM <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <41B56798.4070505@syncro-community.de>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 07 Dec 2004 05:32:58 -0800
In-Reply-To: <41B56798.4070505@syncro-community.de> (Hendrik Wiese's message
 of "Tue, 07 Dec 2004 09:19:36 +0100")
Message-ID: <52is7ecjxx.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: wait_event_interruptible
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 07 Dec 2004 13:32:58.0933 (UTC) FILETIME=[44513E50:01C4DC61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hendrik> Hello, I created a kernel thread inside of my driver by
    Hendrik> calling the function kernel_thread with a function
    Hendrik> pointer. Now this thread calls daemonize and allow_signal
    Hendrik> and then it runs a forever loop until it is terminated by
    Hendrik> the kernel (unloading the driver etc). And because it is
    Hendrik> written in the documentation I put the thread asleep by
    Hendrik> calling wait_event_interruptible with a wait queue called
    Hendrik> "dpn_wq_run" inside the forever loop. Now is it right
    Hendrik> that a wake_up_interruptible in the ISR has to wake up
    Hendrik> the thread so it continues its work? If yes... why isn't
    Hendrik> that working for me? I called wait_event_interruptible
    Hendrik> with that dpn_wq_run inside the kernel thread and do a
    Hendrik> wake_up_interruptible inside the ISR with the same
    Hendrik> dpn_wq_run. But my kernel thread won't wake up. Is there
    Hendrik> anything else I have to do to the wait queue, but calling
    Hendrik> init_wait_queue on it?

wait_event_interruptible() will sleep until your ISR wakes it up, but
for your thread to run, you also need to make sure that the condition
being tested by wait_event_interruptible() is true (otherwise it will
go back to sleep).  For example, if your thread does:

	wait_event_interruptible(&my_wait, work != 0);

then your ISR needs to do

	work = 1;
	wake_up_interruptible(&my_wait);

If you don't set work, the wake_up will have no effect.

 - R.
