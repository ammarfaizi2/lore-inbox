Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264102AbUDVO5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbUDVO5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 10:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUDVO5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 10:57:41 -0400
Received: from cc60549-a.deven1.ov.home.nl ([217.120.140.54]:21262 "EHLO
	server.grimmerink.dhs.org") by vger.kernel.org with ESMTP
	id S264102AbUDVO5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 10:57:39 -0400
From: Pieter Grimmerink <p.grimmerink@home.nl>
To: linux-kernel@vger.kernel.org
Subject: set termios from within line discipline
Date: Thu, 22 Apr 2004 16:57:34 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404221657.35327.p.grimmerink@home.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am porting a 9bit serial protocol that requires the 9th bit to be high on 
the last transmitted byte, and low on the others.

What I tried to do was implement a line discipline that changes parity before 
each byte is transmitted, to get the proper 9th bit value.

But the problem is changing the parity from a line discipline.
This is what I do, when a parity change has to be made:

tty_wait_until_sent(dev->tty, 0);
if (signal_pending(current)) return -EINTR;

if (odd)
{
  tty->termios->c_cflag |= PARODD;
}
else
{
  tty->termios->c_cflag &= ~PARODD;
}

if (tty->driver.set_termios)
  tty->driver.set_termios(tty, &oldterm);
if (tty->ldisc.set_termios)
  tty->ldisc.set_termios(tty, &oldterm);

tty->driver.write(tty, 0, &byte, 1);

Two things,
1. when I use 'tcgetattr' from userspace, I don't see the changes made from 
within the line discipline
2. though I see that the parity changes now and then, the transmitted bytes 
don't always have the correct parity

What would be the preferred way to change termios flags from a line 
discipline?

Please also reply to my email address, since I'm not subscribed to the list.

Best regards,

Pieter

