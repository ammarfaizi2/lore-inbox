Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbRCIR6L>; Fri, 9 Mar 2001 12:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRCIR6C>; Fri, 9 Mar 2001 12:58:02 -0500
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:6597 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S130515AbRCIR5p>; Fri, 9 Mar 2001 12:57:45 -0500
Message-ID: <3AA918CF.DBCF3D6@pp.inet.fi>
Date: Fri, 09 Mar 2001 19:54:23 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Thomas Sailer <sailer@ife.ee.ethz.ch>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jari Anttonen <jari.anttonen@nic.fi>
Subject: [PATCH] 2.2.19pre hfmodem/refclock.c asm statement error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/hfmodem/refclock.c fails to compile with "gcc version 2.95.2
20000220 (Debian GNU/Linux)", but compiles normally with "gcc version
2.7.2.3". GNU assembler 2.9.5 was used in both cases. Here is the error
message:

refclock.c: In function `hfmodem_refclock_current':
refclock.c:136: Invalid `asm' statement:
refclock.c:136: fixed or forbidden register 0 (ax) was spilled for class AREG.

Here is the offending line:
__asm__("mull %2" : "=d" (tmp2), "=a" (tmp4) : "m" (scale_rdtsc), "1" (tmp0) : "ax");

It appears that above code declares register eax as output and globbered
register simultaneously. My gcc docs say: "You may not write a clobber
description in a way that overlaps with an input or output operand." Below
is a patch against 2.2.19pre16 to fix this. Please consider applying.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

--- linux-2.2.19pre16/drivers/char/hfmodem/refclock.c	Tue Jan  4 20:12:14 2000
+++ linux/drivers/char/hfmodem/refclock.c	Fri Mar  9 17:59:31 2001
@@ -133,7 +133,7 @@
 			"subl %2,%%eax\n\t"
 			"sbbl %3,%%edx\n\t" : "=&a" (tmp0), "=&d" (tmp1) 
 			: "m" (dev->clk.starttime_lo), "m" (dev->clk.starttime_hi));
-		__asm__("mull %2" : "=d" (tmp2), "=a" (tmp4) : "m" (scale_rdtsc), "1" (tmp0) : "ax");
+		__asm__("mull %2" : "=d" (tmp2), "=a" (tmp4) : "m" (scale_rdtsc), "1" (tmp0));
 		__asm__("mull %1" : "=a" (tmp3) : "m" (scale_rdtsc), "a" (tmp1) : "dx");
 		curtime = tmp2 + tmp3;
 		goto time_known;
