Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbSJUM0s>; Mon, 21 Oct 2002 08:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261355AbSJUM0s>; Mon, 21 Oct 2002 08:26:48 -0400
Received: from zeen.snu.ac.kr ([147.46.215.55]:27539 "EHLO zeen.snu.ac.kr")
	by vger.kernel.org with ESMTP id <S261351AbSJUM0q>;
	Mon, 21 Oct 2002 08:26:46 -0400
Message-ID: <3DB3F3F7.5E195B9F@zeen.snu.ac.kr>
Date: Mon, 21 Oct 2002 21:32:55 +0900
From: Joosun Hahn <jshan@zeen.snu.ac.kr>
Organization: =?EUC-KR?B?wfbAzsGkurix4rz6?=(=?EUC-KR?B?wdY=?=)
X-Mailer: Mozilla 4.51 [ko] (Win98; U)
X-Accept-Language: ko
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem in writing to the serial port in 2.4.19
References: <20021021102622Z261330-32597+6184@vger.kernel.org>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

I wrote a linux loadable kernel module 
that exchanges data with a device through /dev/ttyS0.
For this purpose, I set the serial tty's ldisc (tty->ldisc) 
to my own line discipline and it worked well in the kernel 2.4.2.

But, when I upgrade the kernel to 2.4.19,
it does not seem to send data as it was before.
If I load the module and send some data in succession,
the device attached to the serial port becomes down shortly after.

The following is my routine to send data to /dev/ttyS0:

--
while (len > 0) {
        int space, n_wr;

        if (tty->driver.write_room)
                space = tty->driver.write_room(tty);

        n_wr = (len < space)? len: space;

        if (tty->driver.flush_chars)
                tty->driver.flush_chars(tty);

        n_wr = tty->driver.write(tty, 0, buf, n_wr);

        buf += n_wr;
        len += n_wr;
}
--

In order to send data in succession, I call the above routine
within another while loop with different (buf, len) parameters. 

The scheme worked well in 2.4.2, but does not work in 2.4.19.
So, I re-wrote the routine like this:

--
tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);

while (len > 0) {
        int space, n_wr;

        if (tty->driver.write_room)
                space = tty->driver.write_room(tty);

        n_wr = (len < space)? len: space;

        if (tty->driver.flush_chars)
                tty->driver.flush_chars(tty);

        n_wr = tty->driver.write(tty, 0, buf, n_wr);

        buf += n_wr;
        len += n_wr;
}
--

And, in the function void xx_write_wakeup (struct tty_struct *tty):

--
tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);

/* and, re-send data */
--

The result is that both do not work. :-(

I believe the serial driver in 2.4.19 will work correctly.
If there is anything that I'm missing, please let me know.

Thank you in advance.


Joosun.

ps. UART(16550A), baudrate(115200), crtscts(ON).
