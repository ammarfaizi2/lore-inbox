Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWGMORd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWGMORd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWGMORd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:17:33 -0400
Received: from javad.com ([216.122.176.236]:16 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751502AbWGMORd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:17:33 -0400
From: Sergei Organov <osv@javad.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org> <87veq9cosq.fsf@javad.com>
	<1152302831.20883.63.camel@localhost.localdomain>
	<87d5cdg308.fsf@javad.com>
	<1152529855.27368.114.camel@localhost.localdomain>
	<873bd9fobb.fsf@javad.com>
	<1152552683.27368.185.camel@localhost.localdomain>
Date: Thu, 13 Jul 2006 18:17:10 +0400
In-Reply-To: <1152552683.27368.185.camel@localhost.localdomain> (Alan Cox's
	message of "Mon, 10 Jul 2006 18:31:23 +0100")
Message-ID: <8764i1h9nd.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> Ar Llu, 2006-07-10 am 19:54 +0400, ysgrifennodd Sergei Organov:
>> Wow! The code you've quoted seems to be correct! But where did you get
>> it from? The version of flush_to_ldisc() from drivers/char/tty_io.c from
>> 2.17.4 got last Friday from kernel.org does this:
>
>> From HEAD so it should make 2.6.18. Paul fixed this one.

I've tested my driver with 2.6.18-rc1 and can confirm Paul changes
finally fixed this particular problem. However, this fix unveiled
different problem with the current tty buffering code.

The memory amount that could be used by tty buffers is
uncontrolled. I've arranged a test[1] that demonstrates that tty buffers
do indeed grow to the entire size of available memory at some conditions
resulting in kernel starting to kill random processes until the testing
process is killed.

This problem may occur with any tty driver that doesn't stop to insert
data into the tty buffers in throttled state. And yes, there are such
drivers in the tree. Before Paul's changes, the tty just dropped bytes
that aren't accepted by ldisc, so this problem had no chances to arise.

I think that either the amount of memory used by tty buffers should be
limited by a tty variable with a suitable default, or tty buffering
should be changed not to accept data from drivers in throttled state.
Alternatively, tty may rely on drivers not to insert data in the
throttled state, but then it's better to be written in big red letters
in the description of tty buffer interface routines. Though in the 2
latter cases drivers that insert too much data without pushing to ldisc
may cause similar problem. Anyway, you definitely know better what to do
about it.

[1] I have a USB device streaming data on its bulk endpoint. The device
is handled by improved airprime driver (usb-to-tty converter) that could
be found in Greg's patches. The driver attached the device to
/dev/ttyUSB0. The testing application just opened /dev/ttyUSB0 and went
to sleep, i.e., it just didn't read from the resulting fd. At these
conditions the slab memory reported in /proc/meminfo grew linearly in
time until in a few minutes kernel started to kill processes. The
testing process wasn't the first one the kernel killed. It killed X
server and some other applications until eventually it killed the
testing process at which point things returned to normal operation.

-- 
Sergei.
