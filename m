Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUI1VLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUI1VLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUI1VLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:11:03 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:59702 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267936AbUI1VKo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:10:44 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409281734.38781.roland.cassebohm@visionsystems.de>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1096405831.2513.37.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 16:10:31 -0500
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 10:34, Roland Caßebohm wrote:
> As I can see, the bit TTY_DONT_FLIP in tty->flags is set, so 
> the receive-buffer can't be flipped. In receive_chars() all 
> ports are checked for received bytes, but if the buffer is 
> full and can't be flipped, no byte are read from the UART and 
> the interrupt will never go inactive.

Definately a bug.
It is the same in 2.6 kernels (serial/8250.c).

One way or another, the interrupt must be cleared.
(serviced or deactivated)

> I have tried just to read all byte left in the FIFO of the 
> UART in that case and throw them away.

In my opinion, this is the correct way to handle the problem.
This is what I do in the SyncLink drivers.

> This is working but would probably not the best way, because 
> there could be enough place in the other flip buffer. Maybe 
> it is possible to disable the receive interrupt of the UART 
> till the receive routine read_chan(), which sets 
> TTY_DONT_FLIP, releases the buffer.

The flip buffer and N_TTY line disciplines are
generic facilities for all tty drivers. They can't
directly perform device specific tasks like
enabling/disabling UART interrupts.

Adding notification to the driver to do these
tasks does not seem like a win either.
On a receive IRQ, the UART Rx FIFO
is already running out of space. If you
disable the rx IRQ, you will likely still lose
data shortly after.

That said, the flip buffer code could be improved
to provide better buffering to prevent lost data.
There may also be synchronization problems:
The driver usually calls tty_flip_buffer_push at
hard IRQ context to queue a task (flush_to_ldisc)
to feed the data to the line discipline. In the case
of a full flip buffer, the driver calls flush_to_ldisc
directly (via tty->flip.tqueue.routine) at hard IRQ context.
I don't see any locking in the flip buffer code
to synchronize this.

-- 
Paul Fulghum
paulkf@microgate.com

