Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWIKQ7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWIKQ7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWIKQ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:59:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2708 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751127AbWIKQ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:59:02 -0400
Subject: Industrial device driver uio/uio_*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 18:22:14 +0100
Message-Id: <1157995334.23085.188.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This passed me by while I was away so I only saw it to review in mm6. It
looks like it has a few problems...


uio_lseek locking ?

uio_read uses f->f_pos which it should never do
ditto uio_write ...

The uio_read/write functions can race seek or other read/write

The uio_read/write functions do signed maths checks on unsigned types
(size_t) so the count check fails.

Partially completed I/O returns -EFAULT, should return the length
transferred OK

The *ppos adjustment means you can get f_pos to interestingly unsafe
values. Generally speaking do

	loff_t pos = *ppos;

	do stuff with pos

	pos += movement;
	*ppos = pos;


If idev->virtaddr is an mmio object you can't use copy_from/to_user on
it

uio_event is based on sizeof(int) so makes 32bit compat code insanely
hard

event_poll is wrong - poll methods shouldn't error just return "ready"

idev->event_listener appears to have no locking versus the irq handler
and the like.

Anyone appears to be able to select any process as the task to signal or
out of range or negative values

I've not begun to look at uio_base.c in detail but it seems a lot of
code to do very little. That said I can see the problem it is trying to
solve, I'm just not sure it helps as is.

Alan

