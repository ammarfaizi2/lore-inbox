Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbTIVLYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 07:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTIVLYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 07:24:34 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:42177 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263119AbTIVLYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 07:24:33 -0400
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80,
	in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 12:22:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-22 at 01:27, Eric W. Biederman wrote:
> So can we gradually kill inb_p, outb_p in 2.6?  An the other
> miscellaneous users of I/O port 0x80 for I/O delays?
> 
> Or possibly rewriting outb_p to look something like:
> outb(); udelay(200);  or whatever the appropriate delay is?

The delay should be 8 ISA clocks. While you can easily fix inb_p and
outb_p you also need to fix up the udelay() code since if you stick 
a BUG() check in udelay you'll find it gets used before the clock is
initialized even now, let alone with inb_p relying on it. But that
itself is quite fixable too.

(one part of the problem of course is you need inb_p/outb_p to drive
the timer chip on some x86 boards in order to calibrate the udelay
timer)


> When debugging this I modified arch/i386/io.h to read:
> #define  __SLOW_DOWN_IO__ ""
> Which totally removed the delay and the system ran fine.

Not all systems do - we had breakages from both the keyboard controller
and the timer chips even on some modern boards when this got messed up.


