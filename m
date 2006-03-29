Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWC2MXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWC2MXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 07:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWC2MXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 07:23:34 -0500
Received: from kuu212123311.barco.com ([212.123.3.11]:15210 "HELO
	kuuvir01.barco.com") by vger.kernel.org with SMTP id S1750987AbWC2MXd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 07:23:33 -0500
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linux-kernel@vger.kernel.org
Subject: serial/8250: Platform override of is_real_interrupt
Date: Wed, 29 Mar 2006 14:23:31 +0200
Message-ID: <8764lxphh8.fsf@sleipner.barco.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the serial/8250 driver on a ML300 based PPC board which uses
interrupt vector 0 for the UART.

is_real_interrupt() unfortunately interpretes IRQ0 as meaning no
interrupt, so performance is kinda crap.

How to fix? 8250.c is setup so that asm/serial.h is included after the
definition of is_real_interrupt and the idea is that you can redefine
it in your platform header if needed. Now, this doesn't work on PPC as
the platform headers are included in asm/io.h AND asm/serial.h so they
won't be reparsed the second time.

I see 3 options:

1) Put an #ifndef is_real_interrupt around the is_real_interrupt
   definition so the platform header can define it's own version
   independent of inclusion order.

2) A lot of platforms (but not all) define NO_IRQ to something
   sensible (-1). Define is_real_interrupt in terms of NO_IRQ instead
   of testing against 0. For the remaining platforms we could locally
   define NO_IRQ to 0 to keep the old behavior.

3) Put the redefine directly in asm/serial.h surrounded by an #ifdef
   CONFIG_XILINX_ML300 (ugly)

Which solution is preferable?

-- 
Bye, Peter Korsgaard
