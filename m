Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWJKSur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWJKSur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWJKSuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:50:46 -0400
Received: from mx0.karneval.cz ([81.27.192.123]:51773 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S932137AbWJKSuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:50:46 -0400
Message-ID: <452D3D01.50001@gmail.com>
Date: Wed, 11 Oct 2006 20:50:41 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: tty_driver->ttys association
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found this construction in the kernel:
static struct tty_driver *my_ttydriver;
static struct tty_struct *my_tty[PORTS + 1];
static struct termios *my_termios[PORTS + 1];
static struct termios *my_termios_locked[PORTS + 1];

...(alloc+set_op+...)
my_ttydriver->flags = TTY_DRIVER_REAL_RAW|TTY_DRIVER_DYNAMIC_DEV;
my_ttydriver->ttys = my_tty;
my_ttydriver->termios = my_termios;
my_ttydriver->termios_locked = my_termios_locked;
tty_register_driver(my_ttydriver);

The association is completely useless due to
if (p) {
     driver->ttys = (struct tty_struct **)p;
     driver->termios = (struct termios **)(p + driver->num);
     driver->termios_locked = (struct termios **)(p + driver->num * 2);
} else {
     driver->ttys = NULL;
     driver->termios = NULL;
     driver->termios_locked = NULL;
}

in tty_register_driver, isn't it? Can we save some memory?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
