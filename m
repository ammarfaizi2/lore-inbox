Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbTCVMMj>; Sat, 22 Mar 2003 07:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbTCVMMj>; Sat, 22 Mar 2003 07:12:39 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:59584 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S262699AbTCVMMi>;
	Sat, 22 Mar 2003 07:12:38 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303221223.h2MCNds10847@csl.stanford.edu>
Subject: [CHECKER] race in 2.5.62/drivers/char/esp.c?
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Mar 2003 04:23:38 -0800 (PST)
Cc: engler@csl.stanford.edu (Dawson Engler)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

enclosed is a call to <serial_out> without interrupts disabled.  It
seems to require this, given the numerous examples that look like:

/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:1426:rs_throttle
        cli();
        info->IER &= ~UART_IER_RDI;
        serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
        serial_out(info, UART_ESI_CMD2, info->IER);
        serial_out(info, UART_ESI_CMD1, ESI_SET_RX_TIMEOUT);
        serial_out(info, UART_ESI_CMD2, 0x00);
        sti();

/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:1206
        save_flags(flags); cli();
        /* set baud */
        serial_out(info, UART_ESI_CMD1, ESI_SET_BAUD);
        serial_out(info, UART_ESI_CMD2, quot >> 8);
        serial_out(info, UART_ESI_CMD2, quot & 0xff);

If anyone can confirm/discredit, I'd appreciate it.

Dawson
------------------------------------------------------------------


/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:2313:block_til_ready:ERROR:RACE:2313:2313:calling routine <serial_out> with no lock held [locked_uses=37] [unlocked_uses=1] [n_first=11] [n_last=17] [n_root=12] [n_file_read=1] [n_unlocked=1] [same_level_locked_uses=32][has_locked=1] [depth=6] [path=/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:esp_open:2391->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:esp_open:2395->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:block_til_ready:2211->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:block_til_ready:2279->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:block_til_ready:2300->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:block_til_ready:2313->end=/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/esp.c:block_til_ready:2313] [score=9] [z=3.68] [rank=easy]

                        retval = -EAGAIN;
#endif
                        break;
                }


Error --->
                serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
                if (serial_in(info, UART_ESI_STAT2) & UART_MSR_DCD)
                        do_clocal = 1;

