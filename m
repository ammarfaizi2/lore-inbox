Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161470AbWASWkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161470AbWASWkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161465AbWASWkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:40:16 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:31904
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1161470AbWASWkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:40:14 -0500
Message-ID: <43D01537.40705@microgate.com>
Date: Thu, 19 Jan 2006 16:39:51 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: pppd oopses current linu's git tree on disconnect
References: <20060119010601.f259bb32.diegocg@gmail.com>	<1137692039.3279.1.camel@amdx2.microgate.com> <20060119230746.ea78fcf4.diegocg@gmail.com>
In-Reply-To: <20060119230746.ea78fcf4.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
>>Does this occur frequently?
> 
> Not at all - I've tried to trigger it tons of times and didn't happen again,
> I even put a pon/poff in a loop but nothing happened; so I can't confirm if
> your patch does fix it, but I'm running the patch and nothing bad seems to
> happen.

The only way I can see for the oops you reported to occur
is for the pending or free list of tty buffers to get corrupted.
This causes the oops when trying to free all the buffers.

The buffer handling code looks correct, but there is a locking
(or lack of) issue that could mess up the lists on an SMP machine.
The serial ISR does not hold the tty->read_lock when pushing data
which is used to synchronize access to the tty buffer list.
The test patch adds this lock to the function used
(by the standard serial driver) to push the data .

The chances of this happening increase with the speed and
continued use of the serial port. Your original report showed
a lengthy PPP session. So bringing the link down and up without
significant data transfer will probably not trigger this.

Thanks,
Paul

--
Paul Fulghum
Microgate Systems, Ltd

