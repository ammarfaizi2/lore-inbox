Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUAMLAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUAMLAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:00:55 -0500
Received: from 134.gymko.ba.gtsi.sk ([62.168.65.134]:53899 "EHLO eloth.gjh.sk")
	by vger.kernel.org with ESMTP id S264283AbUAMLAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:00:48 -0500
Date: Tue, 13 Jan 2004 12:00:15 +0100 (CET)
From: Jozef Vesely <vesely@gjh.sk>
X-X-Sender: vesely@eloth
To: irda-users@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [PROBLEM] ircomm ioctls
Message-ID: <Pine.LNX.4.44.0401131148070.18661-100000@eloth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since upgrading to the 2.6.1 (from 2.4.22)

I am gettig this error (while connecting to my mobile phone):
------
# gsmctl -d /dev/ircomm0  ALL
gsmctl[ERROR]: clearing DTR failed (errno: 22/Invalid argument)
------

the code in: gsmlib-1.10/gsmlib/gsm_unix_serial.cc
------
    // toggle DTR to reset modem
    int mctl = TIOCM_DTR;
    if (ioctl(_fd, TIOCMBIC, &mctl) < 0)
      throwModemException(_("clearing DTR failed"));
    // the waiting time for DTR toggling is increased with each loop
    usleep(holdoff[initTries]);
    if (ioctl(_fd, TIOCMBIS, &mctl) < 0)
      throwModemException(_("setting DTR failed"));
------

pointed me to tke kernel:
the ioctls TIOCMBIC, TIOCMBIS, TIOCMSET and TIOCMGET are handled both in

net/irda/ircomm/ircomm_tty_ioctl.c  function  ircomm_tty_ioctl()
-----
       switch (cmd) {
        case TIOCMGET:
                ret = ircomm_tty_get_modem_info(self, (unsigned int *) arg);
                break;
        case TIOCMBIS:
        case TIOCMBIC:
        case TIOCMSET:
                ret = ircomm_tty_set_modem_info(self, cmd, (unsigned int *) arg);
                break;
-----

and in
drivers/char/tty_io.c function tty_ioctl()
-----
      switch (cmd) {
...
                case TIOCMGET:
                        return tty_tiocmget(tty, file, arg);

                case TIOCMSET:
                case TIOCMBIC:
                case TIOCMBIS:
                        return tty_tiocmset(tty, file, cmd, arg);
        }
        if (tty->driver->ioctl) {
                int retval = (tty->driver->ioctl)(tty, file, cmd, arg);
                if (retval != -ENOIOCTLCMD)
                        return retval;
        }
-----

The tty_tiocmset() checks for driver->tiocmset and calls it. In case
of ircomm driver->tiocmset is not set since those ioctls are meant
to be handled by driver->ioctl, however tty_tiocmset returns with -EINVAL
and driver->ioctl never gets called.

I am beginner in the kernel programing, and therefore I would rather let more
experienced to create the patch (I don't want to mess up something).

I hope this descrition would be helpful, and somebody fixes the problem.

Thank you in advance

Jozef Vesely
vesely@gjh.sk



