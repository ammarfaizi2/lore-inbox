Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267440AbUIIXVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUIIXVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUIIXUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:20:40 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:33983 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266810AbUIIXTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:19:48 -0400
Date: Thu, 9 Sep 2004 16:19:47 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6 SERIAL] Add support for word-length UART registers.
Message-ID: <20040909231947.GA5236@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



UARTS on several Intel IXP2000 systems are connected in such
a way that they can only be addressed using full word accesses
instead of bytes. Following patch adds a UPIO_MEM32 io-type to
identify these UARTs.

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

===== drivers/serial/8250.c 1.57 vs edited =====
--- 1.57/drivers/serial/8250.c	Mon Jul  5 03:33:38 2004
+++ edited/drivers/serial/8250.c	Thu Sep  9 14:22:07 2004
@@ -187,6 +187,9 @@
 	case UPIO_MEM:
 		return readb(up->port.membase + offset);
 
+	case UPIO_MEM32:
+		return readl(up->port.membase + offset);
+
 	default:
 		return inb(up->port.iobase + offset);
 	}
@@ -205,6 +208,10 @@
 
 	case UPIO_MEM:
 		writeb(value, up->port.membase + offset);
+		break;
+
+	case UPIO_MEM32:
+		writel(value, up->port.membase + offset);
 		break;
 
 	default:
===== drivers/serial/serial_core.c 1.87 vs edited =====
--- 1.87/drivers/serial/serial_core.c	Tue Jun 29 07:43:58 2004
+++ edited/drivers/serial/serial_core.c	Thu Sep  9 15:02:33 2004
@@ -1978,6 +1978,7 @@
 		printk("I/O 0x%x offset 0x%x", port->iobase, port->hub6);
 		break;
 	case UPIO_MEM:
+	case UPIO_MEM32:
 		printk("MMIO 0x%lx", port->mapbase);
 		break;
 	}
===== include/linux/serial_core.h 1.42 vs edited =====
--- 1.42/include/linux/serial_core.h	Thu Jul 29 06:12:47 2004
+++ edited/include/linux/serial_core.h	Thu Sep  9 14:18:25 2004
@@ -176,6 +176,7 @@
 #define UPIO_PORT		(0)
 #define UPIO_HUB6		(1)
 #define UPIO_MEM		(2)
+#define UPIO_MEM32		(3)
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */


-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
