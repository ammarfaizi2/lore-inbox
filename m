Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVBDLIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVBDLIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVBDLIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:08:31 -0500
Received: from stud4.tuwien.ac.at ([193.170.75.14]:50397 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP id S263166AbVBDLIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:08:15 -0500
Date: Fri, 4 Feb 2005 12:07:25 +0100
From: Martin =?iso-8859-15?Q?K=F6gler?= <e9925248@student.tuwien.ac.at>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Deadlock in serial driver 2.6.x
Message-ID: <20050204110725.GA16534@stud4.tuwien.ac.at>
References: <20050126132047.GA2713@stud4.tuwien.ac.at> <20050126231329.440fbcd8.akpm@osdl.org> <1106844084.14782.45.camel@localhost.localdomain> <20050130164840.D25000@flint.arm.linux.org.uk> <1107157019.14847.64.camel@localhost.localdomain> <20050131004857.07f5e2c4.akpm@osdl.org> <1107332396.14847.112.camel@localhost.localdomain> <20050203102112.06c06fe7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050203102112.06c06fe7.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 10:21:12AM -0800, Andrew Morton wrote:
> The "echo method" method sounds good.  Do we think that's feasible for
> 2.6.11, or would it be safer to disable low-latency mode for that driver?

As a temporary workaround, dropping the lock should also work:

--- linux-2.6.10/drivers/serial/8250.old.c      2005-02-03 14:07:48.557609200 +0100
+++ linux-2.6.10/drivers/serial/8250.c  2005-02-03 14:09:00.687887525 +0100
@@ -987,7 +987,11 @@
		   unsafe. It should be fixed ASAP */
	        if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
		        if(tty->low_latency)
-                               tty_flip_buffer_push(tty);
+                         {
+                           spin_unlock(&up->port.lock);
+                           tty_flip_buffer_push(tty);
+                           spin_lock(&up->port.lock);
+                         }
    		        /* If this failed then we will throw away the
		           bytes but must do so to clear interrupts */
								      }
@@ -1058,7 +1062,9 @@
	ignore_char:
    	        lsr = serial_inp(up, UART_LSR);
        } while ((lsr & UART_LSR_DR) && (max_count-- > 0));
+       spin_unlock(&up->port.lock);
        tty_flip_buffer_push(tty);
+       spin_lock(&up->port.lock);
        *status = lsr;
 }

An other serial interrupt can not disturbed, because it will be blocked by the interrupt lock.
All other direct access to the UART seems to be protected by the port lock, so they may be only
execectued, while tty_flip_buffer_push is running and is not accessing the port.

I have this patch running on a 2.6.10 Kernel (Fedora Core 2 Version) and low latency mode
works without any problems (with and without SMP).

If that patch works under all conditons, I can't say. It may cause degrade the performance,
but for my work, I can't see any effect.

mfg Martin Kögler
e9925248@stud4.tuwien.ac.at
PS: Please CC me on replies.
