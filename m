Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267445AbTBQUWv>; Mon, 17 Feb 2003 15:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbTBQUWv>; Mon, 17 Feb 2003 15:22:51 -0500
Received: from gateway.dadaboom.com ([198.144.206.17]:42505 "HELO
	spider.dadaboom.com") by vger.kernel.org with SMTP
	id <S267445AbTBQUWu>; Mon, 17 Feb 2003 15:22:50 -0500
From: "William King" <William.King@dadaboom.com>
To: <linux-kernel@vger.kernel.org>
Subject: Bug: 2.4.xx in serial.c
Date: Mon, 17 Feb 2003 12:32:49 -0800
Message-ID: <JAEGLIPFMODKGALKJJGNOEJGCAAA.William.King@dadaboom.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've traced what appears to be a bug in the serial driver (serial.c) in
regards to how the transmit fifo is handled on some uarts.

In the function transmit_chars() around line 6016:

count = info->xmit_fifo_size;
do {
        serial_out(info, UART_TX, info->xmit.buf[info->xmit.tail]);
        info->xmit.tail = (info->xmit.tail + 1) & (SERIAL_XMIT_SIZE-1);
        info->state->icount.tx++;
        if (info->xmit.head == info->xmit.tail)
                break;
} while (--count > 0);

This loop fills the xmit fifo with up to the number of characters which the
fifo can hold. If we have more characters to send than the fifo can handle,
we will take an interrupt when the fifo empties and run this loop again.

The assumption is however that the fifo empty interrupt will occur when the
number of characters in the xmit fifo is 0. This is true on a 16550A uart,
but is not true on others (such as a ST16C654.) The ST16C654 uart has a 64
byte fifo, but the interrrupt will occur when the number of characters drops
below a programmable threshold. The minimum threshold is 8 on this uart
which causes an overflow of the xmit fifo.

My thought for a patch is to add a field to struct async_struct to indicate
the maximum number of characters which still may be in the fifo when an
interrupt occurs. The only other thing I can think of is to poll the fifo
full bit which every character write, but this seems like a bad idea.

I'd like to get some feedback before I code up a patch. Maybe I'm just
missing the bigger picture :-)

Thanks,

-- Bill





