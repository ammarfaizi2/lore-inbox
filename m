Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTACQMQ>; Fri, 3 Jan 2003 11:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbTACQMI>; Fri, 3 Jan 2003 11:12:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21259 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267573AbTACQKs>; Fri, 3 Jan 2003 11:10:48 -0500
Date: Fri, 3 Jan 2003 16:19:16 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, davem@redhat.com,
       miles@gnu.org, dwmw2@redhat.com
Subject: [SERIAL] change_speed -> settermios change
Message-ID: <20030103161916.A19992@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	davem@redhat.com, miles@gnu.org, dwmw2@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the final installment of the "sanitise change_speed" changes.
There are now three drivers which want to get the raw baud rate rather
than the divisor - nb85e_uart.c, sunsab.c, and sunzilog.c.

We have provided methods in previous csets to allow low level drivers
to convert a termios to a divisor or baud rate.  Now, we provide the
drivers with the termios structure.

This has several advantages:

- the low level driver can obtain the divisor or baud rate directly,
  without having to play math games.

- the low level driver can force various termios flags for settings
  which it doesn't support.

I have one concerns surrounding the three drivers mentioned above.
Currently, they blindly use uart_get_baud_rate() without limiting the
maximum baud rate.  Since the baud rate will be limited (by the
hardware), we must limit the resulting baud rate must be reflected
back into the termios c_cflag member.

I believe the low level drivers should be responsible for handling
this themselves - this is especially true when you start considering
the "high speed" modes of x86 motherboard serial ports (which dwmw2
would like to support.)

Lastly, uart_update_timeout() is imperfect.  It takes a divisor, which
you may not have (since you're only working with baud rates.)  There
is also the related mess of using the "magic" custom divisors, which
uart_update_timeout() would not be friendly towards.  However, it is
friendly towards nonstandard baud rates which satisfy clock / divisor,
eg, 3600 baud, 7200 baud (both of which I have used in the past.)

I suspect that uart_update_timeout() will eventually take the cflag
setting and the period in picoseconds to send one byte.  This approach,
along with support for the "magic" custom divisors, should mean that
we adequately cover this area without too much pain.

A patch against 2.5.54-bkcur is available from:

	http://www.arm.linux.org.uk/misc/serial.diff

It should also be compatible with plain unpacked 2.5.54.  If BK people
want to pull the changes, drop me a mail prior to pulling, thanks.

 Documentation/serial/driver |   41 ++++++++++++++++++++------
 drivers/serial/21285.c      |   55 ++++++++++++++++++++++++++---------
 drivers/serial/8250.c       |   60 ++++++++++++++++++++++----------------
 drivers/serial/amba.c       |   43 +++++++++++++++++----------
 drivers/serial/anakin.c     |   33 +++++++++++++++++----
 drivers/serial/clps711x.c   |   45 ++++++++++++++++++----------
 drivers/serial/core.c       |   33 +++++++++------------
 drivers/serial/mux.c        |   13 +++-----
 drivers/serial/nb85e_uart.c |   14 +++-----
 drivers/serial/sa1100.c     |   69 ++++++++++++++++++++++++++++----------------
 drivers/serial/sunsab.c     |   15 +++------
 drivers/serial/sunsu.c      |   36 +++++++++++++++++-----
 drivers/serial/sunzilog.c   |   15 +++++----
 drivers/serial/uart00.c     |   46 +++++++++++++++++++----------
 include/linux/serial_core.h |   25 +++++++++++++--
 15 files changed, 359 insertions, 184 deletions

through these ChangeSets:

<rmk@flint.arm.linux.org.uk> (03/01/03 1.944)
	[SERIAL] Convert change_speed() to settermios()
	
	Several serial drivers want to obtain the numeric baud rate when
	configuring their serial ports.  Currently, two methods are used
	to "work around" this inadequacy in the change_speed API:
	
		baud = tty_get_baud_rate(port->info->tty);
	
		baud = BAUD_BASE / (16 * quot);
	
	Passing the termios structure down means that we can use 
	uart_get_baud_rate() instead.  We can also ensure that the various
	termios flags for options we don't support are correctly set.
	
	Lastly, this also provides 8250.c with a clean method for supporting
	divisors that are greater than the baud_base.

<rmk@flint.arm.linux.org.uk> (03/01/03 1.943)
	[SERIAL] Remove unused info->event

<rmk@flint.arm.linux.org.uk> (03/01/03 1.942)
	[SERIAL] Add prototypes and rename UPF_FLAGS
	
	UPF_FLAGS is confusing - rename it to UPF_CHANGE_MASK.
	Add uart_update_timeout, uart_get_baud_rate and uart_get_divisor
	prototypes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

