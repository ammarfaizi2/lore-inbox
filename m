Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262000AbSJEDcP>; Fri, 4 Oct 2002 23:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262002AbSJEDcP>; Fri, 4 Oct 2002 23:32:15 -0400
Received: from holomorphy.com ([66.224.33.161]:50128 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262000AbSJEDcO>;
	Fri, 4 Oct 2002 23:32:14 -0400
Date: Fri, 4 Oct 2002 20:36:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk
Subject: 2.5.40 serial oops
Message-ID: <20021005033659.GD21619@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On shutdown, ThinkPad T21's commit this error:

Program received signal SIGSEGV, Segmentation fault.
0x00000000 in ?? ()
(gdb) bt
#0  0x00000000 in ?? ()
#1  0xc01b9eb3 in pci_remove_one (dev=0xc1675c00) at 8250_pci.c:774
#2  0xc01b3a25 in pci_device_remove (dev=0xc1675c50) at pci-driver.c:68
#3  0xc01bdbae in device_shutdown () at power.c:106
#4  0xc0121421 in sys_reboot (magic1=-18751827, magic2=672274793, 
    cmd=1126301404, arg=0x8049960) at sys.c:393
#5  0xc0108a8f in syscall_call () at process.c:685

(gdb) p *priv->board
$1 = {flags = 0, num_ports = 1, base_baud = 115200, uart_offset = 0, 
  reg_shift = 0, init_fn = 0, first_uart_offset = 0}
(gdb) p pci_boards - priv->board
$2 = 0

Against 2.5.40


--- linux-2.5.40/drivers/serial/8250_pci.c.orig	2002-10-04 20:27:50.000000000 -0700
+++ linux-2.5.40/drivers/serial/8250_pci.c	2002-10-04 20:28:02.000000000 -0700
@@ -771,7 +771,8 @@
 		for (i = 0; i < priv->nr; i++)
 			unregister_serial(priv->line[i]);
 
-		priv->board->init_fn(dev, priv->board, 0);
+		if (priv->board->init_fn)
+			priv->board->init_fn(dev, priv->board, 0);
 
 		pci_disable_device(dev);
 
