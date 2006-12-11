Return-Path: <linux-kernel-owner+w=401wt.eu-S936499AbWLKPMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936499AbWLKPMF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936478AbWLKPME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:12:04 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38329 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S936456AbWLKPMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:12:01 -0500
Date: Mon, 11 Dec 2006 15:19:43 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Corey Minyard <cminyard@mvista.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Message-ID: <20061211151943.2bbc720e@localhost.localdomain>
In-Reply-To: <457D70A4.1000000@mvista.com>
References: <4533B8FB.5080108@mvista.com>
	<20061210201438.tilman@imap.cc>
	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>
	<457CB32A.2060804@mvista.com>
	<20061211102016.43e76da2@localhost.localdomain>
	<457D70A4.1000000@mvista.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 08:52:20 -0600
Corey Minyard <cminyard@mvista.com> wrote:
> So here's the start of discussion:
> 
> 1) The IPMI driver needs to run at panic time to modify watchdog
> timers and store panic information in the event log.  So no work
> queues, no delayed work, and the need for some type of poll
> operation on the device.

That would be the existing serial console interface. For things like USB
serial you are probably out of luck. At the moment we have a single
"console" attached to a specific serial console interface. The code is
almost all there for allowing other parties to create new synchronous
serial logging devices by opening open as the console driver does.

> 2) The IPMI driver needs to get messages through even when
> the system is very busy.  Since a watchdog runs over the driver,
> it needs to be able to get messages through to avoid a system
> reset as long as something is pinging the watchdog from userland.

You have a high priority character output function which jumps existing
data. Not all hardware implements this, and some of the modern hardware
in particular simply doesn't physically support such behaviour. Also if
you are the sole user of the port you *know* nobody else will be queuing
data to it anyway.

> Currently there are mutexes, lock_kernel() calls, and work queues
> that cause trouble for these.
> 
> There is also a comment that you can't set low_latency and call
> tty_flip_buffer_push from IRQ context.  This seems to be due to a
> lack of anything in flush_to_ldisc to handle reentrancy, and perhaps
> because disc->receive_buf can block, but I couldn't tell easily.

The entire tty side locking, scheduling and design is based upon the idea
that input processing is deferred. Otherwise you get long chains of
recursion from the worst cases.

Alan
