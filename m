Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVFGCSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVFGCSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVFGCSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:18:21 -0400
Received: from mail.renesas.com ([202.234.163.13]:13962 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261318AbVFGCPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:15:13 -0400
Date: Tue, 07 Jun 2005 11:15:09 +0900 (JST)
Message-Id: <20050607.111509.235707332.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org,
       sakugawa@linux-m32r.org
Subject: [PATCH 2.6.12-rc5] m32r: Update io_xxxxx.c (was Re: [PATCH
 2.6.12-rc5] m32r: Support M3A-2170(Mappi-III) platform)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050531140151.791007b3.akpm@osdl.org>
References: <20050531.214805.783383719.takata.hirokazu@renesas.com>
	<20050531140151.791007b3.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't it make things more maintainable if (for example) _inb_p() called
> _inb() rather than duplicating it?

I see.

Here is a patchset to fix arch/m32r/kernel/io_xxxxx.c.
Please apply.

From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.12-rc5] m32r: Support M3A-2170(Mappi-III) platform
Date: Tue, 31 May 2005 14:01:51 -0700
> Hirokazu Takata <takata@linux-m32r.org> wrote:
> > +unsigned char _inb(unsigned long port)
> > +{
> > +	if (port >= LAN_IOSTART && port < LAN_IOEND)
> > +		return _ne_inb(PORT2ADDR_NE(port));
> > +#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
> > +	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
> > +		return *(volatile unsigned char *)__port2addr_ata(port);
> > +	}
> > +#endif
> > +#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
> > +	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
> > +		unsigned char b;
> > +		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
> > +		return b;
> > +	} else
> > +#endif
> > +	return *(volatile unsigned char *)PORT2ADDR(port);
> > +}
> 
> This file contains some very strange stuff.
> 
> > +unsigned char _inb_p(unsigned long port)
> > +{
> > +	unsigned char  v;
> > +
> > +	if (port >= LAN_IOSTART && port < LAN_IOEND)
> > +		v = _ne_inb(PORT2ADDR_NE(port));
> > +	else
> > +#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
> > +	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
> > +		return *(volatile unsigned char *)__port2addr_ata(port);
> > +	} else
> > +#endif
> > +#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
> > +	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
> > +		unsigned char b;
> > +		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
> > +		return b;
> > +	} else
> > +#endif
> > +		v = *(volatile unsigned char *)PORT2ADDR(port);
> > +
> > +	delay();
> > +	return (v);
> > +}
> 
> Wouldn't it make things more maintainable if (for example) _inb_p() called
> _inb() rather than duplicating it?

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/io_m32700ut.c |   92 +++--------------------------------------
 arch/m32r/kernel/io_mappi.c    |   74 +++-----------------------------
 arch/m32r/kernel/io_mappi2.c   |   90 +++-------------------------------------
 arch/m32r/kernel/io_mappi3.c   |   88 ++-------------------------------------
 arch/m32r/kernel/io_oaks32r.c  |   36 +++-------------
 arch/m32r/kernel/io_opsput.c   |   79 ++++-------------------------------
 arch/m32r/kernel/io_usrv.c     |   51 ++++++----------------
 7 files changed, 59 insertions(+), 451 deletions(-)


diff -ruNp a/arch/m32r/kernel/io_m32700ut.c b/arch/m32r/kernel/io_m32700ut.c
--- a/arch/m32r/kernel/io_m32700ut.c	2004-12-25 06:35:00.000000000 +0900
+++ b/arch/m32r/kernel/io_m32700ut.c	2005-06-03 11:49:42.000000000 +0900
@@ -3,8 +3,8 @@
  *
  *  Typical I/O routines for M32700UT board.
  *
- *  Copyright (c) 2001, 2002  Hiroyuki Kondo, Hirokazu Takata,
- *                            Hitoshi Yamamoto, Takeo Takahashi
+ *  Copyright (c) 2001-2005  Hiroyuki Kondo, Hirokazu Takata,
+ *                           Hitoshi Yamamoto, Takeo Takahashi
  *
  *  This file is subject to the terms and conditions of the GNU General
  *  Public License.  See the file "COPYING" in the main directory of this
@@ -172,64 +172,21 @@ unsigned long _inl(unsigned long port)
 
 unsigned char _inb_p(unsigned long port)
 {
-	unsigned char  v;
-
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		v = _ne_inb(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		return *(volatile unsigned char *)__port2addr_ata(port);
-	} else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned char b;
-		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-		return b;
-	} else
-#endif
-		v = *(volatile unsigned char *)PORT2ADDR(port);
-
+	unsigned char v = _inb(port);
 	delay();
 	return (v);
 }
 
 unsigned short _inw_p(unsigned long port)
 {
-	unsigned short  v;
-
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		v = _ne_inw(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		return *(volatile unsigned short *)__port2addr_ata(port);
-	} else
-#endif
-#if defined(CONFIG_USB)
-	if(port >= 0x340 && port < 0x3a0)
-		return *(volatile unsigned short *)PORT2ADDR_USB(port);
-	else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned short w;
-		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-		return w;
-	} else
-#endif
-		v = *(volatile unsigned short *)PORT2ADDR(port);
-
+	unsigned short v = _inw(port);
 	delay();
 	return (v);
 }
 
 unsigned long _inl_p(unsigned long port)
 {
-	unsigned long  v;
-
-	v = *(volatile unsigned long *)PORT2ADDR(port);
+	unsigned long v = _inl(port);
 	delay();
 	return (v);
 }
@@ -287,52 +244,19 @@ void _outl(unsigned long l, unsigned lon
 
 void _outb_p(unsigned char b, unsigned long port)
 {
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		_ne_outb(b, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		*(volatile unsigned char *)__port2addr_ata(port) = b;
-	} else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
-	} else
-#endif
-		*(volatile unsigned char *)PORT2ADDR(port) = b;
-
+	_outb(b, port);
 	delay();
 }
 
 void _outw_p(unsigned short w, unsigned long port)
 {
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		_ne_outw(w, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		*(volatile unsigned short *)__port2addr_ata(port) = w;
-	} else
-#endif
-#if defined(CONFIG_USB)
-	if(port >= 0x340 && port < 0x3a0)
-		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
-	else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
-	} else
-#endif
-		*(volatile unsigned short *)PORT2ADDR(port) = w;
-
+	_outw(w, port);
 	delay();
 }
 
 void _outl_p(unsigned long l, unsigned long port)
 {
-	*(volatile unsigned long *)PORT2ADDR(port) = l;
+	_outl(l, port);
 	delay();
 }
 
diff -ruNp a/arch/m32r/kernel/io_mappi.c b/arch/m32r/kernel/io_mappi.c
--- a/arch/m32r/kernel/io_mappi.c	2004-12-25 06:34:27.000000000 +0900
+++ b/arch/m32r/kernel/io_mappi.c	2005-06-03 11:50:15.000000000 +0900
@@ -3,8 +3,8 @@
  *
  *  Typical I/O routines for Mappi board.
  *
- *  Copyright (c) 2001, 2002  Hiroyuki Kondo, Hirokazu Takata,
- *                            Hitoshi Yamamoto
+ *  Copyright (c) 2001-2005  Hiroyuki Kondo, Hirokazu Takata,
+ *                           Hitoshi Yamamoto
  */
 
 #include <linux/config.h>
@@ -130,57 +130,21 @@ unsigned long _inl(unsigned long port)
 
 unsigned char _inb_p(unsigned long port)
 {
-	unsigned char  v;
-
-	if (port >= 0x300 && port < 0x320)
-		v = _ne_inb(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned char b;
-		pcc_ioread(0, port, &b, sizeof(b), 1, 0);
-		return b;
-	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-		unsigned char b;
-		pcc_ioread(1, port, &b, sizeof(b), 1, 0);
-		return b;
-	} else
-#endif
-		v = *(volatile unsigned char *)PORT2ADDR(port);
-
+	unsigned char v = _inb(port);
 	delay();
 	return (v);
 }
 
 unsigned short _inw_p(unsigned long port)
 {
-	unsigned short  v;
-
-	if (port >= 0x300 && port < 0x320)
-		v = _ne_inw(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned short w;
-		pcc_ioread(0, port, &w, sizeof(w), 1, 0);
-		return w;
-	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-		unsigned short w;
-		pcc_ioread(1, port, &w, sizeof(w), 1, 0);
-		return w;
-	} else
-#endif
-		v = *(volatile unsigned short *)PORT2ADDR(port);
-
+	unsigned short v = _inw(port);
 	delay();
 	return (v);
 }
 
 unsigned long _inl_p(unsigned long port)
 {
-	unsigned long  v;
-
-	v = *(volatile unsigned long *)PORT2ADDR(port);
+	unsigned long v = _inl(port);
 	delay();
 	return (v);
 }
@@ -229,41 +193,19 @@ void _outl(unsigned long l, unsigned lon
 
 void _outb_p(unsigned char b, unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
-		_ne_outb(b, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite(0, port, &b, sizeof(b), 1, 0);
-	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-		pcc_iowrite(1, port, &b, sizeof(b), 1, 0);
-	} else
-#endif
-		*(volatile unsigned char *)PORT2ADDR(port) = b;
-
+	_outb(b, port);
 	delay();
 }
 
 void _outw_p(unsigned short w, unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
-		_ne_outw(w, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite(0, port, &w, sizeof(w), 1, 0);
-	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
-		pcc_iowrite(1, port, &w, sizeof(w), 1, 0);
-	} else
-#endif
-		*(volatile unsigned short *)PORT2ADDR(port) = w;
-
+	_outw(w, port);
 	delay();
 }
 
 void _outl_p(unsigned long l, unsigned long port)
 {
-	*(volatile unsigned long *)PORT2ADDR(port) = l;
+	_outl(l, port);
 	delay();
 }
 
diff -ruNp a/arch/m32r/kernel/io_mappi2.c b/arch/m32r/kernel/io_mappi2.c
--- a/arch/m32r/kernel/io_mappi2.c	2005-06-02 12:09:20.000000000 +0900
+++ b/arch/m32r/kernel/io_mappi2.c	2005-06-03 11:52:20.000000000 +0900
@@ -3,7 +3,7 @@
  *
  *  Typical I/O routines for Mappi2 board.
  *
- *  Copyright (c) 2001-2003  Hiroyuki Kondo, Hirokazu Takata,
+ *  Copyright (c) 2001-2005  Hiroyuki Kondo, Hirokazu Takata,
  *                           Hitoshi Yamamoto, Mamoru Sakugawa
  */
 
@@ -169,64 +169,21 @@ unsigned long _inl(unsigned long port)
 
 unsigned char _inb_p(unsigned long port)
 {
-	unsigned char  v;
-
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		v = _ne_inb(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		return *(volatile unsigned char *)__port2addr_ata(port);
-	} else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned char b;
-		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-		return b;
-	} else
-#endif
-		v = *(volatile unsigned char *)PORT2ADDR(port);
-
+	unsigned char v = _inb(port);
 	delay();
 	return (v);
 }
 
 unsigned short _inw_p(unsigned long port)
 {
-	unsigned short  v;
-
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		v = _ne_inw(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		return *(volatile unsigned short *)__port2addr_ata(port);
-	} else
-#endif
-#if defined(CONFIG_USB)
-	if (port >= 0x340 && port < 0x3a0)
-		v = *(volatile unsigned short *)PORT2ADDR_USB(port);
-	else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned short w;
-		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-		return w;
-	} else
-#endif
-		v = *(volatile unsigned short *)PORT2ADDR(port);
-
+	unsigned short v = _inw(port);
 	delay();
 	return (v);
 }
 
 unsigned long _inl_p(unsigned long port)
 {
-	unsigned long  v;
-
-	v = *(volatile unsigned long *)PORT2ADDR(port);
+	unsigned long v = _inl(port);
 	delay();
 	return (v);
 }
@@ -284,52 +241,19 @@ void _outl(unsigned long l, unsigned lon
 
 void _outb_p(unsigned char b, unsigned long port)
 {
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		_ne_outb(b, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		*(volatile unsigned char *)__port2addr_ata(port) = b;
-	} else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
-	} else
-#endif
-		*(volatile unsigned char *)PORT2ADDR(port) = b;
-
+	_outb(b, port);
 	delay();
 }
 
 void _outw_p(unsigned short w, unsigned long port)
 {
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		_ne_outw(w, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		*(volatile unsigned short *)__port2addr_ata(port) = w;
-	} else
-#endif
-#if defined(CONFIG_USB)
-	  if (port >= 0x340 && port < 0x3a0)
-		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
-	else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
-	} else
-#endif
-		*(volatile unsigned short *)PORT2ADDR(port) = w;
-
+	_outw(w, port);
 	delay();
 }
 
 void _outl_p(unsigned long l, unsigned long port)
 {
-	*(volatile unsigned long *)PORT2ADDR(port) = l;
+	_outl(l, port);
 	delay();
 }
 
diff -ruNp a/arch/m32r/kernel/io_mappi3.c b/arch/m32r/kernel/io_mappi3.c
--- a/arch/m32r/kernel/io_mappi3.c	2005-06-02 12:09:20.000000000 +0900
+++ b/arch/m32r/kernel/io_mappi3.c	2005-06-03 12:02:39.000000000 +0900
@@ -162,64 +162,21 @@ unsigned long _inl(unsigned long port)
 
 unsigned char _inb_p(unsigned long port)
 {
-	unsigned char  v;
-
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		v = _ne_inb(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		return *(volatile unsigned char *)__port2addr_ata(port);
-	} else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned char b;
-		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-		return b;
-	} else
-#endif
-		v = *(volatile unsigned char *)PORT2ADDR(port);
-
+	unsigned char v = _inb(port);
 	delay();
 	return (v);
 }
 
 unsigned short _inw_p(unsigned long port)
 {
-	unsigned short  v;
-
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		v = _ne_inw(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		return *(volatile unsigned short *)__port2addr_ata(port);
-	} else
-#endif
-#if defined(CONFIG_USB)
-	if (port >= 0x340 && port < 0x3a0)
-		v = *(volatile unsigned short *)PORT2ADDR_USB(port);
-	else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned short w;
-		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-		return w;
-	} else
-#endif
-		v = *(volatile unsigned short *)PORT2ADDR(port);
-
+	unsigned short v = _inw(port);
 	delay();
 	return (v);
 }
 
 unsigned long _inl_p(unsigned long port)
 {
-	unsigned long  v;
-
-	v = *(volatile unsigned long *)PORT2ADDR(port);
+	unsigned long v = _inl(port);
 	delay();
 	return (v);
 }
@@ -277,52 +234,19 @@ void _outl(unsigned long l, unsigned lon
 
 void _outb_p(unsigned char b, unsigned long port)
 {
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		_ne_outb(b, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		*(volatile unsigned char *)__port2addr_ata(port) = b;
-	} else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
-	} else
-#endif
-		*(volatile unsigned char *)PORT2ADDR(port) = b;
-
+	_outb(b, port);
 	delay();
 }
 
 void _outw_p(unsigned short w, unsigned long port)
 {
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		_ne_outw(w, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
-	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
-		*(volatile unsigned short *)__port2addr_ata(port) = w;
-	} else
-#endif
-#if defined(CONFIG_USB)
-	  if (port >= 0x340 && port < 0x3a0)
-		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
-	else
-#endif
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
-	} else
-#endif
-		*(volatile unsigned short *)PORT2ADDR(port) = w;
-
+	_outw(w, port);
 	delay();
 }
 
 void _outl_p(unsigned long l, unsigned long port)
 {
-	*(volatile unsigned long *)PORT2ADDR(port) = l;
+	_outl(l, port);
 	delay();
 }
 
diff -ruNp a/arch/m32r/kernel/io_oaks32r.c b/arch/m32r/kernel/io_oaks32r.c
--- a/arch/m32r/kernel/io_oaks32r.c	2004-12-25 06:35:40.000000000 +0900
+++ b/arch/m32r/kernel/io_oaks32r.c	2005-06-03 11:54:39.000000000 +0900
@@ -3,7 +3,7 @@
  *
  *  Typical I/O routines for OAKS32R board.
  *
- *  Copyright (c) 2001-2004  Hiroyuki Kondo, Hirokazu Takata,
+ *  Copyright (c) 2001-2005  Hiroyuki Kondo, Hirokazu Takata,
  *                           Hitoshi Yamamoto, Mamoru Sakugawa
  */
 
@@ -90,35 +90,21 @@ unsigned long _inl(unsigned long port)
 
 unsigned char _inb_p(unsigned long port)
 {
-	unsigned char  v;
-
-	if (port >= 0x300 && port < 0x320)
-		v = _ne_inb(PORT2ADDR_NE(port));
-	else
-		v = *(volatile unsigned char *)PORT2ADDR(port);
-
+	unsigned char v = _inb(port);
 	delay();
 	return (v);
 }
 
 unsigned short _inw_p(unsigned long port)
 {
-	unsigned short  v;
-
-	if (port >= 0x300 && port < 0x320)
-		v = _ne_inw(PORT2ADDR_NE(port));
-	else
-		v = *(volatile unsigned short *)PORT2ADDR(port);
-
+	unsigned short v = _inw(port);
 	delay();
 	return (v);
 }
 
 unsigned long _inl_p(unsigned long port)
 {
-	unsigned long  v;
-
-	v = *(volatile unsigned long *)PORT2ADDR(port);
+	unsigned long v = _inl(port);
 	delay();
 	return (v);
 }
@@ -146,27 +132,19 @@ void _outl(unsigned long l, unsigned lon
 
 void _outb_p(unsigned char b, unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
-		_ne_outb(b, PORT2ADDR_NE(port));
-	else
-		*(volatile unsigned char *)PORT2ADDR(port) = b;
-
+	_outb(b, port);
 	delay();
 }
 
 void _outw_p(unsigned short w, unsigned long port)
 {
-	if (port >= 0x300 && port < 0x320)
-		_ne_outw(w, PORT2ADDR_NE(port));
-	else
-		*(volatile unsigned short *)PORT2ADDR(port) = w;
-
+	_outw(w, port);
 	delay();
 }
 
 void _outl_p(unsigned long l, unsigned long port)
 {
-	*(volatile unsigned long *)PORT2ADDR(port) = l;
+	_outl(l, port);
 	delay();
 }
 
diff -ruNp a/arch/m32r/kernel/io_opsput.c b/arch/m32r/kernel/io_opsput.c
--- a/arch/m32r/kernel/io_opsput.c	2004-12-25 06:35:00.000000000 +0900
+++ b/arch/m32r/kernel/io_opsput.c	2005-06-03 11:58:22.000000000 +0900
@@ -1,10 +1,10 @@
 /*
- *  linux/arch/m32r/kernel/io_mappi.c
+ *  linux/arch/m32r/kernel/io_opsput.c
  *
  *  Typical I/O routines for OPSPUT board.
  *
- *  Copyright (c) 2001, 2002  Hiroyuki Kondo, Hirokazu Takata,
- *                            Hitoshi Yamamoto, Takeo Takahashi
+ *  Copyright (c) 2001-2005  Hiroyuki Kondo, Hirokazu Takata,
+ *                           Hitoshi Yamamoto, Takeo Takahashi
  *
  *  This file is subject to the terms and conditions of the GNU General
  *  Public License.  See the file "COPYING" in the main directory of this
@@ -98,7 +98,6 @@ unsigned char _inb(unsigned long port)
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inb(PORT2ADDR_NE(port));
-
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 		unsigned char b;
@@ -118,7 +117,6 @@ unsigned short _inw(unsigned long port)
 	else if(port >= 0x340 && port < 0x3a0)
 		return *(volatile unsigned short *)PORT2ADDR_USB(port);
 #endif
-
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 		unsigned short w;
@@ -143,55 +141,21 @@ unsigned long _inl(unsigned long port)
 
 unsigned char _inb_p(unsigned long port)
 {
-	unsigned char  v;
-
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		v = _ne_inb(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned char b;
-		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-		return b;
-	} else
-#endif
-		v = *(volatile unsigned char *)PORT2ADDR(port);
-
+	unsigned char v = _inb(port);
 	delay();
 	return (v);
 }
 
 unsigned short _inw_p(unsigned long port)
 {
-	unsigned short  v;
-
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		v = _ne_inw(PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_USB)
-	if(port >= 0x340 && port < 0x3a0)
-		return *(volatile unsigned short *)PORT2ADDR_USB(port);
-	else
-#endif
-
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		unsigned short w;
-		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-		return w;
-	} else
-#endif
-		v = *(volatile unsigned short *)PORT2ADDR(port);
-
+	unsigned short v = _inw(port);
 	delay();
 	return (v);
 }
 
 unsigned long _inl_p(unsigned long port)
 {
-	unsigned long  v;
-
-	v = *(volatile unsigned long *)PORT2ADDR(port);
+	unsigned long v = _inl(port);
 	delay();
 	return (v);
 }
@@ -219,7 +183,6 @@ void _outw(unsigned short w, unsigned lo
 		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
 	else
 #endif
-
 #if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
@@ -240,43 +203,19 @@ void _outl(unsigned long l, unsigned lon
 
 void _outb_p(unsigned char b, unsigned long port)
 {
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		_ne_outb(b, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
-	} else
-#endif
-		*(volatile unsigned char *)PORT2ADDR(port) = b;
-
+	_outb(b, port);
 	delay();
 }
 
 void _outw_p(unsigned short w, unsigned long port)
 {
-	if (port >= LAN_IOSTART && port < LAN_IOEND)
-		_ne_outw(w, PORT2ADDR_NE(port));
-	else
-#if defined(CONFIG_USB)
-	if(port >= 0x340 && port < 0x3a0)
-		*(volatile unsigned short *)PORT2ADDR_USB(port) = w;
-	else
-#endif
-
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
-	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
-		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
-	} else
-#endif
-		*(volatile unsigned short *)PORT2ADDR(port) = w;
-
+	_outw(w, port);
 	delay();
 }
 
 void _outl_p(unsigned long l, unsigned long port)
 {
-	*(volatile unsigned long *)PORT2ADDR(port) = l;
+	_outl(l, port);
 	delay();
 }
 
diff -ruNp a/arch/m32r/kernel/io_usrv.c b/arch/m32r/kernel/io_usrv.c
--- a/arch/m32r/kernel/io_usrv.c	2004-12-25 06:35:25.000000000 +0900
+++ b/arch/m32r/kernel/io_usrv.c	2005-06-03 12:03:50.000000000 +0900
@@ -3,8 +3,8 @@
  *
  *  Typical I/O routines for uServer board.
  *
- *  Copyright (c) 2001 - 2003  Hiroyuki Kondo, Hirokazu Takata,
- *                             Hitoshi Yamamoto, Takeo Takahashi
+ *  Copyright (c) 2001-2005  Hiroyuki Kondo, Hirokazu Takata,
+ *                           Hitoshi Yamamoto, Takeo Takahashi
  *
  *  This file is subject to the terms and conditions of the GNU General
  *  Public License.  See the file "COPYING" in the main directory of this
@@ -39,7 +39,7 @@ extern void pcc_iowrite_word(int, unsign
 
 #define PORT2ADDR(port)	_port2addr(port)
 
-static __inline__ void *_port2addr(unsigned long port)
+static inline void *_port2addr(unsigned long port)
 {
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
 	if (port >= UART0_IOSTART && port <= UART0_IOEND)
@@ -50,7 +50,7 @@ static __inline__ void *_port2addr(unsig
 	return (void *)(port + NONCACHE_OFFSET);
 }
 
-static __inline__ void delay(void)
+static inline void delay(void)
 {
 	__asm__ __volatile__ ("push r0; \n\t pop r0;" : : :"memory");
 }
@@ -87,39 +87,22 @@ unsigned long _inl(unsigned long port)
 
 unsigned char _inb_p(unsigned long port)
 {
-	unsigned char b;
-
-	if (port >= CFC_IOSTART && port <= CFC_IOEND) {
-		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
-		return b;
-	} else {
-		b = *(volatile unsigned char *)PORT2ADDR(port);
-		delay();
-		return b;
-	}
+	unsigned char v = _inb(port);
+	delay();
+	return v;
 }
 
 unsigned short _inw_p(unsigned long port)
 {
-	unsigned short w;
-
-	if (port >= CFC_IOSTART && port <= CFC_IOEND) {
-		pcc_ioread_word(0, port, &w, sizeof(w), 1, 0);
-		return w;
-	} else {
-		w = *(volatile unsigned short *)PORT2ADDR(port);
-		delay();
-		return w;
-	}
+	unsigned short v = _inw(port);
+	delay();
+	return v;
 }
 
 unsigned long _inl_p(unsigned long port)
 {
-	unsigned long v;
-
-	v = *(volatile unsigned long *)PORT2ADDR(port);
+	unsigned long v = _inl(port);
 	delay();
-
 	return v;
 }
 
@@ -149,25 +132,19 @@ void _outl(unsigned long l, unsigned lon
 
 void _outb_p(unsigned char b, unsigned long port)
 {
-	if (port >= CFC_IOSTART && port <= CFC_IOEND)
-		pcc_iowrite_byte(0, port, &b, sizeof(b), 1, 0);
-	else
-		*(volatile unsigned char *)PORT2ADDR(port) = b;
+	_outb(b, port);
 	delay();
 }
 
 void _outw_p(unsigned short w, unsigned long port)
 {
-	if (port >= CFC_IOSTART && port <= CFC_IOEND)
-		pcc_iowrite_word(0, port, &w, sizeof(w), 1, 0);
-	else
-		*(volatile unsigned short *)PORT2ADDR(port) = w;
+	_outw(w, port);
 	delay();
 }
 
 void _outl_p(unsigned long l, unsigned long port)
 {
-	*(volatile unsigned long *)PORT2ADDR(port) = l;
+	_outl(l, port);
 	delay();
 }
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
