Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTBQWuN>; Mon, 17 Feb 2003 17:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbTBQWuN>; Mon, 17 Feb 2003 17:50:13 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:41160 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267623AbTBQWuM>; Mon, 17 Feb 2003 17:50:12 -0500
Date: Tue, 18 Feb 2003 00:00:06 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: William King <William.King@dadaboom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug: 2.4.xx in serial.c
Message-ID: <20030217230006.GA1797@wohnheim.fh-wedel.de>
References: <JAEGLIPFMODKGALKJJGNOEJGCAAA.William.King@dadaboom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <JAEGLIPFMODKGALKJJGNOEJGCAAA.William.King@dadaboom.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 February 2003 12:32:49 -0800, William King wrote:
> 
> I've traced what appears to be a bug in the serial driver (serial.c) in
> regards to how the transmit fifo is handled on some uarts.
> 
> In the function transmit_chars() around line 6016:
> 
> count = info->xmit_fifo_size;
> do {
>         serial_out(info, UART_TX, info->xmit.buf[info->xmit.tail]);
>         info->xmit.tail = (info->xmit.tail + 1) & (SERIAL_XMIT_SIZE-1);
>         info->state->icount.tx++;
>         if (info->xmit.head == info->xmit.tail)
>                 break;
> } while (--count > 0);
> 
> This loop fills the xmit fifo with up to the number of characters which the
> fifo can hold. If we have more characters to send than the fifo can handle,
> we will take an interrupt when the fifo empties and run this loop again.
> 
> The assumption is however that the fifo empty interrupt will occur when the
> number of characters in the xmit fifo is 0. This is true on a 16550A uart,
> but is not true on others (such as a ST16C654.) The ST16C654 uart has a 64
> byte fifo, but the interrrupt will occur when the number of characters drops
> below a programmable threshold. The minimum threshold is 8 on this uart
> which causes an overflow of the xmit fifo.
>
> My thought for a patch is to add a field to struct async_struct to indicate
> the maximum number of characters which still may be in the fifo when an
> interrupt occurs. The only other thing I can think of is to poll the fifo
> full bit which every character write, but this seems like a bad idea.

I'd go with the extra field:

+static int threshold = 0;
 [...]
-count = info->xmit_fifo_size;
+count = info->xmit_fifo_size - threshold;
 [...]
+if (ST16C654) {
+	threshold = 8;
+	ST16C654_set_threshold(threshold);
+}

IO operations are usually quite expensive, so polling should be a last
resort only.

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 
