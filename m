Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbRAORZt>; Mon, 15 Jan 2001 12:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRAORZj>; Mon, 15 Jan 2001 12:25:39 -0500
Received: from colorfullife.com ([216.156.138.34]:2309 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129593AbRAORZ0>;
	Mon, 15 Jan 2001 12:25:26 -0500
Message-ID: <3A63327A.1D2A873D@colorfullife.com>
Date: Mon, 15 Jan 2001 18:25:14 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
CC: cherenkoff@telus.net
Subject: Re: Oops in rtl8139, and more
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is clear:
rtl8139_resume() unconditionally restarts the hardware, even if the
network was not yet started.
The hardware immediately notices something, and sends an interrupt.

The oops happens during rtl8139_open():
the function calls request_irq(), but assumes that the interrupts are
still disabled from the initial rtl8139_init_one(). Thus an interrupt
arrives before the driver structures are initialized.

Jeff, it seems that rtl8139_suspend() and rtl8139_resume() should check
if the nic was opened before stopping/restarting the hardware.

> >>EIP; c01a180e <rtl8139_rx_interrupt+b6/264>   <=====
>          Trace; c01a1d53 <rtl8139_interrupt+cf/164>
>          Trace; c010a16d <handle_IRQ_event+31/5c>
>          Trace; c010a2d7 <do_IRQ+6b/ac>
>          Trace; c0108f68 <ret_from_intr+0/20>
>          Trace; c010a6a1 <setup_irq+81/98>
>          Trace; c01a1c84 <rtl8139_interrupt+0/164>
>          Trace; c010a3a8 <request_irq+90/ac>
>          Trace; c01a067e <rtl8139_open+1e/128>
>          Trace; c01f4f90 <dev_open+48/a4>


--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
