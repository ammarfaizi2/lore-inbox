Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbULBPs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbULBPs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbULBPrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:47:07 -0500
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:8087 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S261653AbULBPqn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:46:43 -0500
Date: Thu, 2 Dec 2004 07:46:20 -0800
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200412021546.iB2FkK5a005502@cichlid.com>
To: linux-kernel@vger.kernel.org
Cc: jackit-devel@lists.sourceforge.net
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar said:

>Florian Schmidt <mista.tapas@gmx.net> wrote:
>>
>> Hmm, i wonder if there's a way to detect non RT behaviour in jackd
>> clients. I mean AFAIK the only thing allowed for the process callback
>> of on is the FIFO it waits on to be woken, right? Every other sleeping
>> is to be considered a bug. 

>there's such a feature in -RT kernels. If a user process calls:
>	gettimeofday(1,1);
>then the kernel turns 'atomic mode' on. To turn it off, call:
>	gettimeofday(1,0);

>while in atomic-mode, any non-atomic activity (scheduling) will produce
>a kernel message and a SIGUSR2 sent to the offending process (once,
>atomic mode has to be re-enabled again for the next message). Preemption
>by a higher-prio task does not trigger a message/signal.

>If you run the client under gdb you should be able to catch the SIGUSR2
>signal and then you can see the offending code's backtrace via 'bt'.

Might be handy to have the option to send a SIGABRT, then you don't need
to guess which app to run under gdb and the offending code is there in
the core file.

Also, I'm cc-ing jack-devel. This could fit into libjack so no client
mods would be needed I think. After the thread_init_callback is run libjack
could run 'gettimeofday(1,1);' for each client thread. Then if any client
breaks the rules you get a core showing where. 

On further thought, I suppose libjack could install a SIGUSR2 handler and
have that call abort for all the rt client threads. Still no client mods
needed, only an RT-aware libjack.

A big thank you to Ingo and everyone else involved on behalf of all the
linux audio users!

