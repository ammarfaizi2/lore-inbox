Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUI1Pet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUI1Pet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbUI1Pet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 11:34:49 -0400
Received: from ns.vscom.de ([62.145.30.242]:20448 "EHLO
	hhlx01.visionsystems.de") by vger.kernel.org with ESMTP
	id S267934AbUI1Pel convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 11:34:41 -0400
From: Roland =?iso-8859-1?q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>
Organization: Vision Systems GmbH
To: linux-kernel@vger.kernel.org
Subject: Serial driver hangs
Date: Tue, 28 Sep 2004 17:34:38 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409281734.38781.roland.cassebohm@visionsystems.de>
X-OriginalArrivalTime: 28 Sep 2004 15:34:39.0404 (UTC) FILETIME=[AAD236C0:01C4A570]
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.12; VDF 6.27.0.77
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my platform is uClinux kernel 2.4.24 with an ARM with PCI and 
a 2 port VSCOM 200I PCI card.

I use the serial driver with very high load. With my 
application sends and receives on two ports with 921600 baud.

After a while the driver hangs in an endless loop in the 
interrupt routine.
As I can see, the bit TTY_DONT_FLIP in tty->flags is set, so 
the receive-buffer can't be flipped. In receive_chars() all 
ports are checked for received bytes, but if the buffer is 
full and can't be flipped, no byte are read from the UART and 
the interrupt will never go inactive.

>>>>>>>>>>>>
    do {
        if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
            tty->flip.tqueue.routine((void *) tty);
            if (tty->flip.count >= TTY_FLIPBUF_SIZE)
                return;     // if TTY_DONT_FLIP is set
        }
        ch = serial_inp(info, UART_RX);
        *tty->flip.char_buf_ptr = ch;
        icount->rx++;
>>>>>>>>>>>>

I have tried just to read all byte left in the FIFO of the 
UART in that case and throw them away.

>>>>>>>>>>>>
            if (tty->flip.count >= TTY_FLIPBUF_SIZE)
            {
                do {
                    ch = serial_inp(info, UART_RX);
                    icount->overrun++;
                    *status = serial_inp(info, UART_LSR);
                } while (*status & UART_LSR_DR);
                return;     // if TTY_DONT_FLIP is set
            }
>>>>>>>>>>>>

This is working but would probably not the best way, because 
there could be enough place in the other flip buffer. Maybe 
it is possible to disable the receive interrupt of the UART 
till the receive routine read_chan(), which sets 
TTY_DONT_FLIP, releases the buffer.

Thanks for any help,
Roland
-- 
___________________________________________________

VS Vision Systems GmbH, Industrial Image Processing
Dipl.-Ing. Roland Caﬂebohm
Aspelohe 27A, D-22848 Norderstedt, Germany
http://www.visionsystems.de
___________________________________________________
