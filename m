Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261813AbSJQGUe>; Thu, 17 Oct 2002 02:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261815AbSJQGUe>; Thu, 17 Oct 2002 02:20:34 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:52733 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261813AbSJQGUd>; Thu, 17 Oct 2002 02:20:33 -0400
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15790.22703.244115.847023@sofia.bsd2.kbnes.nec.co.jp>
Date: Thu, 17 Oct 2002 15:29:03 +0900
To: linux-kernel@vger.kernel.org
Cc: brownfld@irridia.com
Subject: Problems in the sk98lin driver (2.5.43)
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following when I attempt to build it as a module (gcc-3.0.4):

make -f arch/i386/lib/Makefile modules_install
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b /var/tmp/kernel-2.5.43-root -r 2.5.43-1sb; fi
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.43-root/lib/modules/2.5.43-1sb/kernel/drivers/net/sk98lin/sk98lin.o
depmod:         __udivdi3

This is coming from line 1481 in drivers/net/sk98lin/skgepnmi.c(SkPnmiInit):
                pAC->Pnmi.StartUpTime = SK_PNMI_HUNDREDS_SEC(SkOsGetTime(pAC));

SkOsGetTime is defined to return an unsigned 64 bit integer, and
SK_PNMI_HUNDREDS_SEC is a macro which does (arg * 100) / 1000.  The
1000 is coming from HZ and this macro does not get defined when HZ is
exactly a 100.

When scanning this file, I found another potential problem.  The Vpd()
function consumes 2851 bytes on the stack in auto variables.

