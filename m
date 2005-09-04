Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVIDKTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVIDKTI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 06:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVIDKTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 06:19:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9488 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751339AbVIDKTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 06:19:06 -0400
Date: Sun, 4 Sep 2005 11:19:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, jongk@linux-m68k.org
Subject: 8250_hp300: initialisation ordering bug
Message-ID: <20050904111901.A30509@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	jongk@linux-m68k.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed that 8250_hp300 is buggy wrt the ordering of hardware
initialisation to the visibility of devices to user space.  Namely,
8250_hp300 does the following:

        line = serial8250_register_port(&port);
...
        /* Enable board-interrupts */
        out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, DCA_IC_IE);
        dio_set_drvdata(d, (void *)line);

        /* Reset the DCA */
        out_8(d->resource.start + DIO_VIRADDRBASE + DCA_ID, 0xff);
        udelay(100);

serial8250_register_port() makes the port visible to userspace, so
from that point on it could be opened.  However, if it's opened
prior to the remainder of the above completing, we will be missing
interrupts (and what effect does "reset the DCA" have?)

Surely this hardware fiddling should be completed before we register
the port?


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
