Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030632AbWBPTzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030632AbWBPTzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030635AbWBPTzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:55:21 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:53657
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1030632AbWBPTzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:55:19 -0500
Message-ID: <43F4D8AB.5040708@microgate.com>
Date: Thu, 16 Feb 2006 13:55:23 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: snits@snitselaar.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem: Possible deadlock for 2.4 SMP systems
References: <48822.198.115.32.5.1139956559.squirrel@cantor.snitselaar.org>
In-Reply-To: <48822.198.115.32.5.1139956559.squirrel@cantor.snitselaar.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerard Snitselaar wrote:
> What appears to happen is cpu0 calls cli() in
> shutdown() (drivers/char/serial.c), grabbing global_irq_lock.
> Meanwhile cpu1 sets IRQ_INPROGRESS, and eventually calls
> handle_IRQ_event() and spins on global_irq_lock in irq_enter().
> CPU0 calls free_irq() and eventually gets to the point where
> it spins while IRQ_INPROGRESS is set. Since cpu0 is holding
> global_irq_lock, cpu1 can't do its work and clear IRQ_INPROGRESS.

 From looking at irq.c (2.4.31) I guess that calling free_irq()
on SMP after cli() is not safe because of the race you describe.

> I read somewhere that global_irq_lock is deprecated, so is there
> something that the serial driver should be doing instead of cli()
> and restore_flags() in shutdown()?

shutdown() seems a little backwards:
it calls free_irq(), then it disables device interrupts.

One way of handling this may be to move the code
block (the if statement after 'Free the IRQ' comment)
that calls free_irq() to after the restore_flags().

At that point, the device is no longer generating
interrupts and has been removed from the IRQ_ports
list so the ISR will not touch the device instance
and free_irq() can finish safely.

-- 
Paul Fulghum
Microgate Systems, Ltd.
