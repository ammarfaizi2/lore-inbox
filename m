Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269867AbUJHNyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269867AbUJHNyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269957AbUJHNyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:54:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39347 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269867AbUJHNyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:54:09 -0400
Subject: Re: [RFC][PATCH] TTY flip buffer SMP changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097242506.2008.30.camel@deimos.microgate.com>
References: <1097179099.1519.17.camel@deimos.microgate.com>
	 <1097177830.31768.129.camel@localhost.localdomain>
	 <20041008062650.GC2745@thunk.org>
	 <1097242506.2008.30.camel@deimos.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097239894.2290.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 08 Oct 2004 13:51:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-08 at 14:35, Paul Fulghum wrote:
> It does seem to carry serious overhead (in relation
> to ring buffers) for devices with small FIFOs.

Thats one reason I wanted sk_buff like rather than sk_buff. I want
to be able to recycle buffers back to drivers when the driver thinks
its the right thing to do.

Then you get something like

next_buffer()
{
	new_buf = tty->nextbuf;
	if(!new_buf)
		new_buf = grow_tty_buf(tty);
	queue_to_ldisc(tty->buf);
	tty->buf = newbuf;
}

and "free" most of the time can simply queue the buffer back to the tty.
That degenerates into flip buffers in good conditions..

> to the line discipline. This amounts to ~3600 sk_buff
> allocations per second at 115200bps.

Ethernet packets at 1500bytes arriving at 100Mbit is rather higher than
that, and the processing demands are higher too


