Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbUAMRPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUAMRPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:15:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8211 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264434AbUAMRPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:15:48 -0500
Date: Tue, 13 Jan 2004 17:15:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Outstanding fixups (was: Re: [PROBLEM] ircomm ioctls)
Message-ID: <20040113171544.B7256@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040113114948.B2975@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jan 13, 2004 at 11:49:48AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 11:49:48AM +0000, Russell King wrote:
> And as a follow up, there are about 30 other drivers which still
> reference TIOCM{GET,SET,BIC,BIS} most of which won't work.  Some of
> them include drivers that were dumped into drivers/serial (despite
> not using the serial_core stuff.)

Ok, I've just finished giving all those drivers the once over for this
specific problem (and no others.)  A general comment is that we have
a hell of a lot of unmaintained crud here.  Many of these serial drivers
are still using the global IRQ macros, and therefore are unbuildable in
2.6 kernels.

Specific drivers:

- 68360serial, amiserial, serial167
  These need attention - they appear to have had the global IRQ stuff
  "cleaned up".  IOW, the global IRQ macros have become local IRQ macros
  with no regard what so ever to any SMP locking issues.

- moxa
  This has a complete lack of locking what so ever.

- pcxx, epca
  These seem to do something weird with the semantics of TIOCMSET/BIC/BIS.
  and as such have nonstandard behaviour.  The driver author needs to
  look at this and resolve the issue.  As the driver stood previously,
  TIOCMBIC/BIS took explicit control of the modem control lines.  TIOCMSET
  also did this, but only when the modem control line was _set_.  If it
  were cleared using TIOCMSET, control over this line was returned to the
  chip.

  This is not how 16x50 ports work when they are in "auto RTS" mode.  The
  RTS signal is the logical and of the RTS setting and the hardware flow
  control, when the hardware flow control is enabled.

- pc300_tty
  This seems to think that TIOCMBIC/TIOCMBIS are only used to manipulate
  the DTR signal.  This is an invalid assumption, so it now has a #error
  and comment explaining this fact - IMO the driver author needs to fix
  this themselves.

The patch:

 drivers/char/amiserial.c           |   63 ++++-------
 drivers/char/cyclades.c            |  157 +++++------------------------
 drivers/char/epca.c                |  177 ++++++++++++++++++---------------
 drivers/char/esp.c                 |   63 +++++------
 drivers/char/ip2main.c             |  196 +++++++++++++++----------------------
 drivers/char/isicom.c              |   72 ++++---------
 drivers/char/istallion.c           |   94 ++++++++++-------
 drivers/char/moxa.c                |   97 +++++++++---------
 drivers/char/mxser.c               |   67 +++++-------
 drivers/char/pcxx.c                |  146 ++++++++++++++++-----------
 drivers/char/rio/rio_linux.c       |    5
 drivers/char/riscom8.c             |   64 +++++-------
 drivers/char/rocket.c              |   59 -----------
 drivers/char/serial167.c           |   77 ++------------
 drivers/char/sh-sci.c              |   46 +++++---
 drivers/char/specialix.c           |  108 +++++++-------------
 drivers/char/stallion.c            |   75 ++++++++------
 drivers/char/sx.c                  |   56 +++++-----
 drivers/isdn/i4l/isdn_tty.c        |  111 +++++++-------------
 drivers/macintosh/macserial.c      |   72 ++++++++-----
 drivers/net/wan/pc300_tty.c        |    8 +
 drivers/s390/net/ctctty.c          |   87 +++++-----------
 drivers/sbus/char/aurora.c         |   61 ++++-------
 drivers/serial/68360serial.c       |   98 +++++++-----------
 drivers/serial/mcfserial.c         |   78 +++++++-------
 drivers/tc/zs.c                    |   68 ++++++------
 drivers/usb/serial/ftdi_sio.c      |  181 +++++++++++++++-------------------
 net/irda/ircomm/ircomm_tty.c       |   67 ++++++++++++
 net/irda/ircomm/ircomm_tty_ioctl.c |   91 -----------------
 29 files changed, 1106 insertions(+), 1438 deletions(-)

Because of the size of the patch, I'm going to mail it out as several
chunks, and will follow up this mail.

1 - drivers which someone has tested and say works.
2 - drivers which have been updated but are untested but should work.
3 - drivers which have been updated but are broken in some way.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
