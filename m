Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUG1RaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUG1RaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUG1RaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:30:18 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:45222 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267165AbUG1RaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:30:10 -0400
From: jmerkey@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jmerkey@drdos.com
Subject: port of Kdebug - Linux 2.6 stability and performance issues
Date: Wed, 28 Jul 2004 17:30:08 +0000
Message-Id: <072820041730.18576.4107E2A00004C850000048902200748184970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have completed the port of the Kdebug kernel debugger to 2.6 and I have found 
a lot of areas where there are some stability issues.  The backtrace function in KDB 
and the backtrace function I use in MDB both have problems with __copy_to_user() causing 
system crashes if the debugger gets interrupted when in user space (0x40000000) 
code address ranges.  I am also seeing some severe performance issues with 
__copy_to_user() reading large numbers of small reads i.e. 4 byte reads at a 
time.  This is done in the debuggers to allow reads from memory to avoid crashes inside the 
debugger if for some reason you get a bad memory address when dumping memory or reading pointers, etc.   I have gone through all of the console code and I know the 
problem is not here since I use my own screen manager and basically push the 
Linux console code to the side so folks can use the debugger to debug console 
drivers, etc.  so I rely as little as possible on the Linux core code and MDB is 
basically a self contained "bubble" of code that hooks the IDT and exceptions to 
allow a much of Linux to be debugged.

I have also ported all the file systems and I must say, BIO performance is very 
stunning in lowering the submission overhead as reported by Linus and Jens, and 
I am seeing somewhat better I/O performance.  However, the keyboard driver has 
some problems with the rep flag loosing state in drivers/char/keyboard.c and 
__copy_to_user() performance absolutely **SUCKS** compared to 2.4.21.  with 
screen and backtrace displays with large numbers of small writes and reads.  I/O 
system is better but overall 2.6 does not appear very stable on 2.6 at present.

Does anyone have any ideas as to why we would see crashes in calls to 
__copy_to_user() which result in the system totally hanging up the system.

Jeff
