Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTGRMYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270228AbTGRMYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:24:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265069AbTGRMYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:24:41 -0400
Date: Fri, 18 Jul 2003 08:39:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Willy Tarreau <willy@w.ods.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20 RTC Timer bug
In-Reply-To: <20030718043129.GA3229@alpha.home.local>
Message-ID: <Pine.LNX.4.53.0307180834520.189@chaos>
References: <Pine.LNX.4.53.0307161626240.30604@chaos> <20030716211805.GB643@alpha.home.local>
 <Pine.LNX.4.53.0307170709080.682@chaos> <20030717191706.GA29208@alpha.home.local>
 <Pine.LNX.4.53.0307171624510.12702@chaos> <20030718043129.GA3229@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Willy Tarreau wrote:

> On Thu, Jul 17, 2003 at 04:38:05PM -0400, Richard B. Johnson wrote:
>
[SNIPPED...]

> > Or leaves the index register somewhere that a power-fail sequence will
> > trash a checksummed register..
>
> yes, that's possible too.
>
>
>
> is it in the spec that it has to be set to 0xFF or because you chose this
> value since it's out of the checksummed area ? On older chips, it will be
> equal to 0x3F (0xBF if we include NMI) and on newer ones, 0x7F. If the BIOS
> uses these bytes to write the checksum of the advanced setup, it might be
> dangerous. I would personaly prefer to set it to something not checked, such
> as the alarm, status, or so (except if the chip does a special case of FF).

Well, yes. It probably should be left at status register 'D'.  Here's
a patch. Let's see if the Linux folks accept it....

Problem:
Power failure can cause CMOS checksum corruption and failure to boot.
Patch (tested -- running now):


--- linux-2.4.20/include/asm-i386/mc146818rtc.h.orig	Thu Jul 17 15:06:33 2003
+++ linux-2.4.20/include/asm-i386/mc146818rtc.h	Fri Jul 18 08:01:58 2003
@@ -10,18 +10,28 @@
 #define RTC_PORT(x)	(0x70 + (x))
 #define RTC_ALWAYS_BCD	1	/* RTC operates in binary mode */
 #endif
+#define RTC_FAILSAFE  0x0d
+#define NMI_ENABLE    0x80

 /*
  * The yet supported machines all access the RTC index register via
  * an ISA port access but the way to access the date register differs ...
+ * Modified 18-JUL-2003
+ * Willy Tarreau <willy@w.ods.org>, Richard Johnson <rjohnson@analogic.com>
+ * Leave index register at status register D so a power failure doesn't
+ * corrupt checksummed CMOS. Keep NMI bit enabled (in case it really exists).
  */
 #define CMOS_READ(addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
-inb_p(RTC_PORT(1)); \
+int __val; \
+outb_p((addr)|NMI_ENABLE,RTC_PORT(0)); \
+__val = inb_p(RTC_PORT(1)); \
+outb_p(RTC_FAILSAFE|NMI_ENABLE, RTC_PORT(0)); \
+__val; \
 })
 #define CMOS_WRITE(val, addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
+outb_p((addr)|NMI_ENABLE,RTC_PORT(0)); \
 outb_p((val),RTC_PORT(1)); \
+outb_p(RTC_FAILSAFE|NMI_ENABLE, RTC_PORT(0)); \
 })

 #define RTC_IRQ 8




Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

