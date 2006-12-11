Return-Path: <linux-kernel-owner+w=401wt.eu-S936922AbWLKQ3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936922AbWLKQ3e (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937072AbWLKQ3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:29:34 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:50560 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936922AbWLKQ3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:29:33 -0500
Message-ID: <457D876B.9000508@mvista.com>
Date: Mon, 11 Dec 2006 10:29:31 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
References: <4533B8FB.5080108@mvista.com>	<20061210201438.tilman@imap.cc>	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>	<457CB32A.2060804@mvista.com>	<20061211102016.43e76da2@localhost.localdomain>	<457D70A4.1000000@mvista.com> <20061211151943.2bbc720e@localhost.localdomain>
In-Reply-To: <20061211151943.2bbc720e@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Mon, 11 Dec 2006 08:52:20 -0600
> Corey Minyard <cminyard@mvista.com> wrote:
>   
>> So here's the start of discussion:
>>
>> 1) The IPMI driver needs to run at panic time to modify watchdog
>> timers and store panic information in the event log.  So no work
>> queues, no delayed work, and the need for some type of poll
>> operation on the device.
>>     
>
> That would be the existing serial console interface. For things like USB
> serial you are probably out of luck. At the moment we have a single
> "console" attached to a specific serial console interface. The code is
> almost all there for allowing other parties to create new synchronous
> serial logging devices by opening open as the console driver does.
>   
I don't think the console interface really helps.  Input processing is also
needed, and the output blocks until the character is sent.  A poll routine
is a better way to accomplish this, IMHO.
>   
>> 2) The IPMI driver needs to get messages through even when
>> the system is very busy.  Since a watchdog runs over the driver,
>> it needs to be able to get messages through to avoid a system
>> reset as long as something is pinging the watchdog from userland.
>>     
>
> You have a high priority character output function which jumps existing
> data. Not all hardware implements this, and some of the modern hardware
> in particular simply doesn't physically support such behaviour. Also if
> you are the sole user of the port you *know* nobody else will be queuing
> data to it anyway.
>   
That's not really the issue.  The input processing is again the
issue.
>   
>> Currently there are mutexes, lock_kernel() calls, and work queues
>> that cause trouble for these.
>>
>> There is also a comment that you can't set low_latency and call
>> tty_flip_buffer_push from IRQ context.  This seems to be due to a
>> lack of anything in flush_to_ldisc to handle reentrancy, and perhaps
>> because disc->receive_buf can block, but I couldn't tell easily.
>>     
>
> The entire tty side locking, scheduling and design is based upon the idea
> that input processing is deferred. Otherwise you get long chains of
> recursion from the worst cases.
>   
I was actually wrong, flush_to_ldisc does handle reentrancy.
It can only have one caller to disc->receive_buf() at a time.  So
long chains of recursion don't seem to be possible, even if called
from IRQ context.

And studying the way ppp does writing, it can bypass the tty_write()
call and directly call the drivers.  So that bypasses the transmit
locking problems I saw.

This is going to require some more thought.  But I believe it can be
done with adding a poll routine to the tty_operations structure and
perhaps some minor changes around tty_flip_buffer_push.

Thanks for your help.

-Corey

