Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVBVPVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVBVPVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 10:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVBVPVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 10:21:35 -0500
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:12678 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S262327AbVBVPV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 10:21:29 -0500
Message-ID: <313680C9A886D511A06000204840E1CF0A647667@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PPC32 8xx MPC880  Linux 2.6 Interrupt storm 
Date: Tue, 22 Feb 2005 10:21:27 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have MPC880 based board with 24C02 I2C serial EEPROM
 and I try to run Linux 2.6 on this board.

Originally I had problem:

<3>request_irq() returned -22 for CPM vector 32.

I traced the problem to the following line,
shown below as commented out (by me)
in cpm_iic_init() (drivers/i2c/algos/i2c-algo-8xx.c)

/* (*cpm_adap->setisr)(CPM_IRQ_OFFSET + CPMVEC_I2C, cpm_iic_interrupt,
cpm_int_name[CPMVEC_I2C], (void *)i2c); */
                               ^                             ^
                               |                             |
                               16                           16

It makes the first argument to be 32 (16 + 16) and that was originally
causing error.

This error gets generated actually in request_irq() in kernel/irq/manage.c.

Specifically (I tracked it down with debug print there ) it comes from

if (irq >= NR_IRQS)

return -EINVAL;

Note that NR_IRQS is set to 32 and irq was also 32 as described above
(before my "fix" - see below) .

I have made the "fix" (it's just a kludge, I am not sure where the correct
fix should be
and what is the actual origin of this problem):


(*cpm_adap->setisr)(CPM_IRQ_OFFSET + CPMVEC_I2C - CPM_IRQ_OFFSET,
cpm_iic_interrupt, cpm_int_name[CPMVEC_I2C], (void *)i2c);

                                                  ^^^^^^^^^^^^^^^

I am leaving above line "as is" just for demonstrational purpose: to show
that in the first argument the 
CPM_IRQ_OFFSET is originally added and I am subtracting it back.

This gives:

cpm_iic_init[134] Install ISR for IRQ 16 CPM_IRQ_OFFSET 16

rpx_install_isr: irq: 0x10 <<<=============    This is correct IRQ for I2C
on 8xx

However after this "fix" I see continuos flood of interrupts for IRQ 0x10
(dedicated to I2C on 8xx) in response to polling of 0x50 I2C address 
- should be just one interrupt ...
but actually, the ISR function gets triggered in continuous non-stop flood -
I could see it with the print statement (of course I disabled this print for
the next build ...) so it chokes the processor completely.

Thanks,
Best Regards,
Alex

