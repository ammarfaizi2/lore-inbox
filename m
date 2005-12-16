Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVLPXm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVLPXm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbVLPXm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:42:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49420 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964791AbVLPXm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:42:26 -0500
Date: Fri, 16 Dec 2005 23:42:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix - ioc3 serial support
Message-ID: <20051216234219.GL1222@flint.arm.linux.org.uk>
Mail-Followup-To: Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <200512162233.jBGMXRUQ139857@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512162233.jBGMXRUQ139857@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 04:33:26PM -0600, Pat Gefre wrote:
> The following patch adds driver support for a 2 port PCI IOC3-based
> serial card on Altix boxes:
> 
> ftp://oss.sgi.com/projects/sn2/sn2-update/044-ioc3-support

Here's some comments on ioc3_serial.c.  Could you look at them and
either resolve them or discuss further.  Thanks.

+#include <linux/serialP.h>

I don't think you need this include.

+	the_port->timeout = ((the_port->fifosize * HZ * bits) / (baud / 10));
+	the_port->timeout += HZ / 50;	/* Add .02 seconds of slop */

Please use uart_update_timeout() instead.

+	info = the_port->info;
+	if (info->tty) {
+		set_bit(TTY_IO_ERROR, &info->tty->flags);
+		clear_bit(TTY_IO_ERROR, &info->tty->flags);
+		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
+			info->tty->alt_speed = 57600;
+		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
+			info->tty->alt_speed = 115200;
+		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
+			info->tty->alt_speed = 230400;
+		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
+			info->tty->alt_speed = 460800;
+	}

None of this is required.  info->tty->alt_speed is not used by the
serial layer - it knows how to deal with this itself.  Secondly,
setting and clearing TTY_IO_ERROR is pointless.  Note that the serial
layer takes care of TTY_IO_ERROR handling for you.

+	/* set the speed of the serial port */
+	ioc3_change_speed(the_port, info->tty->termios, (struct termios *)0);

serial_core will call this for you at the appropriate time.  Note that
you decided above to check whether info->tty was NULL.  If it was this
will oops.  Better just get rid of it anyway - it's not necessary.

+					/* Notify upper layer of carrier drop */
+					if ((port->ip_notify & N_DDCD)
+					    && port->ip_port) {
+						the_port->icount.dcd = 0;
+						wake_up_interruptible
+						    (&the_port->info->
+						     delta_msr_wait);
+					}

Use uart_handle_dcd_change().  Setting port->icount.dcd to zero in
this case is wrong.  It also makes no attempt at informing the upper
layers that a hangup occurred.  Note that uart_handle_dcd_change()
exists so that you don't have to think about these semantics.  You
will need to keep the wake_up_interruptible though.

+			if ((port->ip_notify & N_DDCD)
+			    && (shadow & SHADOW_DCD)
+			    && (port->ip_port)) {
+				the_port = port->ip_port;
+				the_port->icount.dcd = 1;
+				wake_up_interruptible
+				    (&the_port->info->delta_msr_wait);

Ditto.  icount.dcd is not the state of DCD.  It is a counter for the
number of times DCD changes state.

+			if ((port->ip_notify & N_DCTS) && (port->ip_port)) {
+				the_port = port->ip_port;
+				the_port->icount.cts =
+				    (shadow & SHADOW_CTS) ? 1 : 0;
+				wake_up_interruptible
+				    (&the_port->info->delta_msr_wait);
+			}

Ditto, except uart_handle_cts_change().

+		the_port->lock = SPIN_LOCK_UNLOCKED;
+		spin_lock_init(&the_port->lock);

Not necessary - uart_add_one_port() does this for you for non-console
ports, and for console ports, it is assumed that the console code has
already initialised the spinlock.

+	if (request_count > TTY_FLIPBUF_SIZE - tty->flip.count)
+		request_count = TTY_FLIPBUF_SIZE - tty->flip.count;
+
+	if (request_count > 0) {
+		read_count = do_read(the_port, ch, request_count);
+		if (read_count > 0) {
+			flip = 1;
+			memcpy(tty->flip.char_buf_ptr, ch, read_count);
+			memset(tty->flip.flag_buf_ptr, TTY_NORMAL, read_count);
+			tty->flip.char_buf_ptr += read_count;
+			tty->flip.flag_buf_ptr += read_count;
+			tty->flip.count += read_count;
+			the_port->icount.rx += read_count;
+		}
+	}

Please talk to Alan Cox about the best way to handle this.  flip
buffers are going away.

+/**
+ * ic3_tx_empty - Is the transmitter empty?  We pretend we're always empty
+ * @port: Port to operate on (we ignore since we always return 1)
+ *
+ */
+static unsigned int ic3_tx_empty(struct uart_port *the_port)
+{
+	return TIOCSER_TEMT;
+}

Not really a good idea if you care about the last bytes of data
in various buffers.  Eg, cat file > /dev/yourport could well chop
off the last few characters for transmission.

Finally, you register the uart driver in ioc3uart_init(), and
unregister it in ioc3uart_remove() rather than ioc3uart_exit().
What if you have multiple boards?  You remove one of them and
the uart driver gets unregistered?  It doesn't look sane.

Haven't looked at the rest of the code tho.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
