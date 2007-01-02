Return-Path: <linux-kernel-owner+w=401wt.eu-S1755393AbXABRR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbXABRR0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755394AbXABRR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:17:26 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:54820 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755393AbXABRRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:17:25 -0500
Subject: Re: tty->low_latency + irq context
From: Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       p.hardwick@option.com
In-Reply-To: <45906820.10805@gmail.com>
References: <45906820.10805@gmail.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Tue, 02 Jan 2007 11:17:11 -0600
Message-Id: <1167758231.5616.22.camel@basalt>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-26 at 01:08 +0059, Jiri Slaby wrote:
> Hi!
> 
>  *      tty_flip_buffer_push    -       terminal
>  *      @tty: tty to push
>  *
>  *      Queue a push of the terminal flip buffers to the line discipline. This
>  *      function must not be called from IRQ context if tty->low_latency is set.
> 
> But some drivers (mxser, nozomi, hvsi...) sets low_latency to 1 in _open and
> calls tty_flip_buffer_push in isr or in functions, which are called from isr.
> Is the comment correct or the drivers?

The comment would be true if tty_flip_buffer_push() attempted to block
with tty->low_latency set, but it doesn't AFAICS. One possibility for
deadlock is if the tty->buf.lock spinlock is taken on behalf of a user
process...

> Moreover, hvsi says:
> tty->low_latency = 1; /* avoid throttle/tty_flip_buffer_push race */

That was a long time ago, but the race is something like this:
      * data is received, enough to completely fill the tty buffer
      * tty_flip_buffer_push() schedules flush_to_ldisc()
      * before flush_to_ldisc() runs, more data is received
      * flush_to_ldisc() truncates the incoming data (look for
        tty->receive_room)

I don't see how this is supposed to work in general. I suppose most
PC-standard char drivers are not capable of overflowing a tty buffer
before the host can empty it. I wasn't comfortable with hoping for that
condition in my driver.

Setting "low_latency" ensures that throttle will be called immediately
if the tty buffer is filled, avoiding the race.

-- 
Hollis Blanchard
IBM Linux Technology Center

