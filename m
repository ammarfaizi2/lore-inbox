Return-Path: <linux-kernel-owner+w=401wt.eu-S935689AbWLKOwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935689AbWLKOwu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936399AbWLKOwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:52:49 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:31027 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935689AbWLKOwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:52:23 -0500
Message-ID: <457D70A4.1000000@mvista.com>
Date: Mon, 11 Dec 2006 08:52:20 -0600
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
References: <4533B8FB.5080108@mvista.com>	<20061210201438.tilman@imap.cc>	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>	<457CB32A.2060804@mvista.com> <20061211102016.43e76da2@localhost.localdomain>
In-Reply-To: <20061211102016.43e76da2@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Sun, 10 Dec 2006 19:23:54 -0600
> Corey Minyard <cminyard@mvista.com> wrote:
>
>   
>> Nothing has come of this yet.  But we have these two requests and a 
>> request from Russell Doty at Redhat.
>>
>> It would be nice to know if this type of thing was acceptable or not, 
>> and the problems with the patch.  The patch is at 
>> http://home.comcast.net/~minyard
>>     
>
> This looks wrong. You already have a kernel interface to serial drivers.
> It is called a line discipline. We use it for ppp, we use it for slip, we
> use it for a few other things such as attaching sync drivers to some
> devices.
>
> Discussions of the form  "my line discipline has no way to do 'xyz'" are
> the ones that need to happen IMHO.
>   
Thanks.  Line disciplines did not seem suitable for what I
needed, but perhaps can be adapted.

So here's the start of discussion:

1) The IPMI driver needs to run at panic time to modify watchdog
timers and store panic information in the event log.  So no work
queues, no delayed work, and the need for some type of poll
operation on the device.

2) The IPMI driver needs to get messages through even when
the system is very busy.  Since a watchdog runs over the driver,
it needs to be able to get messages through to avoid a system
reset as long as something is pinging the watchdog from userland.

Currently there are mutexes, lock_kernel() calls, and work queues
that cause trouble for these.

There is also a comment that you can't set low_latency and call
tty_flip_buffer_push from IRQ context.  This seems to be due to a
lack of anything in flush_to_ldisc to handle reentrancy, and perhaps
because disc->receive_buf can block, but I couldn't tell easily.

-Corey
