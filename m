Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUECPQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUECPQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 11:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbUECPQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 11:16:29 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:52352
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263743AbUECPQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 11:16:24 -0400
X-Mailer: Openwave WebEngine, version 2.8.11 (webedge20-101-194-20030622)
From: <shawn.starr@rogers.com>
To: <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.x i2c problems
Date: Mon, 3 May 2004 11:16:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [127.0.0.1] using ID <shawn.starr@rogers.com> at Mon, 3 May 2004 11:16:18 -0400
Message-Id: <20040503151618.QYCA64967.fep03-mail.bloor.is.net.cable.rogers.com@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experiencing problems with the PIIX4 i2c driver. I have an IBM system that works with lm-sensors fine - Thanks to Jean Delvare!

The machine has an lm80 sensor chip (as shown below)

lm80-i2c-0-28
Adapter: SMBus PIIX4 adapter at fe00
+5V:       +4.90 V  (min =  +4.74 V, max =  +5.25 V)   
VTT:       +1.72 V  (min =  +1.70 V, max =  +2.10 V)   
+3.3V:     +3.35 V  (min =  +3.14 V, max =  +3.47 V)   
+Vcore:    +1.98 V  (min =  +1.90 V, max =  +2.10 V)   
+12V:     +11.24 V  (min = +11.18 V, max = +12.63 V)   
-12V:     -11.88 V  (min = -12.60 V, max = -11.39 V)   
-5V:       -4.92 V  (min =  -5.25 V, max =  -4.76 V)   
fan1:     1804 RPM  (min = 1527 RPM, div = 4)          
temp:     +35.50 C (hot: limit = +60 C, hyst = +65 C) 
:                  (os:  limit = +54 C, hyst = +56 C) 


The problem is if you query the i2c/SMBus too many times over a period of time the bus will just fail as below:

I modified the i2c-piix4 driver to attempt to kill transactions on the SMBus if its stuck. It succeeds but the bus fails for some reason, did I forgot to set any other bits? 

If I adjust the query period ie in the lm80.c driver from 2 seconds to 5 seconds, the SMbus wont fail as quickly.

If I run watch -n2 sensors over a few minutes the bus will suddenly fail. Also oddly is when the bus fails and I reboot, the system fails to reset completely, BIOS doesn't even appear, if the SMBus does not fail I can reboot Linux without issue. 

I'm stuck and there seems to be odd conditions I've experienced including the onboard nic failing with the i2c driver loaded sometimes.

Apr 29 22:22:25 coredump kernel: IBM machine detected. Disabling SMBus accesses.

Why is this disabled? Can someone enlighten me (is this why im getting bus failures? is the SMBus on this IBM badly designed?)

Can the i2c people let me know what I may be doing wrong?

Thanks for any help anyone can provide. I'd like to fix the driver for other IBM people so they can also have sensor support.

Debug Output below:
===================

i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=2f, ADD=51, DAT0=c2, DAT1=00
i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=2f, ADD=51, DAT0=c2, DAT1=00
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=2e, ADD=51, DAT0=c2, DAT1=00
i2c_adapter i2c-0: SMBus busy (01). waiting...
i2c_adapter i2c-0: SMBus Busy: Wait State: HEX: 1, DEC: 1
i2c_adapter i2c-0: Killing SMBus Transactions!
i2c_adapter i2c-0: SMBus KILL STATUS BIT = 1
i2c_adapter i2c-0: SMBUS FAILED BIT = 0
i2c_adapter i2c-0: Error: Failed bus transaction
i2c_adapter i2c-0: Transaction (post): CNT=0a, CMD=2e, ADD=51, DAT0=c2, DAT1=00
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=23, ADD=51, DAT0=c2, DAT1=00
i2c_adapter i2c-0: SMBus busy (10). waiting...
i2c_adapter i2c-0: SMBus KILL STATUS BIT = 0
i2c_adapter i2c-0: SMBUS FAILED BIT = 0
i2c_adapter i2c-0: SMBus Timeout!
i2c_adapter i2c-0: Failed reset at end of transaction (01)
i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=23, ADD=51, DAT0=c2, DAT1=00
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=31, ADD=51, DAT0=c2, DAT1=00
i2c_adapter i2c-0: SMBus busy (01). waiting...
i2c_adapter i2c-0: SMBus Busy: Wait State: HEX: 1, DEC: 1
i2c_adapter i2c-0: Killing SMBus Transactions!
i2c_adapter i2c-0: SMBus KILL STATUS BIT = 1
i2c_adapter i2c-0: SMBUS FAILED BIT = 1
i2c_adapter i2c-0: SMBus KILL Successful!!
i2c_adapter i2c-0: RESULT: (10): Successfull!
i2c_adapter i2c-0: SMBHSTCNT Status
i2c_adapter i2c-0: Status Bits: KILLED=1
i2c_adapter i2c-0: Status Bits: INTERRUPT=0
i2c_adapter i2c-0: Status Bits: BUSY=0
i2c_adapter i2c-0: SMBHSTCNT Status - DOUBLE_CHECK
i2c_adapter i2c-0: Status KILLED=1
i2c_adapter i2c-0: Status INTERRUPT=0
i2c_adapter i2c-0: Status BUSY=0
i2c_adapter i2c-0: Error: Failed bus transaction
i2c_adapter i2c-0: Transaction (post): CNT=0a, CMD=31, ADD=51, DAT0=c2, DAT1=00
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=30, ADD=51, DAT0=c2, DAT1=00


