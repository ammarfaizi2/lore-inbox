Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVAGOJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVAGOJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVAGOI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:08:56 -0500
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:6112
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S261314AbVAGOE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:04:29 -0500
Message-ID: <41DE96DC.2090007@microgate.com>
Date: Fri, 07 Jan 2005 08:04:12 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Tim_T_Murphy@Dell.com, rmk+lkml@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP
 kernel
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D32@ausx2kmps304.aus.amer.dell.com>	 <1105052674.24187.288.camel@localhost.localdomain>	 <41DDDB47.8050008@microgate.com> <1105062326.17176.313.camel@localhost.localdomain>
In-Reply-To: <1105062326.17176.313.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2005-01-07 at 00:43, Paul Fulghum wrote:
> 
>>IIRC that guarantees a deadlock on SMP due to the
>>generic serial layer trying to grab a spinlock
>>that is already held. (Which prompted the original
>>bug report by Tim several months ago)
> 
> 
> I fixed the tty locking issues with that. If there are any left they
> should be solely in the serial generic code and I've no idea there

Yes, that is where the locking problems were.
When I last looked at it the problem call path was:

serial8250_interrupt();
    spin_lock(port->lock);
    serial8250_handle_port();
       receive_chars();
          flip.work.func(); /* if FLIP buffer full or low_latency set */
              ldisc->receive_buf(); /* N_TTY */
                  tty->driver->flush_chars();
                     uart_start();
                        spin_lock(port->lock); *BANG*

--
Paul Fulghum
Microgate Systems, Ltd

