Return-Path: <linux-kernel-owner+w=401wt.eu-S937599AbWLKUQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937599AbWLKUQk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937623AbWLKUQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:16:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:47972 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937599AbWLKUQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:16:38 -0500
X-Authenticated: #20450766
Date: Mon, 11 Dec 2006 21:16:35 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Corey Minyard <cminyard@mvista.com>, Tilman Schmidt <tilman@imap.cc>,
       linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
In-Reply-To: <20061211191543.32ce2da8@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0612112100220.4039@poirot.grange>
References: <4533B8FB.5080108@mvista.com> <20061210201438.tilman@imap.cc>
 <Pine.LNX.4.60.0612102117590.9993@poirot.grange> <457CB32A.2060804@mvista.com>
 <20061211102016.43e76da2@localhost.localdomain> <Pine.LNX.4.60.0612111954120.4039@poirot.grange>
 <20061211191543.32ce2da8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006, Alan wrote:

> > there as "protocols" for user-tty interfaces, i.e., you need a user, that 
> > opens a tty, sets a line discipline to it, and does io (read/write) over 
> > it, and NOT to be completely initialised and driven from the kernel.
> 
> Take a look at the SLIP driver. User space sets up the port but all the
> actual I/O is to/from the kernel not via user space.

Ok, to be specific, linkstation-like mpc8241-based NAS systems have an AVR 
perform power management functions, and it is connected over a UART. Some 
of the functions you have to perform:

1) disable the watchdog at startup otherwise it powers the system down in 
a few minutes. This is done by sending about 20 bytes to it - more than 
fits in UART's fifo. So, you need interrupts / polling. It is arguable 
whether this should be done / initialised from the user- or from the 
kernel-space. Earlier it was done from the user space completely, I put it 
into the kernel completely to get a runnable system even without 
user-space hacks.

2) run-time operation, like fan control, sensors, maybe some other 
functions. These all should and are currently done completely from a 
user-space process over a normal tty.

3) reboot / halt. Consists of 2 parts. The actual command, that can be 
sent earlier from the userspace too, and the final "commit", that actually 
reboots / powers down the system. That is the last command in platform's 
reboot / poweroff functions. Currently I do both parts from the kernel so 
with the current kernel you get a completely functional system with "any" 
generic distribution.

So, if we decide to put 1) in the user-space too, it becomes almost a 
normal line discipline with the only need to initiate io from the kernel 
for 3), which is just sending about 4 bytes over the port anyway, and can 
be (and is) just done in a tight infinite loop. But I'd prefer to keep 1) 
and 3) in the kernel and perform it without waiting for any user-space 
daemons...

What do you think?

Thanks
Guennadi
---
Guennadi Liakhovetski
