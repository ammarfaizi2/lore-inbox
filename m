Return-Path: <linux-kernel-owner+w=401wt.eu-S1755384AbXABS6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbXABS6E (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbXABS6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:58:04 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:57180
	"EHLO gw.microgate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384AbXABS6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:58:03 -0500
Subject: Re: tty->low_latency + irq context
From: Paul Fulghum <paulkf@microgate.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       p.hardwick@option.com
In-Reply-To: <1167758231.5616.22.camel@basalt>
References: <45906820.10805@gmail.com>  <1167758231.5616.22.camel@basalt>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 12:12:11 -0600
Message-Id: <1167761531.3837.13.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 11:17 -0600, Hollis Blanchard wrote:
> On Tue, 2006-12-26 at 01:08 +0059, Jiri Slaby wrote:
> >  *      Queue a push of the terminal flip buffers to the line discipline. This
> >  *      function must not be called from IRQ context if tty->low_latency is set.
> > 
> > But some drivers (mxser, nozomi, hvsi...) sets low_latency to 1 in _open and
> > calls tty_flip_buffer_push in isr or in functions, which are called from isr.
> > Is the comment correct or the drivers?
> 
> The comment would be true if tty_flip_buffer_push() attempted to block
> with tty->low_latency set, but it doesn't AFAICS. One possibility for
> deadlock is if the tty->buf.lock spinlock is taken on behalf of a user
> process...

There is no deadlock on tty->buf.lock,
which is always acquired with spin_lock_irqsave()
and is only used by the tty buffering code.

The only deadlock I know of with the current tty buffering code
is calling tty_flip_buffer_push() with low_latency
set and from the ISR of a driver that has a problem
with the line discipline calling back into the driver.

The standard serial core has (or at least had the last time
I looked) this problem with the N_TTY ldisc:

driver gets internal spinlock in ISR
driver calls tty_flip_buffer_push with low_latency = 1
flush_to_ldisc() immediately passes data to line discipline
line discipline calls back into driver
driver tries again to get internal spinlock

With low_latency == 1, flush_to_ldisc() is deferred
until the ISR is complete and the internal spinlock is released.

I forget the exact driver callback that caused this.

-- 
Paul Fulghum
Microgate Systems, Ltd

