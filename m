Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUJTStp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUJTStp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268944AbUJTStJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:49:09 -0400
Received: from wang.choosehosting.com ([212.42.1.230]:23249 "EHLO
	wang.choosehosting.com") by vger.kernel.org with ESMTP
	id S269056AbUJTSrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:47:18 -0400
From: Thomas Stewart <thomas@stewarts.org.uk>
To: linux-kernel@vger.kernel.org
Subject: belkin usb serial converter (mct_u232), break not working
Date: Wed, 20 Oct 2004 19:46:35 +0100
User-Agent: KMail/1.6.2
X-PGP-Key: http://www.stewarts.org.uk/public-key.asc
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410201946.35514.thomas@stewarts.org.uk>
X-Scanner: Exiscan on wang.choosehosting.com at 2004-10-20 19:47:14
X-Spam-Score: 0.0
X-Spam-Bars: /
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having trouble with a Belkin USB serial adapter, I can't get it to send a 
break down the serial cable to a console.

I made a quick program to send a break to a port (mostly ripped off from 
minicom). 

porttest.c:
#include <sys/fcntl.h>
#include <sys/ioctl.h>
main () {
        int fd = open("/dev/ttyS0", O_RDWR|O_NOCTTY);
        ioctl(fd, TCSBRK, 0);
        close(fd);
}

Both minicom and my program send a break fine to a regular pc serial port (eg 
ttyS0). In this case it drops my sun box to an "ok" prompt.

However if I use the usb serial adapter both minicom and my program are unable 
to send breaks, they just seem to get ignored.

I loaded the modules with debugging information turned on:-
modprobe usbserial debug=1
modprobe mct_u232 debug=1

$ sudo tail -f /var/log/syslog &
$ ./porttest
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/usb-serial.c: serial_open
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: mct_u232_open 
port 1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: set_modem_ctrl: 
state=0x6 ==> mcr=0xb
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: set_line_ctrl: 
0x3
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: get_modem_stat: 
0x30
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: msr_to_state: 
msr=0x30 ==> state=0x126
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/usb-serial.c: 
serial_chars_in_buffer = port 1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/generic.c: 
usb_serial_generic_chars_in_buffer - port 1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/generic.c: 
usb_serial_generic_chars_in_buffer - returns 0
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/usb-serial.c: serial_break - 
port 1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: 
mct_u232_break_ctlstate=-1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: set_line_ctrl: 
0x43
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/usb-serial.c: serial_break - 
port 1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: 
mct_u232_break_ctlstate=0
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: set_line_ctrl: 
0x3
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/usb-serial.c: serial_close - 
port 1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: mct_u232_close 
port 1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: 
mct_u232_read_int_callback - port 1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: 
mct_u232_read_int_callback - urb shutting down with status: -2
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: 
mct_u232_read_int_callback - port 1
Oct 20 15:45:42 hydra kernel: drivers/usb/serial/mct_u232.c: 
mct_u232_read_int_callback - urb shutting down with status: -2

set_line_ctrl gets changed from 0x3 to 0x43 and back to 0x3. According to 
mct_u232.h the 6th bit of the line control register is the "set break" bit. 
So It looks like it thinks its sending a break, but as far as I can tell it 
is not actually sending it (because my sun box is not dropped to an ok 
prompt)

Anyone got any ideas about how to get it to work? (Or an alternative?)

(Can replies be CC'ed to me as I'm not subscribed. Thanks)

Regards
-- 
Tom

PGP Fingerprint [DCCD 7DCB A74A 3E3B 60D5  DF4C FC1D 1ECA 68A7 0C48]
PGP Publickey   [http://www.stewarts.org.uk/public-key.asc]
PGP ID  [0x68A70C48]
