Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbULGN4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbULGN4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbULGN4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:56:48 -0500
Received: from knserv.hostunreachable.de ([212.72.163.70]:46789 "EHLO
	mail.hostunreachable.de") by vger.kernel.org with ESMTP
	id S261814AbULGN4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:56:46 -0500
Message-ID: <41B5B699.2020206@syncro-community.de>
Date: Tue, 07 Dec 2004 14:56:41 +0100
From: Hendrik Wiese <7.e.Q@syncro-community.de>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
Cc: LKLM <linux-kernel@vger.kernel.org>
Subject: Re: wait_event_interruptible
References: <41B56798.4070505@syncro-community.de> <52is7ecjxx.fsf@topspin.com>
In-Reply-To: <52is7ecjxx.fsf@topspin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:

>    Hendrik> Hello, I created a kernel thread inside of my driver by
>    Hendrik> calling the function kernel_thread with a function
>    Hendrik> pointer. Now this thread calls daemonize and allow_signal
>    Hendrik> and then it runs a forever loop until it is terminated by
>    Hendrik> the kernel (unloading the driver etc). And because it is
>    Hendrik> written in the documentation I put the thread asleep by
>    Hendrik> calling wait_event_interruptible with a wait queue called
>    Hendrik> "dpn_wq_run" inside the forever loop. Now is it right
>    Hendrik> that a wake_up_interruptible in the ISR has to wake up
>    Hendrik> the thread so it continues its work? If yes... why isn't
>    Hendrik> that working for me? I called wait_event_interruptible
>    Hendrik> with that dpn_wq_run inside the kernel thread and do a
>    Hendrik> wake_up_interruptible inside the ISR with the same
>    Hendrik> dpn_wq_run. But my kernel thread won't wake up. Is there
>    Hendrik> anything else I have to do to the wait queue, but calling
>    Hendrik> init_wait_queue on it?
>
>wait_event_interruptible() will sleep until your ISR wakes it up, but
>for your thread to run, you also need to make sure that the condition
>being tested by wait_event_interruptible() is true (otherwise it will
>go back to sleep).  For example, if your thread does:
>
>	wait_event_interruptible(&my_wait, work != 0);
>
>then your ISR needs to do
>
>	work = 1;
>	wake_up_interruptible(&my_wait);
>
>If you don't set work, the wake_up will have no effect.
>
> - R.
>
>  
>
Ah, yes. That works. Thanks a lot.

Is it the right way checking for available data inside the kernel 
thread? I experimentally put the
code that checks and reads data from the hardware from the kernel thread 
into a function
directly called by the ISR and that works too. Now what is the better 
way of receiving data?
Within the kernel thread woken up by the ISR or within the ISR itself 
(or a sub function
called by the ISR)?

Thanks again
