Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTIVA24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTIVA24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:28:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12856 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262740AbTIVA1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:27:50 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Sep 2003 18:27:44 -0600
Message-ID: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



inb_p and outb_p issue outb's to port 0x80 to achieve a short delay.
In a reasonable system there is nothing listening to port 0x80 
or there is a post card, but there are no other devices there.

On a modern system with no post card the outb travels it's
way down to the LPC bus, and the outb is terminated by an abort
because nothing is listening.

So far so good.  Except for the fact that recent high volume
ROM chips get confused when they see an abort on the LPC
bus.  Making it problematic to update the ROM from under Linux.

I don't know if there are other buggy LPC devices or not.  But
I do know that it is generally bad form do I/O to a random port.

So can we gradually kill inb_p, outb_p in 2.6?  An the other
miscellaneous users of I/O port 0x80 for I/O delays?

Or possibly rewriting outb_p to look something like:
outb(); udelay(200);  or whatever the appropriate delay is?

When debugging this I modified arch/i386/io.h to read:
#define  __SLOW_DOWN_IO__ ""
Which totally removed the delay and the system ran fine.

Eric
