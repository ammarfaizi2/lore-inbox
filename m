Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTFOJVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 05:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTFOJVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 05:21:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57861 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262032AbTFOJVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 05:21:14 -0400
Date: Sun, 15 Jun 2003 10:34:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: hugang <hugang@soulinfo.com>
Cc: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Pcmcia GPRS cards not works in linux.
Message-ID: <20030615103456.B27533@flint.arm.linux.org.uk>
Mail-Followup-To: hugang <hugang@soulinfo.com>,
	dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030615104322.496279e1.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030615104322.496279e1.hugang@soulinfo.com>; from hugang@soulinfo.com on Sun, Jun 15, 2003 at 10:43:22AM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 10:43:22AM +0800, hugang wrote:
> Machine Mode: Dell Latitude V740.
> PCMCIA  card: OPTION (GLOBETROTTER)
> Kernel      : 2.5.70-mm4 #29 Áù 6ÔÂ 14 18:57:13 CST 2003
> Cardctl -V  : cardctl version 3.1.33
> 
> The cards is works fine in windows, How can I let it works in linux, Any
> information is welcome.

Could you include the information below and the output of cardctl
status please?

I think I can tell you what's happening.  Your card contains two
configuration table entries (0x30 and 0x31).  The first, 0x30,
tells us that the card supports 3.3V in this configuration.  The
second indicates that the card supports 5V with this configuration.

I suspect that the card voltage sense pins are indicating that the
card requires 5V, but we're trying to use the 0x30 configuration.
Since we don't allow the socket voltage to be altered, we error out
and never try the second configuration.

David, I think it would make sense to allow the PCMCIA subsystem to
lower VCC in these circumstances, but obviously never allow it to be
raised above the value reported by the voltage sense pins?

> --dmesg---
> cs: IO port probe 0x0c00-0x0cff: clean.
> cs: IO port probe 0x0800-0x08ff: clean.
> cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
> cs: IO port probe 0x0a00-0x0aff: clean.
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
> serial_cs: RequestConfiguration: Bad Vcc

> --dump_cis -vSocket 0:
>   offset 0x02, tuple 0x01, link 0x03
>     00 00 ff 
>   dev_info
>     NULL 0ns, 512b
> 
>   offset 0x07, tuple 0x1c, link 0x04
>     02 00 00 ff 
> 
>   offset 0x0d, tuple 0x15, link 0x13
>     04 01 45 26 45 00 45 45 38 32 38 00 30 30 31 00 
>     41 00 ff 
>   vers_1 4.1, "E&E", "EE828", "001", "A"
> 
>   offset 0x22, tuple 0x20, link 0x04
>     13 00 00 00 
>   manfid 0x0013, 0x0000
> 
>   offset 0x28, tuple 0x21, link 0x02
>     02 00 
>   funcid serial_port
> 
>   offset 0x2c, tuple 0x22, link 0x04
>     00 02 00 18 
>   serial_interface
>     uart 16550 [8] [1]
> 
>   offset 0x32, tuple 0x22, link 0x09
>     05 1f 0f 00 03 00 00 03 00 
>   serial_modem_cap_data
>     flow [XON/XOFF xmit] [XON/XOFF rcv] [hw xmit] [hw rcv] [transparent]
>     cmd_buf 64 rcv_buf 768 xmit_buf 768
> 
>   offset 0x3d, tuple 0x22, link 0x0d
>     02 06 00 2e 04 03 03 0f 07 00 01 b5 ff 
>   serial_data_services
>     data_rate 115200
>     modulation [V.21] [V.23] [V.22] [V.22bis] [V.32]
>     error_control [MNP2-4] [V.42/LAPM]
>     compression [V.42bis] [MNP5]
>     cmd_protocol [AT1] [AT2] [AT3] [MNP_AT]
> 
>   offset 0x4c, tuple 0x1a, link 0x05
>     01 31 00 04 01 
>   config base 0x0400 mask 0x0001 last_index 0x31
> 
>   offset 0x53, tuple 0x1b, link 0x0a
>     f0 01 19 01 b5 1e 24 30 ff ff 
>   cftable_entry 0x30 [default]
>     Vcc Vnom 3300mV
>     io 0x0000-0x000f [lines=4] [8bit]
>     irq mask 0xffff [level]
> 
>   offset 0x5f, tuple 0x1b, link 0x09
>     f1 01 19 01 55 24 30 ff ff 
>   cftable_entry 0x31 [default]
>     Vcc Vnom 5V
>     io 0x0000-0x000f [lines=4] [8bit]
>     irq mask 0xffff [level]
> 
>   offset 0x6a, tuple 0x14, link 0x00
>   no_long_link

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

