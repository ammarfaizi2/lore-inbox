Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269751AbUJAKnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269751AbUJAKnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269754AbUJAKnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:43:19 -0400
Received: from corb.mc.mpls.visi.com ([208.42.156.1]:7124 "EHLO
	corb.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id S269751AbUJAKnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:43:17 -0400
Message-ID: <415D3408.8070201@steinerpoint.com>
Date: Fri, 01 Oct 2004 05:40:08 -0500
From: Al Borchers <alborchers@steinerpoint.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: new locking in change_termios breaks USB serial drivers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.9-rc3 changes the locking in the tty_ioctl.c function
change_termios().  It gets a spin_lock_irqsave(&tty_termios_lock,...)
before calling the tty driver's set_termios function.

This means that the drivers' set_termios functions cannot sleep.

Unfortunately, many USB serial drivers' set_termios functions
send an urb to change the termios settings and sleep waiting for
it to complete.

I just looked quickly, but it seems belkin_sa.c, digi_acceleport.c,
ftdi_sio.c, io_ti.c, kl5usb105.c, mct_u232.c, pl2303.c, and whiteheat.c
all sleep in their set_termios functions.

If this locking in change_termios() stays, we are going to have to
fix set_termios in all of these drivers.  I am updating io_ti.c right
now.

-- Al

