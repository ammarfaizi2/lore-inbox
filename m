Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbUKQS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbUKQS3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbUKQS1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:27:54 -0500
Received: from atarelbas04.hp.com ([156.153.255.214]:21199 "EHLO
	atlrel9.hp.com") by vger.kernel.org with ESMTP id S262339AbUKQS0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:26:49 -0500
Subject: Exar ST16C2550 rev A2 bug
From: Alex Williamson <alex.williamson@hp.com>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 17 Nov 2004 11:26:47 -0700
Message-Id: <1100716008.32679.55.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

   There seem to be an increasing number of the above UARTs floating
around and I'm wondering if we can do something to better detect and
work around their flaw.  Exar has documented the problem and their
proposed serial driver changes to work around the issue here:

http://www.exar.com/info.php?pdf=dan180_oct2004.pdf

In short, they had a mask problem that inadvertently exposes the DVID,
DREV and EFR registers on the chip.  This causes us to detect the device
as a 16650V2 and try to make use of the FIFO as if it were 32 bytes.
The previous version of the UART detected correctly as a 16550A and
worked fine.  Exar's proposed solution is simply to only set the port
type to 16650V2 if size_fifo() == 32, or simply:

===== drivers/serial/8250.c 1.91 vs edited =====
--- 1.91/drivers/serial/8250.c  2004-11-13 17:43:56 -07:00
+++ edited/drivers/serial/8250.c        2004-11-17 11:13:05 -07:00
@@ -570,7 +570,7 @@
         */
        if (size_fifo(up) == 64)
                up->port.type = PORT_16654;
-       else
+       else if (size_fifo(up) == 32)
                up->port.type = PORT_16650V2;
 }
 
The proposed 2.4 solution is quite similar.  It seems reasonable to
verify the reported FIFO size, but perhaps you have a better solution.
For anyone currently impacted by this bug, a simple yet limited
workaround is to change the uart type using setserial.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

